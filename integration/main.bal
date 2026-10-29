import ballerina/http;
import ballerinax/salesforce;
import sfdemo.mock as _;
import sfdemo.support;

// One configurable per connector init field, named <connection><Field>.
configurable string sfSalesBaseUrl = ?;
configurable string sfSalesAuthTokenUrl = ?;
configurable string sfSalesAuthClientId = ?;
configurable string sfSalesAuthClientSecret = ?;

// Filled by hand in the Configure form, not by a link.
configurable string greeting = "hello";

service / on new http:Listener(8090) {
    resource function get sales() returns json|error {
        // Created per call: the client fetches a token as it starts, and the
        // mock Salesforce in this program listens only once startup is done.
        salesforce:Client sfSales = check new ({
            baseUrl: sfSalesBaseUrl,
            auth: {tokenUrl: sfSalesAuthTokenUrl, clientId: sfSalesAuthClientId, clientSecret: sfSalesAuthClientSecret}
        });
        salesforce:OrganizationMetadata org = check sfSales->getOrganizationMetaData();
        return {greeting, org};
    }

    resource function get support() returns json|error {
        return {greeting, org: check support:organization()};
    }
}
