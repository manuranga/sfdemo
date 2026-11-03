import ballerina/crypto;
import ballerinax/salesforce;

// One configurable per connector init field, named <connection><Field>.
configurable string sfSalesBaseUrl = ?;
configurable string sfSalesAuthTokenUrl = ?;
configurable string sfSalesAuthClientId = ?;
configurable string sfSalesAuthClientSecret = ?;

final salesforce:ConnectionConfig sfSales = {
    baseUrl: sfSalesBaseUrl,
    auth: {tokenUrl: sfSalesAuthTokenUrl, clientId: sfSalesAuthClientId, clientSecret: sfSalesAuthClientSecret}
};

// What the connection received, the secret as a SHA-256 prefix.
function sfSalesValues() returns map<string> => {
    baseUrl: sfSalesBaseUrl,
    tokenUrl: sfSalesAuthTokenUrl,
    clientId: sfSalesAuthClientId,
    clientSecretSha256: crypto:hashSha256(sfSalesAuthClientSecret.toBytes()).toBase16().substring(0, 12)
};
