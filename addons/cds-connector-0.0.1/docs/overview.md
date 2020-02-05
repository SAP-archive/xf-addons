---
title: Overview
type: Overview
---

Use **CDS Connector** to connect your CDS backend with Kyma events to trigger serverless compute and make API calls from a lambda or a microservice.

**Prerequisite**

It uses the API token for makinng API calls to CDS. Please provide the clientId and clientSecret in the form parameters field in following format 'client_id=id,grant_type=client_credentials,client_secret=secret'

After adding this addon in the namespace, copy the http url of event-gw lambda  and provide it in the lambda running on CDS.


