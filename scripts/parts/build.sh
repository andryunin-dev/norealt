#!/usr/bin/env bash

echo 'Start build project...'

mvn package -DskipTests

echo 'Build end!'