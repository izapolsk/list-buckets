FROM  amazonlinux:latest

USER root

# installing essential packages
RUN yum install -y  python3 python3-pip git gcc python3-devel libcurl-devel libxml2-devel openssl-devel&& yum clean all

ENV GIT_SSL_NO_VERIFY true
ENV PYCURL_SSL_LIBRARY openssl
ENV FLASK_APP app.py
ENV REGION us-east-1

RUN pip3 install poetry
RUN mkdir /app
RUN git clone https://github.com/izapolsk/list-buckets.git /app
WORKDIR /app
RUN poetry install

EXPOSE 80
CMD /usr/local/bin/poetry run flask run --host 0.0.0.0 --port 80
