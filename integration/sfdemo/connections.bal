import ballerinax/salesforce;

final salesforce:Client sfCrm = check new ({
    baseUrl: sfCrmBaseUrl,
    auth: {
        tokenUrl: sfCrmAuthTokenUrl,
        clientId: sfCrmAuthClientId,
        clientSecret: sfCrmAuthClientSecret
    }
});
final salesforce:Client sfDesk = check new ({
    baseUrl: sfDeskBaseUrl,
    auth: {
        tokenUrl: sfDeskAuthTokenUrl,
        clientId: sfDeskAuthClientId,
        clientSecret: sfDeskAuthClientSecret
    }
});
