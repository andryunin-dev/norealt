#!/usr/bin/env bash

echo 'STOP ALL Java applications...'

# stop ALL project
ssh -i ~/.ssh/id_rsa andrey@getwow.ru -p 55221 << EOF
pgrep java | xargs kill -9
EOF

echo 'The applications was STOP!'