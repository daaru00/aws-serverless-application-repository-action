#!/bin/bash

GITHUB_TAG=${GITHUB_REF/refs\/tags\//}
AWS_REGION=${AWS_REGION:-$AWS_DEFAULT_REGION}

SAM_SRC=${1}
SAM_TEMPLATE=${2}
S3_BUCKET=${3}
S3_BUCKET_PREFIX=${4}

if [ -z "$5" ]
then
  SAM_VERSION=$5
else
  SAM_VERSION=$GITHUB_TAG
fi

cd $SAM_SRC

sam package --region $AWS_REGION --s3-bucket $S3_BUCKET --s3-prefix $S3_BUCKET_PREFIX --template-file $SAM_TEMPLATE --output-template-file packaged.yaml
sam publish --region $AWS_REGION --semantic-version $SAM_VERSION --template packaged.yaml
