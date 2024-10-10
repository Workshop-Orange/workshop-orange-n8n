# Workshop Orange N8N Instance

## To run locally
 - clone the repo `git clone git@github.com:Workshop-Orange/workshop-orange-n8n.git`
 - run the containers `docker-compose up`

## To upgrade N8N
 - edit lagoon/node.dockerfile and change the `ARG N8N_VERSION=1.61.0` to the version you wish to pin
 - test locally `docker-compose build`
 - deploy on Lagoon


