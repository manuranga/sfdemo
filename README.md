# sfdemo

A sample integration that reads Salesforce organization metadata through two connections, and a mock Salesforce to run it against.

| Directory | What it is |
|---|---|
| [`integration/`](integration/) | The integration: a WSO2 Integrator project (Ballerina). `GET /sales` and `GET /support` call Salesforce through the connections `sfSales` and `sfDesk`. |
| [`mock-salesforce/`](mock-salesforce/) | A Node.js stand-in for Salesforce's token endpoint and API. It is not part of the integration and runs on its own. |

## The mock

```sh
cd mock-salesforce
npm start          # listens on :9095, or $PORT
```

- `POST /<tenant>/services/oauth2/token` accepts any client credentials (HTTP Basic or form).
- `GET /<tenant>/services/data/<version>/sobjects` answers with the tenant, the client ID, and a SHA-256 prefix of the client secret the token was issued for.

So a connection's base URL, `https://<mock host>/<tenant>`, and its credentials show up in the integration's response, which tells you which values each connection received.
