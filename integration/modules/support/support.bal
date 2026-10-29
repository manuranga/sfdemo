import ballerinax/salesforce;

// A second connection of the same resource type, in a submodule (renamed from sfSupport, then sfHelpdesk).
configurable string sfDeskBaseUrl = ?;
configurable string sfDeskAuthTokenUrl = ?;
configurable string sfDeskAuthClientId = ?;
configurable string sfDeskAuthClientSecret = ?;

public function organization() returns salesforce:OrganizationMetadata|error {
    salesforce:Client sfDesk = check new ({
        baseUrl: sfDeskBaseUrl,
        auth: {tokenUrl: sfDeskAuthTokenUrl, clientId: sfDeskAuthClientId, clientSecret: sfDeskAuthClientSecret}
    });
    return sfDesk->getOrganizationMetaData();
}
