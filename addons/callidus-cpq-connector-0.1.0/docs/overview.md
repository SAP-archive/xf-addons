---
title: Installation
type: Details
---

The SAP Callidus CPQ Connector allows you to integrate a SAP Callidus CPQ tenant by registering its APIs.  The integration uses the [extensibility features](https://help.sap.com/viewer/0815bc232f5140bba54a58ab15c82e99/Current/en-US/9ed15aa6eac34b948693955da0c90174.html) available in the SAP C/4HANA cockpit based on concepts and solutions from the open-source project "Kyma", so that you can easily develop Side-by-Side extensions. 

> **NOTE**: The integration is possible in the **preview** mode only. Do not use it in production scenarios.

## Set up the SAP Callidus CPQ Connector 

1. Navigate to the **Runtimes** view under **Extensibility** in SAP C/4HANA cockpit and click on the cluster that you will be using
2. Register a new system providing an appropriate name (e.g. 'callidus-cpq')
3. Click **Kyma Console**.
4. In the Console, choose the Namespace, go to **Catalog** and select **[Preview] SAP Callidus CPQ - Connector**.
5. Click **Add once** to install and configure the SAP Callidus CPQ Connector:

    | Parameter            | Description                                                                      |
    | -------------------- | -------------------------------------------------------------------------------- |
    | **Application Name** | The name of the registered system from step 2.                                   |
    | **Cluster Domain**   | The domain of the Kyma cluster. For example, `demo.cluster.extend.cx.cloud.sap`  |
    | **Password**         | The password for API authentication                                              |
    | **System URL**       | The URL of your SAP Callidus CPQ tenant. For example `https://dev.webcomcpq.com` |
    | **Username**         | The username for API authentication                                              |


## Set up the SAP Callidus CPQ Events 
Refer to the **Setting up Subscription to Events** instructions found at
https://help.webcomcpq.com/doku.php?id=adminhelp:crmintegrationsetup:subscription_to_events

For the Authentication type choose Basic and use the following values.

    | Parameter               | Value                                                |
    | ----------------------- | ---------------------------------------------------- |
    | **Webhook URL**         | https://cc-cpq-event-gw-<namespace>.<cluster domain> |
    | **Webhook HTTP method** | POST                                                 |
    | **Username**            | The username used for API authentication             |
    | **Password**            | The password used for API authentication             |

The Username and Password values will be defaulted to the same used for API authentication.  These can be changed by modifying the secret 	**callidus-cpq-connector-cc-cpq-event-gw** found in the namespace where the connector has been provisioned.  Restart the event gw pod after making any changes.