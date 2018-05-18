# Overview

This is an nginx proxy that proxies content from an S3 bucket.

This was taken from 18F/

The proxy has two configurable routing paths. The first path is to route all requests from a `BASE_DOMAIN` (such as `18f.gsa.gov`) to a specific path on a S3 bucket, defined by `PROXY_ROOT` (such as `http://<xxx>.s3-website-us-east-1.amazonaws.com/`).

## Configuration

Configuration is handled by environment variables. The following variables are available:

* `BASE_DOMAIN`: Requests on this domain are routed to the root of `PROXY_ROOT`
* `PROXY_ROOT`: The URL from which requests should be proxied; may include subdirectories
* `PORT`: The port on which the server should listen; set automatically by cloud.gov
* `GZIP_COMPRESS`: If `true`, responses will be GZIP'd; False by default since Federalist does this automatically
* `CACHE_EXPIRES`: The value for the `expires` header
