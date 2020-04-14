#!/usr/bin/env bash

echo 'Copy files...'

scp -i ~/.ssh/id_rsa \
    -P 55221 target/norealt-0.0.1-SNAPSHOT.jar \
    andrey@getwow.ru:/home/andrey/

echo 'Files copied!'