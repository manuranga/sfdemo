import ballerinax/salesforce;

final salesforce:Client sfDesk = check new ({
    baseUrl: sfDeskBaseUrl,
    auth: {
        tokenUrl: sfDeskAuthTokenUrl,
        clientId: sfDeskAuthClientId,
        clientSecret: sfDeskAuthClientSecret
    }
});
