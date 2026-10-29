// A stand-in for Salesforce. The token endpoint accepts any client credentials;
// the API answers with the tenant (the first path segment of the base URL), the
// client ID and a SHA-256 prefix of the client secret it was called with.
import { createHash } from 'node:crypto';
import { createServer } from 'node:http';

const port = Number(process.env.PORT ?? 9095);

createServer(async (req, res) => {
  const url = new URL(req.url, 'http://localhost');
  const [tenant, ...rest] = url.pathname.split('/').filter(Boolean);
  const path = rest.join('/');
  if (req.method === 'POST' && path === 'services/oauth2/token') {
    const { clientId, clientSecret } = clientCredentials(req.headers.authorization, await body(req));
    const token = [tenant, clientId, sha(clientSecret)].join('|');
    return send(res, 200, { access_token: Buffer.from(token).toString('base64'), token_type: 'Bearer', expires_in: 3600 });
  }
  if (req.method === 'GET' && /^services\/data\/[^/]+\/sobjects$/.test(path)) {
    const bearer = (req.headers.authorization ?? '').replace(/^Bearer /, '');
    const [tokenTenant, clientId, clientSecretSha256] = Buffer.from(bearer, 'base64').toString().split('|');
    if (tokenTenant !== tenant) return send(res, 401, [{ errorCode: 'INVALID_SESSION_ID', message: 'Session expired or invalid' }]);
    return send(res, 200, { encoding: 'UTF-8', maxBatchSize: 200, sobjects: [], tenant, clientId, clientSecretSha256 });
  }
  send(res, 404, [{ errorCode: 'NOT_FOUND', message: 'The requested resource does not exist' }]);
}).listen(port, () => console.log(`mock Salesforce on :${port}`));

// Client credentials arrive in a Basic header or in the form body.
function clientCredentials(authorization, form) {
  if (authorization?.startsWith('Basic ')) {
    const decoded = Buffer.from(authorization.slice(6), 'base64').toString();
    const colon = decoded.indexOf(':');
    return { clientId: decoded.slice(0, colon), clientSecret: decoded.slice(colon + 1) };
  }
  const params = new URLSearchParams(form);
  return { clientId: params.get('client_id') ?? '', clientSecret: params.get('client_secret') ?? '' };
}

async function body(req) {
  let data = '';
  for await (const chunk of req) data += chunk;
  return data;
}

function send(res, status, json) {
  res.writeHead(status, { 'content-type': 'application/json' });
  res.end(JSON.stringify(json));
}

function sha(s) {
  return createHash('sha256').update(s).digest('hex').slice(0, 12);
}
