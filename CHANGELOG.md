# Changelog

<!-- markdown-link-check-disable -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Table of contents

// spell-checker:disable

<!-- toc -->

* [Size](#size)
- [Changelog](#changelog)
  - [Table of contents](#table-of-contents)
    - [Size](#size)
  - [\[Unreleased\]](#unreleased)
  - [\[0.1.4\] - 2024-06-07](#014---2024-06-07)
    - [Updated](#updated)
  - [\[0.1.3\] - 2024-06-07](#013---2024-06-07)
    - [Updated](#updated-1)
  - [\[0.1.2\] - 2024-06-07](#012---2024-06-07)
    - [Updated](#updated-2)
  - [\[0.1.1\] - 2023-03-02](#011---2023-03-02)
    - [Updated](#updated-3)
  - [\[0.1.0\] - 2022-11-05](#010---2022-11-05)
    - [Updated](#updated-4)
  - [\[0.0.1\] - 2022-13-04](#001---2022-13-04)
    - [Added](#added)
    - [Updated](#updated-5)
    - [Remove](#remove)

<!-- tocstop -->

// spell-checker:enable

### Size

// cSpell:words pgclient

🌈 Size is 319MB

## [Unreleased]

<!--lint disable no-undefined-references-->

## [0.1.4] - 2024-06-07

### Updated

- Add `unzip` package

## [0.1.3] - 2024-06-07

### Updated

- Add `zip` package

## [0.1.2] - 2024-06-07

### Updated

- Upgrade to postgres 16

## [0.1.1] - 2023-03-02

### Updated

- Update to ubuntu:22.10
- `apt-get full-upgrade` to fix CVE

## [0.1.0] - 2022-11-05

Ubuntu 22.04

### Updated

- Ubuntu 22.04

```bash
docker build --network=host -t "${DOCKER_ORGANISATION}/pgclient:0.1.0" --squash .
docker push ${DOCKER_ORGANISATION}/pgclient:0.1.0
```

## [0.0.1] - 2022-13-04

Ubuntu 20.04

`docker pull ${DOCKER_ORGANISATION}/pgclient:0.0.1`

### Added

// cSpell:words postgresql swift s3cmd
- Add postgresql-client-10 postgresql-client-12 postgresql-client-14
- Add upload tooling swift and s3cmd

### Updated

- None

### Remove

- None

`docker run -it -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v /var/run/docker.sock:/var/run/docker.sock --entrypoint /bin/bash ${DOCKER_ORGANISATION}/pgclient:0.1.0`

<!-- markdown-link-check-enable -->
