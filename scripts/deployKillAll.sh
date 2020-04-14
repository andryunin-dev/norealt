#!/usr/bin/env bash

echo 'Deploy Kill All Run...'

sh ./scripts/parts/build.sh
sh ./scripts/parts/copy.sh
sh ./scripts/parts/restartApps.sh

echo 'Bye Bye'