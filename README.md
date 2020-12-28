# AWS Serverless Application Repository Action

This GitHub action that pack and publish a new version of SAM Application to AWS Serverless Application Repository.

## Prerequisites

Create an S3 bucket with the following policy in order to allow Serverless Repository service to retrieve template and artifacts:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service":  "serverlessrepo.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::my-artifact-bucket/*"
        }
    ]
}
```
(change `my-artifact-bucket` with the name of your bucket)

Create a IAM user with programmatic access and the following permission attached that allow to create an Application or Application Version:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAllMyBuckets",
            "Effect":"Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource":"arn:aws:s3:::*"
        },
        {
            "Sid": "ListBucket",
            "Effect":"Allow",
            "Action":[
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource":"arn:aws:s3:::my-artifact-bucket"
        },
        {
            "Sid": "UploadTemplateAndArtifacts",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::my-artifact-bucket/*"
        },
        {
            "Sid": "CreateApplication",
            "Effect": "Allow",
            "Action": [
                "serverlessrepo:CreateApplication",
                "serverlessrepo:CreateApplicationVersion"
            ],
            "Resource": "*"
        }
    ]
}
```
(change `my-artifact-bucket` with the name of your artifact bucket)

Set the IAM user credentials ("Access key ID" and "Secret access key") keys into GitHub Secrets:
```
AWS_ACCESS_KEY_ID: xxxxxxxxxxxxxxxxxxxx
AWS_SECRET_ACCESS_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

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
