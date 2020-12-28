# AWS Serverless Application Repository Action

This GitHub action that pack and publish a new version of SAM Application to AWS Serverless Application Repository.

## Usage

Set AWS CLI environment variable in order to authenticating to AWS Services, more information at [AWS doc](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-set-up-credentials.html).

Configuration example:
```yml
steps:
  - name: sam cli
    uses: daaru00/aws-serverless-application-repository-action@v1
    env:
      AWS_DEFAULT_REGION: eu-west-1
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    with:
      template: 'template.yml'
      s3bucket: 'my-artifact-bucket'
      s3prefix: 'my-app'
      version: '1.0.0'
```
if `version` is not set will be elaborate from `GITHUB_REF` environment variable (works only when a tag is pushed and ref contains `refs/tags/`).
