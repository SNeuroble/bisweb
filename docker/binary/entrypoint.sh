#!/bin/bash

# From https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback to 9001

USER_ID=${LOCAL_USER_ID:-9001}
echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m bisweb -d /opt/bisweb
chown -R bisweb /opt/bisweb

echo ""
echo "--------------------- Starting apache on port 8080 -----------------"

/usr/sbin/apachectl -DFOREGROUND &

sleep 2

echo "--------------------- Starting interactive shell -----------------"

exec gosu bisweb "$@"


