#!/usr/bin/env groovy
isRelease=env.TAG_NAME
appVersion=isRelease?env.TAG_NAME:env.BRANCH_NAME

properties([
    buildDiscarder(logRotator(numToKeepStr: '30')),
])

pipeline {
    agent {
        node {
            label 'docker'
        }
    }
    stages {
        stage('Checkout')
        {
            steps {
                script{
                    checkout scm
                }
            }
        }
        stage('Check Assets'){
            steps {
                script{
                    sh "make check"
                }
            }
        }
        stage('Prepare Assets'){
            steps {
                script{
                    sh "make prepare"
                }
            }
        }
        stage('Push to Bucket for master'){
            steps{
                script{
                    if(env.TAG_NAME)
                    {
                        upload('prod')
                    }
                    else if(env.BRANCH_NAME=="master"){
                         upload('int')
                    }
                    else
                    {
                         upload('stage')
                    }
                }
            }
       }
    }
}

void upload(String env){
    echo "Uploading to ${env} bucket"
    withCredentials([string(credentialsId: "xf-addons-${env}-bucket-url", variable: 'UPLOAD_URL')]) {
        withCredentials([string(credentialsId: "xf-addons-${env}-bucket-key", variable: 'KEYS')]) {
            dir = pwd()
            sh "echo '$KEYS' > key.json"
            try{
                sh "make upload UPLOAD_URL=$UPLOAD_URL"
            }finally{
                sh "rm key.json"
            }
        }
    }
}