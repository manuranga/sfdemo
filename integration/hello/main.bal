import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get hello() returns string|error {
        do {
            return "Hello, World!";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
