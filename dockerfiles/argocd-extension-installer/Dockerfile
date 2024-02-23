
ARG ALPINE_VERSION=3.19.1

FROM alpine:${ALPINE_VERSION}

ARG USER=ext-installer
ENV HOME /home/$USER

RUN apk update && apk add file curl

RUN adduser -D $USER
USER $USER
WORKDIR $HOME

RUN curl -L https://raw.githubusercontent.com/argoproj-labs/argocd-extension-installer/main/install.sh -o ./install.sh \
    && chmod +x ./install.sh

ENTRYPOINT ["./install.sh"]
