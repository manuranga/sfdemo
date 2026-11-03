import ballerina/log;
import ballerina/mcp;

listener mcp:StreamableHttpListener mcpListener = new (8090);

function init() {
    log:printInfo("sfSales", values = sfSalesValues(), baseUrl = sfSales.baseUrl);
}

@mcp:ServiceConfig {info: {name: "sfmcp", version: "0.1.0"}}
service mcp:Service /mcp on mcpListener {
    # What the Salesforce connection received.
    # + return - The connection's values, the secret as a SHA-256 prefix
    remote function connectionValues() returns map<string> => sfSalesValues();
}
