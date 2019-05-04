# SAP Marketing Connector

## Overview

The SAP Marketing Connector allows you to integrate an SAP Marketing Cloud instance by registering its ODATA services and Event catalog in an existing Application and activating Event sending. The integration uses the [extensibility features](https://help.sap.com/viewer/dbce7cc5e9e3469c84849d35e777fe0b/2019-05-07/en-US/363cf54bad2c47aeb44a87c215ad91ea.html) available in the SAP C/4HANA cockpit based on concepts and solutions from the open-source project "Kyma", so that you can easily develop Side-by-Side extensions. 

> **NOTE**: The integration is possible in the **preview** mode only. Do not use it in production scenarios.

## Prerequisites
* SAP Marketing Cloud version 1905 or higher
* "Kyma" version 1.0 or higher


## Scenario 

To establish the connection and allow data exchange between SAP Marketing Cloud and "Kyma", perform the following steps using SAP Marketing Cloud solution, SAP C/4HANA cockpit and Kyma Console.

1. [Create and configure a Communication User](#create-a-communication-user).
2. [Create a Communication System](#create-a-communication-system) which is the external system you want to integrate with the marketing solution. With the Communication System in place, SAP Marketing Cloud is able to send Events to "Kyma". 
3. [Create Communication Arrangements](#create-communication-arrangements) which help you to organize the data exchange between the external system and the marketing system. You need to set them up for all APIs you want to register in "Kyma".
4. Use the Kyma Console to [set up the SAP Marketing Connector](#set-up-the-sap-cloud-marketing-connector).
5. [Configure Business Events handling](#configure-business-events-handling) using the SAP_COM_0092 communication scenario for Enterprise Messaging Integration.


### Create a Communication User

1. Log in to the SAP Marketing Cloud frontend using the **SAP_BR_ADMINISTRATOR** role. Use the following credentials:
    * **User**: `Administrator`
    * **Password**: `Welcome1!`
2. Go to **Communication Management** > **Maintain Communication Users**.
3. Click **New**.
4. Enter the **User Name**, **Description**, and **Password**.

![Create Communication User](assets/communication-user.png)
5. Confirm with **Create**.

### Create a Communication System

1. Go to **Communication Management** > **Maintain Communication Systems**.
2. Click **New**.
3. Provide the **System ID**. It is the ID of the external system you want to connect to. Confirm with **Create**.
4. Configure the system by entering the following parameters:

    | Parameter    | Value |
    | --- | ---|
    | **Host Name**   | `event-bridge.<cluster_url>` |
    | **HTTPS Port**    | `443 `|
    | **Auth. Endpoint**| `https://mkt-oauth2-server/oauth/authorize`|
    | **Token Endpoint**| `https://mkt-oauth2-server/authorizationserver/oauth/token` |
    | **Inbound User** | `EXTFACTORY`   |
    | **Outbound User** |  Authentication Method: `OAuth 2.0` <br>OAuth 2.0 Client ID: `kyma` <br> Client Secret: `kyma123` |
    
![](assets/communication-system.png)


### Create Communication Arrangements

When creating a Communication Arrangement, you need to create a Communication Scenario. This scenario bundles inbound and outbound communication APIs and is the basis for communication between different systems. Each communication arrangement is based on a communication scenario.

Here are the Communication Scenarios for you to use:

* SAP_COM_0207 - Interaction Contact Integration
* SAP_COM_0204 - Marketing Campaigns Integration
* SAP_COM_0206 - Marketing Interaction Integration
* SAP_COM_0171 - Marketing Product Integration
* SAP_COM_0171 - Marketing Product Integration
* SAP_COM_0300 - Marketing External Recommendations Service
* SAP_COM_0003 - Marketing Master Data Integration
* SAP_COM_0306 - Marketing - Offers

Follow these steps to create Communication Arrangements:

1. Go to **Communication Management** > **Maintain Communication Arrangements**.
2. Click **New**.
3. Enter the **Scenario** code. The **Arrangement Name** is filled in automatically, but you can change it at any time. Confirm with **Create**.
3. Enter the parameters:
    |Parameter | Value|
    |--- | ---|
    |**Communication System**|`EXTFACTORY` |
    |**User Name** |`EXTFACTORY`|

    ![Communication Arrangements](assets/communication-arrangements.png)        


5. Save the configuration.

Establishing this Communication Arrangement allows registering the services listed under **Inbound Services** in the "Kyma". 

### Set up the SAP Marketing Connector

1. Navigate to the **Runtimes** view under **Extensibility** in SAP C/4HANA cockpit. If you need to provision the runtime, follow [these instructions](https://help.sap.com/viewer/dbce7cc5e9e3469c84849d35e777fe0b/2019-05-07/en-US/0bb50b27d76d4113ac32655f31777662.html).
3. Click **Kyma Console**.
4. In the Console, choose the Namespace, go to **Service Catalog** and select the SAP Marketing Connector.
5. Click **Add once** to install and configure the SAP Marketing Connector:

    |Parameter | Description |
    |---|---|
    |**System URL**|The base URL of the SAP Marketing Cloud instance you want to register. For example, `https://marketing.instance.sap.com` |
    |**Basic Auth Username** |The username for the Communication User in SAP Marketing Cloud. This is the Communication User that you have created in the [first step](#create-communication-user). It must already exist in SAP Marketing Cloud and be used for all of the Communication Arrangements (used to expose APIs) you want to register in "Kyma"|
    |**Basic Auth Password** |The password for the Communication User in SAP Marketing Cloud|
    |**OAuth2 client_id**    |The OAuth 2.0 Client ID for sending the MQTT events. The OAuth 2.0 credentials are required to configure the Communication Scenario|
    |**OAuth2 client_secret**| The OAuth 2.0 Client Secret for sending the MTTQ events |
    |**Application Name**   |The name of the Application CR where the ODATA services and the event catalog should be registered for consumption|
    |**Cluster Domain** |The domain of the cluster. For example, `demo.kyma.cx`|


6. Use the **Catalog** to view the newly registered Events and APIs.


### Configure Business Events handling

1. Log in to the SAP Marketing Cloud frontend.
1. Go to **Communication Management** > **Maintain Communication Arrangement**.
2. Create a new Communication Arrangement for Scenario SAP_COM_0092 (Enterprise Eventing Integration) using the following parameters:

    |Parameter| Value|
    |---|---|
    |Communication System|`EXTFACTORY`|
    |Channel             |`EXTFACTORY`|
    |Topic Space         |`EXTFACTORY`|

    ![SAP COM 0092](assets/sap_com_0092.png)
3. Log in to SAP Marketing Cloud with a user that has the **SAP_BR_BPC_EXPERT** role.
4. Go to **Implementation Cockpit** > **Manage Your Solution** > **Configure Your Solution**.
5. Search for **Event Handling** and select the entry.
![Event handling](assets/event-handling.png)
6. Go to **Configuration Steps** > **Maintain Event Topics** and click **Configure**.
7. Determine the Working Area. Set **Channel** to `EXTFACTORY` and confirm.
8. Select all the Marketing Business Events.
![Add topics](assets/add-topics.png)
9. Log in to SAP Marketing Cloud with a user that has the **SAP_BR_ADMINISTRATOR** role.
10. Go to **Business Event Handling** > **Business Event Subscription** and search for the Enterprise Eventing subscription.
11. Activate all Events.
![Enterprise messaging](assets/enterprise-messaging-subs.png)

The connection is set up. Business Events triggered in SAP Marketing Cloud will be sent to "Kyma".
