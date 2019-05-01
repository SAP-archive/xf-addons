# SAP Cloud for Customer Connector

## Overview

Establishing the connection between SAP Cloud for Customer solution and the SAP Cloud Platform Extension Factory allows you to develop Side-by-Side extensions. The SAP Cloud for Customer Connector facilitates a simple and secure way of pairing this solution with the Extension Factory which in turn leverages registering APIs and Events. 

## Prerequisites
* SAP Cloud for Customer version 1902 
* SAP Cloud Platform Extension Factory version 0.8 or higher
* [DST Root Certificate](https://www.identrust.com/dst-root-ca-x3)


## Scenario 

To establish the connection and allow data exchange between SAP Cloud for Customer and SAP Cloud Platform Extension Factory, perform the following steps using both systems. 

1. Create an Application using SAP Cloud Platform Extension Factory.
2. Configure trust settings in SAP Cloud for Customer.
3. Configure Event notification in SAP Cloud for Customer.
4. Expose APIs in SAP Cloud for Customer and create credentials.
5. Set up the SAP Cloud for Customer Connector to register APIs in the SAP Cloud Platform Extension Factory.


### Create an Application

1. Log in to the SAP Cloud Platform Extension Factory.
2. Go to **Integration** > **Applications** and create a new Application (if it does not exist yet).


### Configure trust settings

1. Log in to SAP Cloud for Customer frontend.
2. Go to **Administrator** > **Common Tasks** > **Edit Certificate Trust List**.
3. Upload the DST Root Certificate and make sure it appears on the list.

![Trust Certificate](assets/trust-certificate.png)

### Configure event notification

1. In the SAP Cloud for Customer frontend, go to **Administrator** > **General Settings** > **System Administration** > Event Notification.
2. Click **Add**.
3. Select consumer type, and then enter a Name and an Endpoint.

![Add Customer](assets/add-consumer.png)

4. **Edit** the consumer and click Edit Credentials to enter authentication details.
5. Go to **Subscriptions** > **Add**.
6. Select a Business Object and Node and then select at least one of Create, Update, or Delete.

![Add Subscription](assets/add-subscription.png)
7. Click **Add**.
8. Select the consumer and go to **Actions** > **Activate**.

### Expose APIs



### Set up the SAP Cloud for Customer Connector 

1. Log in to the SAP Cloud Platform Extension Factory.
2. Go to **Integration** > **Applications** and create a new Application (if it does not exist yet).
3. Go to **Service Catalog** > **Marketing Connector**.
4. Use the wizard to install and configure the SAP Marketing Connector:

    Parameter | Description |
    |---|---|
    |**System URL**|The base URL of the SAP Cloud for Customer instance. For example, `https://c4c.instance.sap.com` |
    |**Basic Auth Username** |The username for the Communication User in SAP Marketing Cloud. This is the Communication User that you have created in the [first step](#create-communication-user). It must already exist in SAP Cloud for Customer and be used for all of the Communication Arrangements (used to expose APIs) you want to register in the Extension Factory|
    |**Basic Auth Password** |The password of the Communication User in SAP Cloud for Customer|
    |**Application Name**   |The name of the Application CR where the ODATA services and the event catalog should be registered for consumption|