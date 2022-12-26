FROM docker:20.10.1-dind

ARG ASG_NAME
ENV KUBE_LATEST_VERSION="v1.18.8"


RUN apk --update --no-cache add \
    py-pip \
    bash \
    git \
    groff \
    less \
    mailcap \
    bash \
    && pip install --no-cache-dir awscli \
    && apk del py-pip \
    && rm -rf /var/cache/apk/* /root/.cache/pip/*

WORKDIR /root
VOLUME /root/.aws

RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN set -x && \
    apk add --update libintl && \
    apk add --virtual build_deps gettext &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN wget -O /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && curl -OL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o ./jq-linux64 \
    && chmod a+x ./jq-linux64 \
    && mv ./jq-linux64 /usr/bin/jq \
    && rm -r /usr/local/bin/yq \
    && wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YAML_BIN_VERSION}/yq_linux_amd64" \
    && chmod +x /usr/local/bin/yq \
    && wget https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.4.0/linux-amd64/docker-credential-ecr-login -O /usr/local/bin/docker-credential-ecr-login \
    && chmod +x /usr/local/bin/docker-credential-ecr-login
