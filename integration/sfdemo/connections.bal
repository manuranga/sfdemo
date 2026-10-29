import ballerinax/salesforce;

final salesforce:Client sfSales = check new ({
    baseUrl: sfSalesBaseUrl,
    auth: {
        tokenUrl: sfSalesAuthTokenUrl,
        clientId: sfSalesAuthClientId,
        clientSecret: sfSalesAuthClientSecret
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
