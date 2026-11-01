# sfdemo

A sample integration that reads Salesforce organization metadata through two connections, and a mock Salesforce to run it against.

| Directory | What it is |
|---|---|
| [`integration/`](integration/) | The integration, a WSO2 Integrator project: package `acme/sfdemo` in [`integration/sfdemo`](integration/sfdemo). `GET /sales` and `GET /support` call Salesforce through the connections `sfSales` and `sfDesk`. |
| [`integration/ghdemo`](integration/ghdemo) | A second integration, package `acme/ghdemo`. `GET /whoami` calls GitHub through the connection `github` and answers with the token owner's login and the first 8 hex characters of the token's SHA-256, which tell you which token it received. |
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

Start the mock, then create `integration/sfdemo/Config.toml` (it is git-ignored) with each connection's values:

```toml
sfSalesBaseUrl = "http://localhost:9095/sales"
sfSalesAuthTokenUrl = "http://localhost:9095/sales/services/oauth2/token"
sfSalesAuthClientId = "sales-client"
sfSalesAuthClientSecret = "sales-secret"
sfDeskBaseUrl = "http://localhost:9095/support"
sfDeskAuthTokenUrl = "http://localhost:9095/support/services/oauth2/token"
sfDeskAuthClientId = "support-client"
sfDeskAuthClientSecret = "support-secret"
```

Then run it from WSO2 Integrator, or with `bal run` in `integration/sfdemo`, and call `http://localhost:9090/sales`.

For ghdemo, create `integration/ghdemo/Config.toml` (also git-ignored) with a GitHub token, run it in `integration/ghdemo`, and call `http://localhost:9090/whoami`:

```toml
githubAuthToken = "<a GitHub token>"
```
