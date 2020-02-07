
// This is a lambda code to be copied into the CDS enricher workbench.

async function processAsyncEvent(event, context) {
    try {
        const { data } = event
        var contextName=event.metadata.schema.replace(`${context.environmentUrl}metamodel/v1/`, '').split("/")
        var eventName = contextName[contextName.length-1]
        var json = { };
        json[eventName] = {
            "profileId":event.metadata.profileId
        };

        var eventBody =json
        var kymaObject = {
            "event-type":eventName,
            "event-details":{
                "events": eventBody
            }
        }

        sdk.logger.info("event"+JSON.stringify(kymaObject))
        await sendEvent();
    } catch (e) {
        sdk.logger.error(e.message);
        throw e;
    }
}


async function sendEvent(kymaObject){
    var endpointURL = "your_kyma_event_gw_url"
    const headers = {
        'Content-Type': 'application/json',
    };
    const options = {
        headers,
        json: kymaObject,
    };

    // POST request to kyma events endpoint
    try {
        const postRequest = await sdk.http.get(endpointURL, options, false);
        if (postRequest.statusCode >= 400 && postRequest.statusCode <= 600) {
            sdk.logger.error(`post response: ${postRequest.statusCode} - body: ${postRequest.body}`);
        } else {
            sdk.logger.debug(`post response: ${postRequest.statusCode} - body: ${postRequest.body}`);
        }
    } catch (err) {
        sdk.logger.error(`Error calling kyma event endpoint ${JSON.stringify(err)}`, err);
    }
}