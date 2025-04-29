FROM alpine:latest

ARG terraform_version="1.9.0"

RUN apk update --no-cache \
    && apk add --no-cache \
        wget \
        unzip \
        curl \
        aws-cli \
        bash \
        docker \
        git \
        jq \
    && wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_arm64.zip \
    && unzip ./terraform_${terraform_version}_linux_arm64.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/terraform \
    && rm -rf ./terraform_${terraform_version}_linux_arm64.zip
