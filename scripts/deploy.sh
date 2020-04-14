#!/usr/bin/env bash

echo 'Deploy Run...'

sh ./scripts/parts/build.sh
sh ./scripts/parts/copy.sh
sh ./scripts/parts/restartOne.sh

echo 'Bye Bye'