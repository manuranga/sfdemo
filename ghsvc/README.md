# ghsvc

A busybox httpd whose /cgi-bin/env lists the GH_* and GITHUB_* environment variables it was given, each with the first 8 hex digits of its value's SHA-256.
