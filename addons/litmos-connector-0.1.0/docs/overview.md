---
title: Overview
type: Details
---

## Training in the Now

SAP Litmos enables global companies to deliver training in the now. The solution is comprised of a powerful LMS, a commerce platform, and a content-rich course catalog that make it easy to manage the entire learning program from system implementation and integration to ongoing administration. More at https://www.litmos.com

## API Usage

Use the **SAP Litmos Connector** to connect to SAP Litmos system and be able to make API calls to the SAP Litmos system from a lambda or a microservice. A sample URL to perform CRUD on Litmos Teams would be `process.env[{PREFIX}-GATEWAY_URL] + "/teams"`.
Note that `PREFIX` is optional and used when specified while creating a service binding.

## Event Gateway

The connector will deploy an HTTP gateway that takes [Litmos webhook payloads](https://support.litmos.com/hc/en-us/articles/360022948994-Webhooks) and converts them to Kyma events.

The HTTP URL for the webhook will be of the form <https://litmos-event-gw-{addon-namespace}-{KYMA CLUSTER DOMAIN}>. The event gateway is exposed as a Kyma API. One can find it in the `addon-namespace --> APIs`.
