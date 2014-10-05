Docker Automated build of TapTinder Client
==========================================

Docker files and scripts for TapTinder client installations.

See [taptinder.org](http://www.taptinder.org) for more info.

Join irc://irc.freenode.org/taptinder with your IRC client or use [Web interface](https://webchat.freenode.net/?channels=taptinder).

Docker image
============

Available on [registry.hub.docker.com/u/mj41/tt-client](https://registry.hub.docker.com/u/mj41/tt-client/).

Fast start
==========

    # download, create and run 'myttc' container
    docker run -i -t --name myttc mj41/tt-client:latest

Docker intro
============

See [Using Docker](https://docs.docker.com/userguide/usingdocker/)

    # to see your Docker containers
    docker ps -a

    # stop, start already created 'myttc' container
    docker stop myttc
    docker start myttc

    # to see console (new output, similar to --follow mode)
    docker attach myttc

Explore
=======

    # to create 'myttc-exp' and run Bash there
    docker run -i -t --name myttc-exp mj41/tt-server:prod /bin/bash

    # start TapTinder server
    ttclient-start.sh --vl 5

    # run already created 'myttc-exp' container
    docker start -i myttc-exp
