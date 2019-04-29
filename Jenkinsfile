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
                    if(env.BRANCH_NAME=="master"){
                         withCredentials([string(credentialsId: 'xf-addons-upload-bucket', variable: 'UPLOAD')]) {
                            withCredentials([usernamePassword(credentialsId: 'gcp-storage-faros-pre-prod', usernameVariable: 'USER', passwordVariable: 'KEYS')]) {
                                dir = pwd()
                                sh "echo '$KEYS' > key.json"
                                try{
                                    sh "make upload UPLOAD=$UPLOAD"
                                }finally{
                                    sh "rm key.json"
                                }
                            }
                         }
                    }
                }
            }
       }
    }
}