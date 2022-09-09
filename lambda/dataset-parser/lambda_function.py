#!/usr/bin/python3.8
"""
Lambda function that parse dataset from S3 and generate HTML page
"""

import os
import urllib.parse
import pandas as pd
import boto3
import botocore



BUCKET = os.environ['STATIC_PAGE_S3_BUCKET']
COUNTRY = os.environ['COUNTRY_CODE']
FILE_NAME="index.html"
COLUMS_FILTER = [
    'id',
    'date',
    'confirmed',
    'deaths',
    'recovered',
    'tests',
    'vaccines',
    'people_vaccinated',
    'people_fully_vaccinated',
    'iso_alpha_2'
]

s3_client = boto3.client('s3')

def upload_page_s3(file_name, bucket, result, obj_name=None,):
    """
    Upload a html page to an S3 bucket
    :param filename: File to upload
    :param bucket: Bucket to upload to
    :param result: Content for html page
    :param object_name: S3 object name. If not specified, filename is used
    :return None if upload was successful, otherwise the associated error code
    """

    if obj_name is None:
        obj_name = file_name

    try:
        s3_client.put_object(
            Bucket=bucket,
            Key=file_name,
            Body=result,
            CacheControl="max-age=0,no-cache,no-store,must-revalidate",
            ContentType="text/html"
        )
        print("Page uploaded to S3 bucket")

    except botocore.exceptions.ClientError as error:
        error = error.response['Error']['Code']

        print("Could not upload page to S3 bucket")
        print("Error:", error)

        return error

    return None

def lambda_handler(event, context):
    """
    This function runs for PUT event on AWS S3 bucket
    """

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    try:
        response = s3_client.get_object(Bucket=bucket, Key=key)
        status = response.get("ResponseMetadata", {}).get("HTTPStatusCode")

        if status == 200:
            print(f"Successful S3 get_object response. Status - {status}")
            data = pd.read_csv(response.get("Body"), low_memory=False)
            result = data.loc[:, COLUMS_FILTER].loc[data['iso_alpha_2'] == COUNTRY].sort_values(by=['date'], ascending=False).to_html()

            # Upload result to static website s3 bucket
            upload_page_s3(FILE_NAME, BUCKET, result)

        else:
            print(f"Unsuccessful S3 get_object response. Status - {status}")

    except Exception as error:
        print(error)
        raise error
