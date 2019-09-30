#!/bin/bash
# this bad boy will check the db for read only status by `SELECT @@global.read_only;`
# and if the read_only value is 0 we will rotate, other wise we won't.
# pretty simple eh?
# nh

DB_READ=`mysql --login-path=backup -s -N -e "SELECT @@global.read_only;"`

if (( $DB_READ == 0 ))
   then
        /usr/sbin/logrotate -f /usr/local/adm/mysql.rotate
        /usr/bin/mysqladmin --login-path=backup flush-logs error slow general
   else
        exit 1
fi
