#!/usr/bin/env bash

echo 'Restart ALL Java applications...'

# stop ALL project
ssh -i ~/.ssh/id_rsa andrey@getwow.ru -p 55221 << EOF
pgrep java | xargs kill -9
nohup java -jar norealt-0.0.1-SNAPSHOT.jar > log.txt &
EOF

echo 'The applications was restarted!'