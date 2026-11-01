import ballerinax/github;

final github:Client github = check new ({
    auth: {
        token: githubAuthToken
    }
});
