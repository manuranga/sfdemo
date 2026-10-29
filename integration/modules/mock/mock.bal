import ballerina/crypto;
import ballerina/http;
import ballerina/lang.array;

// A stand-in for Salesforce: the token endpoint takes any client credentials,
// and the API echoes which ones it was called with (the secret as a SHA-256
// prefix), under the path segment the base URL names.
service on new http:Listener(9095) {
    resource function post [string tenant]/services/oauth2/token(@http:Header string authorization) returns json|error {
        string basic = authorization.substring("Basic ".length());
        string credentials = check string:fromBytes(check array:fromBase64(basic));
        int colon = <int>credentials.indexOf(":");
        string token = string `${tenant}|${credentials.substring(0, colon)}|${sha(credentials.substring(colon + 1))}`;
        return {access_token: token.toBytes().toBase64(), token_type: "Bearer", expires_in: 3600};
    }

    resource function get [string tenant]/services/data/[string version]/sobjects(@http:Header string authorization) returns json|error {
        string token = authorization.substring("Bearer ".length());
        string[] parts = re `\|`.split(check string:fromBytes(check array:fromBase64(token)));
        return {encoding: "UTF-8", maxBatchSize: 200, sobjects: [], tenant: parts[0], clientId: parts[1], clientSecretSha256: parts[2]};
    }
}

function sha(string s) returns string => crypto:hashSha256(s.toBytes()).toBase16().substring(0, 12);
