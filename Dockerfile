# syntax=docker/dockerfile:1.7

FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

LABEL name="pgclient" version="0.1.5"

# Explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -m -r -g postgres --uid=999 postgres

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get full-upgrade -y \
  && apt-get --no-install-recommends install -y \
  ca-certificates \
  pinentry-tty \
  curl \
  gnupg gnupg2 \
  lsb-release \
  gzip \
  zip \
  unzip \
  ssmtp \
  s3cmd \
  python3-swiftclient \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

### POSTGRESQL

ENV PG_MAJOR 18

# Add the PostgreSQL PGP key to verify their Debian packages.
# Use the modern signed-by approach instead of deprecated apt-key
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# hadolint ignore=DL3008
RUN set -x \
  && apt-get update && apt-get --no-install-recommends install -y \
  postgresql-client-$PG_MAJOR \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

USER postgres

RUN gpg2 --version
RUN gpg2 -K
RUN id

USER root

COPY gpg-agent.conf /home/postgres/.gnupg/gpg-agent.conf
RUN chown postgres:postgres /home/postgres/.gnupg/gpg-agent.conf

USER postgres

RUN psql --version
RUN swift --version
RUN s3cmd --version
RUN gpg2 -K

WORKDIR /tmp

ENTRYPOINT ["/bin/bash"]
HEALTHCHECK NONE

# dockerfile_lint - ignore
EXPOSE 80
