#!/usr/bin/env bash

echo 'Restart THIS Java application...'

# stop only this project
ssh -i ~/.ssh/id_rsa andrey@getwow.ru -p 55221 << EOF
pkill -f norealt-0.0.1-SNAPSHOT.jar
nohup java -jar norealt-0.0.1-SNAPSHOT.jar > log.txt &
EOF

echo 'The application was restarted!'