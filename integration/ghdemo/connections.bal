import ballerinax/github;

final github:Client gh = check new ({
    auth: {
        token: ghAuthToken
    }
});
