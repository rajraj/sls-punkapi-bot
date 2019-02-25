# Serverless endpoint for the Lex Bot

## Requirements

- Serverless framework 1.37+
- Ruby 2.5+
- An AWS user account with permissions for creating various AWS resources S3, etc.

## Initial setup

- Clone the repo
- Run `bundle` to install the ruby dependencies

## Deployment

```sh
# Deploy everything

npx sls deploy
```

```sh
# If you just want to deploy a function

npx sls deploy -f FUNCTION_NAME
```

## Logs

```sh
# view the logs

npx sls logs -f FUNCTION_NAME
```

```sh
# tail the log

npx sls logs -f FUNCTION_NAME
```

Add `-t` to tails the logs.

