## [![JusMundi](https://jusmundi.com/_nuxt/img/ec6242d.gif)](https://gitlab.com/jusmundi-group/web/infrastructure/-/tree/master) docker image with postgresql client for backup

1. connect postgressql db
2. encrypt dump
3. upload dump to ovh and scaleway

# Table of contents

<!-- toc -->

<!-- tocstop -->

## Backup

### Create docker backup postgresql client image

```bash
export DOCKER_ORGANISATION=${DOCKER_ORGANISATION:-"jusmundi"}
docker build --network=host -t "${DOCKER_ORGANISATION}/pgclient:0.0.1" .
docker push "${DOCKER_ORGANISATION}/pgclient:0.0.1"
```

### TODO


  postgre 14 -> alertapi

  postgre 10 -> back --> to migrate

  postgre 12 -> scraper --> 2 bases to migrate

check package

 find

Get credentials

 acces ovh container
 acces scaleway

