# syntax=docker/dockerfile:1.2.1

FROM ubuntu:20.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -m -r -g postgres --uid=999 postgres

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN set -x \
	&& apt-get update && apt-get --no-install-recommends install -y \
    ca-certificates \
    pinentry-tty \
    curl \
    gnupg gnupg2 \
    lsb-release \
    gzip \
    ssmtp \
    s3cmd \
    python3-swiftclient \
    vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

### POSTGRESQL

ENV PG_MAJOR 14

# Add the PostgreSQL PGP key to verify their Debian packages.
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main $PG_MAJOR" > /etc/apt/sources.list.d/pgdg.list

# hadolint ignore=DL3008
RUN apt-get -q update && apt-get -q -o Dpkg::Options::="--force-confnew" --no-install-recommends install -y \
    postgresql-client-10 postgresql-client-12 postgresql-client-$PG_MAJOR \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER postgres

RUN gpg2 --version
RUN gpg2 -K
RUN id

USER root

RUN ls -lrta /home/postgres/
#RUN mkdir /home/postgres/.gnupg
#RUN chown postgres:postgres /home/postgres/.gnupg
RUN ls -lrta /home/postgres/.gnupg

#ADD gpg-agent.conf --chown=postgres:postgres /home/postgres/.gnupg/gpg-agent.conf
ADD gpg-agent.conf /home/postgres/.gnupg/gpg-agent.conf
RUN chown postgres:postgres /home/postgres/.gnupg/gpg-agent.conf

USER postgres

RUN psql --version
RUN swift --version
RUN s3cmd --version
RUN gpg2 -K

WORKDIR /tmp

CMD ["/bin/bash"]
HEALTHCHECK NONE
