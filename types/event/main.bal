import ballerina/http;
import ballerina/log;

function init() {
    log:printInfo("sfSales", values = sfSalesValues(), baseUrl = sfSales.baseUrl);
}

// Events arrive as webhook calls; GET /values shows what the connection received.
service / on new http:Listener(8090) {
    resource function post events(@http:Payload json event) returns map<string> {
        log:printInfo("event", event = event);
        return sfSalesValues();
    }

    resource function get values() returns map<string> => sfSalesValues();
}
