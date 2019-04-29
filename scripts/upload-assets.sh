#!/usr/bin/env bash

gcloud auth activate-service-account --key-file=/project/key.json
gsutil -m cp -r /project/dist/* $1
