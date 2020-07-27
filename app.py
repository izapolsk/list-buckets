import os

from flask import Flask
from wrapanapi import EC2System

app = Flask(__name__)


@app.route('/')
def hello_world():
    system = EC2System(region=os.getenv('REGION'),
                       username=os.getenv('USERNAME'),
                       password=os.getenv('PASSWORD'))
    return system.list_s3_bucket_names()
