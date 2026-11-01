import ballerina/crypto;
import ballerina/http;
import ballerinax/github;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get whoami() returns json|error {
        string tokenSha256 = crypto:hashSha256(ghAuthToken.toBytes()).toBase16().substring(0, 8);
        github:UserResponse|error? user = gh->/user();
        if user is github:UserResponse {
            return {login: user.login, tokenSha256};
        }
        return error(string `GitHub returned no user for the token whose SHA-256 starts with ${tokenSha256}`, user);
    }

    resource function get orders\-db() returns json {
        return {configured: ordersUrl != ""};
    }
}
