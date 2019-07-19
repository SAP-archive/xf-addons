# SAP Cloud for Customer Connector

## Overview


The SAP Cloud for Customer Connector allows you to integrate an SAP Cloud for Customer instance by registering its OData services and Event catalog in an existing Application and activating Event publishing. The integration uses the [extensibility features](https://help.sap.com/viewer/0815bc232f5140bba54a58ab15c82e99/Current/en-US/9ed15aa6eac34b948693955da0c90174.html) available in the SAP C/4HANA cockpit based on concepts and solutions from the open-source project "Kyma", so that you can easily develop Side-by-Side extensions. 

> **NOTE**: The integration is possible in the **preview** mode only. Do not use it in production scenarios.

## Prerequisites
* SAP Cloud for Customer version 1902 or higher
* "Kyma" version 1.0 or higher
* [DST Root Certificate](https://www.identrust.com/dst-root-ca-x3)


## Scenario 

To establish the connection and allow data exchange between SAP Cloud for Customer and "Kyma", perform the following steps using SAP Cloud for Customer, SAP C/4HANA cockpit and Kyma Console.


1. Configure trust settings in SAP Cloud for Customer.
2. Configure Event flow between SAP Cloud for Customer and "Kyma"
3. Create a User for OData access.
4. Set up the SAP Cloud for Customer Connector to register APIs in "Kyma".


### Configure trust settings

1. Log in to SAP Cloud for Customer frontend.
2. Go to **Administrator** > **Common Tasks** > **Edit Certificate Trust List**.
3. Upload the DST Root Certificate and make sure it appears on the list.

![Trust Certificate](assets/trust-certificate.png)

### Enable Event flow

1. Navigate to the **Runtimes** view under **Extensibility** in SAP C/4HANA cockpit and choose **DISPLAY NAME** of a given runtime to access its details.. If you need to provision the runtime, follow [these instructions](https://help.sap.com/viewer/dbce7cc5e9e3469c84849d35e777fe0b/Current/en-US/0bb50b27d76d4113ac32655f31777662.html).
2. Go to the **Registered Systems** view and choose **+**.
3. Enter the name of the system and choose **Register**. Your system is registered as an Application available in the Kyma Console. 
4. In Kyma Console, navigate to **Integration** > **Applications** > *select the newly registered system* > *click on* **Connect Application**, then copy the one-time temporary token.
5. In the SAP Cloud for Customer frontend, go to **Administrator** > **General Settings** > **System Administration** > **Event Notification**.
6. Click **Add**.
7. Select consumer type, provide a **Name** and use the copied token as the **Endpoint**.

![Add Consumer](assets/add-consumer.png)

4. **Edit** the consumer and click **Edit Credentials** to enter authentication details.
5. Go to **Subscriptions** > **Add**.
6. Select a Business Object and Node and then select at least one of Create, Update, or Delete.

![Add Subscription](assets/add-subscription.png)
7. Click **Add**.
8. Select the consumer and **Activate** it using the **Actions** menu.

### Create User for OData access

#### Create Service Agent User

1. Log in to SAP Cloud for Customer frontend.
2. Go to **Business Partners** > **Service Agents**.
3. Choose **New**, then **Service Agent**.
4. Enter the relevant data and save the configuration.
5. Choose **Request User**.

#### Assign Work Centers and Views

1. Go to **Application and User Management** > **User and Access Management** >  **Business Users**.
2. Choose the Business User you just created.
3. Choose **Edit** and select **Attributes**.
4. Enter and confirm the initial password.
5. Save your changes and choose **Edit Access Rights**.
6. Assign all work centers and views.

> **NOTE**: Assigning all work centers and views gives the user read and write access to all OData entities. If you want to restrict the priviledges, expand the work center to see all the associated views and assign a subset of the views within a work center.

### Set up the SAP Cloud for Customer Connector 

1. Navigate to the **Runtimes** view under **Extensibility** in SAP C/4HANA cockpit.
3. Click **Kyma Console**.
4. In the Console, choose the Namespace, go to **Catalog** and select **[Preview] SAP Cloud for Customer - Connector**.
5. Click **Add once** to install and configure the SAP Cloud for Customer Connector:

    Parameter | Description |
    |---|---|
    |**System URL**|The base URL of the SAP Cloud for Customer instance. For example, `https://myXXXXX.crm.ondemand.com` |
    |**Basic Auth Username** |The user name set for the Business User in SAP Cloud for Customer created in Step 3.|
    |**Basic Auth Password** |The password set for the Business User in SAP Cloud for Customer.|
    |**Application Name**   |The name of the Kyma Application CR where the OData services and the Event catalog should be registered for consumption|
