import ballerina/crypto;
import ballerina/http;
import ballerinax/github;

listener http:Listener httpDefaultListener = http:getDefaultListener();

// Only the GitHub connector's config type, with no client, so the build records ballerinax/github.
final github:ConnectionConfig githubConfig = {auth: {token: githubAuthToken}};

service / on httpDefaultListener {
    resource function get hello() returns json {
        string tokenSha256 = crypto:hashSha256(githubAuthToken.toBytes()).toBase16().substring(0, 8);
        return {greeting, tokenSha256};
    }
}
