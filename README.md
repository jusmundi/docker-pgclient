<!-- markdown-link-check-disable-next-line -->
## [![JusMundi](https://media-exp1.licdn.com/dms/image/C4D0BAQFkFSDZh9uBpg/company-logo_200_200/0/1519903803617?e=2147483647&v=beta&t=wAWk1qgiv69WUS_PyOx-7apQTDnJXvBnvMCBmqO9Tew)](https://gitlab.com/jusmundi-group/web/infrastructure) docker image with postgresql client for backup

1. connect postgresql db
2. encrypt dump
3. upload dump to ovh and scaleway

# Table of contents

<!-- markdown-link-check-disable -->

<!-- toc -->

- [Table of contents](#table-of-contents)
  - [Backup](#backup)
    - [Create docker backup postgresql client image](#create-docker-backup-postgresql-client-image)
    - [Check docker image quality](#check-docker-image-quality)
      - [Docker dive](#docker-dive)
      - [Docker linter](#docker-linter)
      - [mega-linter](#mega-linter)
      - [Check secret](#check-secret)
      - [Check cspell](#check-cspell)
    - [Update README.md](#update-readmemd)

<!-- tocstop -->

<!-- markdown-link-check-enable -->

## Backup

### Create docker backup postgresql client image

Code is [jusmundi/pgclient](https://github.com/jusmundi/docker-pgclient)

```bash
sudo service docker restart
make build
```

```bash
export DOCKER_ORGANISATION=${DOCKER_ORGANISATION:-"jusmundi"}
docker build --network=host -t "${DOCKER_ORGANISATION}/pgclient:0.1.0" --squash .
docker run -ti "${DOCKER_ORGANISATION}/pgclient:0.1.0" bash
docker tag ghcr.io/jusmundi/pgclient:${OCI_TAG:-"latest"} ghcr.io/jusmundi/pgclient:0.1.1
docker push "${DOCKER_ORGANISATION}/pgclient:0.1.1"
```

Image uploaded to [jusmundi/pgclient](https://hub.docker.com/r/jusmundi/pgclient/tags)

### Check docker image quality

#### Docker dive

```bash
dive --ci --json docker-dive-stats.json "${DOCKER_ORGANISATION}/pgclient:0.1.0" 1>docker-dive.log 2>docker-dive-error.log
```

#### Docker linter

```bash
sudo npm install -g dockerfile_lint
dockerfile_lint --json --verbose --dockerfile Dockerfile
```

```bash
brew install hadolint
hadolint Dockerfile
```

#### mega-linter

```bash
npx mega-linter-runner --install
npx mega-linter-runner
npx v8r@latest .mega-linter.yml
```

#### Check secret

```
npx @secretlint/quick-start "**/*"
```

#### Check cspell

```
npx cspell "**/*.{txt,js,md}"
```

### Update README.md

* [github-markdown-toc](https://github.com/jonschlinkert/markdown-toc)
* With [github-markdown-toc](https://github.com/Lucas-C/pre-commit-hooks-nodejs)

```
sudo npm install -g markdown-toc
markdown-toc README.md -i
markdown-toc CHANGELOG.md -i
sudo npm install -g markdown-link-check
markdown-link-check ./README.md
```
