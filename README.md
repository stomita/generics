# SiteGenerics

An open source tool to easily create mobile-ready web site based on Salesforce-stored data

## Service

Running on Heroku:

https://generics-app.herokuapp.com

## Setup

Make sure npm and grunt is installed.

```
npm install
grunt build
```

Then run application using node command
```
node app.js
```

You need to set environment variables to get connected to services.
```
SF_CLIENT_ID="client id for OAuth2 client for Salesforce API"
SF_CLIENT_SECRET="client secret for OAuth2 client for Salesforce API"
SF_REDIRECT_URI="redirect uri for OAuth2 client for Salesforce API
AWS_ACCESS_KEY_ID="amazon aws access key id"
AWS_SECRET_ACCESS_KEY="amazon aws secret access key"
AWS_S3_BUCKET_NAME="aws bucket name to publish"
```

## License

MIT

