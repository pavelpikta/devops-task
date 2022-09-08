#!/usr/bin/python3.8
"""
Lambda function to upload dataset from URL to AWS S3 bucket
"""

import io
import os
import requests
import boto3
import botocore

FILE_NAME = "dataset.csv"
DATASET_URL =  os.environ['DATASET_URL']
BUCKET = os.environ['DATASET_S3_BUCKET']

def upload_file_s3(file_name, bucket, obj_name=None):
    """
    Upload a file to an S3 bucket
    :param filename: File to upload
    :param bucket: Bucket to upload to
    :param object_name: S3 object name. If not specified, filename is used
    :return None if upload was successful, otherwise the associated error code
    """

    if obj_name is None:
        obj_name = file_name

    s3_client = boto3.client('s3')

    try:
        req = requests.get(DATASET_URL, allow_redirects=True, timeout=300)
        req.raise_for_status()
    except requests.exceptions.HTTPError as err:
        print ("Http Error:", err)
    except requests.exceptions.ConnectionError as err:
        print ("Error Connecting:", err)
    except requests.exceptions.Timeout as err:
        print ("Timeout Error:", err)
    except requests.exceptions.RequestException as err:
        print ("Request Error", err)

    try:
        s3_client.upload_fileobj(io.BytesIO(req.content), bucket, obj_name)
        print("Dataset successfully uploaded to S3 bucket")

    except botocore.exceptions.ClientError as error:
        error = error.response['Error']['Code']

        print("Could not upload dataset to S3 bucket")
        print("Error:", error)

        return error

    return None


def lambda_handler(event, context):
    """
    Method that processes events.
    """
    upload_file_s3(FILE_NAME, BUCKET)

    return event
