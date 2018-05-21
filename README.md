# Overview

This is an nginx proxy that proxies large binary data (ex. PDFs) from an S3 bucket.

Provided a S3 bucket (private or public), the proxy is used to simply re-route the URL (via proxy_pass) to the S3 bucket resource.

The proxy route all requests to a specific path on a S3 bucket, defined by `NGINX_S3_BUCKET` (such as `http://<xxx>.s3-website-us-east-1.amazonaws.com/`).

## Configuration

Configuration is handled by environment variables. The following variables are available:

* `NGINX_LISTEN_PORT`: The port in which this nginx proxy is listening to
* `NGINX_S3_BUCKET`: The S3 bucket URL where the the resources are stored - (ex. `http://<xxx>.s3-website-us-east-1.amazonaws.com/`).

## Presign URL for AWS S3 resources

The normal use case is that a presigned URL will be generated so that the proxy does not need to know anything about authentication with AWS.

By default, the presign URL expires in an hour.

```sh
aws s3 presign s3://mybucket/myobject
```

This will generate a URL that will expire in 300 seconds.

```sh
aws s3 presign s3://mybucket/myobject --expires-in 300
```

## Building the configuration

There is a `build.sample.sh` script used for building the `nginx.conf` file.

Essentially, it replaces all the [Nginx](https://www.nginx.com/) configuration.

```sh
cp build.sample.sh build.sh
```

* Modify build.sh with your environment variables.

```
sh build.sh
```

The `nginx.conf` will appear in the local directory.

## Deployment

### Local

For local deployment, I simply use a slim [Docker](https://www.docker.com/) image for mostly testing purposes.

Here's a quick and dirty script for testing (using port in build.sample.sh).

```sh
sh build.sh
docker run --name some-nginx -p 3001:8000 -v $PWD/nginx.conf:/etc/nginx/nginx.conf -d nginx:1.13.12-alpine
```

At this point, you should be able to go to `localhost:3001` and get an Access Denied message.

Append the resource URL from the presign URL `localhost:3001/<resource>` to get to your file.

