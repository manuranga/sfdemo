import ballerina/crypto;
import ballerina/log;
import ballerinax/github;

public function main() returns error? {
    do {
        string tokenSha256 = crypto:hashSha256(githubAuthToken.toBytes()).toBase16().substring(0, 8);
        github:UserResponse? user = check github->/user();
        if user is () {
            return error(string `GitHub returned no user for the token whose SHA-256 starts with ${tokenSha256}`);
        }
        log:printInfo("GitHub answered", login = user.login, tokenSha256 = tokenSha256);
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
