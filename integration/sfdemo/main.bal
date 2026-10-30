import ballerina/http;
import ballerinax/salesforce;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get sales() returns json|error {
        do {
            salesforce:OrganizationMetadata org = check sfCrm->getOrganizationMetaData();
            return {greeting, org};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

    resource function get support() returns json|error {
        do {
            salesforce:OrganizationMetadata org = check sfDesk->getOrganizationMetaData();
            return {greeting, org};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
