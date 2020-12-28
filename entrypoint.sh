#!/bin/bash

GITHUB_TAG=${GITHUB_REF/refs\/tags\//}
AWS_REGION=${AWS_REGION:-$AWS_DEFAULT_REGION}

SAM_TEMPLATE=${1-$SAM_DEFAULT_TEMPLATE}
S3_BUCKET=${2}
S3_BUCKET_PREFIX=${3}
SAM_VERSION=${4-$GITHUB_TAG}

sam package --region $AWS_REGION --s3-bucket $S3_BUCKET --s3-prefix $S3_BUCKET_PREFIX --template-file $SAM_TEMPLATE --output-template-file packaged.yaml
sam publish --region $AWS_REGION --semantic-version $SAM_VERSION --template packaged.yaml
