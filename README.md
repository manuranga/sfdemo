# sfdemo

A sample integration that reads Salesforce organization metadata through two connections, and a mock Salesforce to run it against.

| Directory | What it is |
|---|---|
| [`integration/`](integration/) | The integration, Ballerina package `wso2/sfdemo` on Ballerina 2201.12. `GET /sales` and `GET /support` call Salesforce through the connections `sfSales` and `sfDesk` (in module `support`). |
| [`mock-salesforce/`](mock-salesforce/) | A Node.js stand-in for Salesforce's token endpoint and API. It is not part of the integration and runs on its own. |

## The mock

```sh
cd mock-salesforce
npm start          # listens on :9095, or $PORT
```

- `POST /<tenant>/services/oauth2/token` accepts any client credentials (HTTP Basic or form).
- `GET /<tenant>/services/data/<version>/sobjects` answers with the tenant, the client ID, and a SHA-256 prefix of the client secret the token was issued for.

So a connection's base URL, `https://<mock host>/<tenant>`, and its credentials show up in the integration's response, which tells you which values each connection received.

## Running the integration locally

Start the mock, then create `integration/Config.toml` (it is git-ignored) with each connection's values:

```toml
sfSalesBaseUrl = "http://localhost:9095/sales"
sfSalesAuthTokenUrl = "http://localhost:9095/sales/services/oauth2/token"
sfSalesAuthClientId = "sales-client"
sfSalesAuthClientSecret = "sales-secret"

[wso2.sfdemo.support]
sfDeskBaseUrl = "http://localhost:9095/support"
sfDeskAuthTokenUrl = "http://localhost:9095/support/services/oauth2/token"
sfDeskAuthClientId = "support-client"
sfDeskAuthClientSecret = "support-secret"
```

Then run it with `bal run` in `integration`, and call `http://localhost:8090/sales`.
