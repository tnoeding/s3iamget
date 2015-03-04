#!/bin/bash
# New test IAM Roles based S3 get script
IAM_BASE_URL="http://169.254.169.254/latest/meta-data/iam/security-credentials"
IAM_ROLE_NAME=`curl -s $IAM_BASE_URL/`
IAM_ROLE_DATA=`curl -s $IAM_BASE_URL/$IAM_ROLE_NAME/`
IAM_ROLE_ACCESS_KEY_ID=`echo "$IAM_ROLE_DATA" | sed -nre 's/.*?"AccessKeyId"[^"]+"([^"]+)",?/\1/p'`
IAM_ROLE_ACCESS_KEY_SECRET=`echo "$IAM_ROLE_DATA" | sed -nre 's/.*?"SecretAccessKey"[^"]+"([^"]+)",?/\1/p'`
IAM_ROLE_TOKEN=`echo "$IAM_ROLE_DATA" | sed -nre 's/.*?"Token"[^"]+"([^"]+)",?/\1/p'`
AWS_DATE=`date -u +'%Y%m%dT%H%M%SZ'`

AWS_SIG=`echo -en "GET\n\n\n\nx-amz-date:$AWS_DATE\nx-amz-security-token:$IAM_ROLE_TOKEN\n/$1/$2" | openssl sha1 -hmac $IAM_ROLE_ACCESS_KEY_SECRET -binary | base64`

curl -s -L -X "GET" -H "Host: $1.s3.amazonaws.com" -H "X-Amz-Date:$AWS_DATE" -H "X-Amz-Security-Token:$IAM_ROLE_TOKEN" -H "Authorization: AWS $IAM_ROLE_ACCESS_KEY_ID:$AWS_SIG" https://$1.s3.amazonaws.com/$2