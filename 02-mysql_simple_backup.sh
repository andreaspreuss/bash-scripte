#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
#------------------------------------------------------
# Ein einfaches Backupscript fuer eine MySQL Datenbank
#------------------------------------------------------
# Angabe der mySQL Variablen
# -- 1 --
DBSERVER=Meinserver.com
DATABASE=MeineMySQLDatenbank
USER=Username
PASS=mypass
FILE=datenbank.sql.`date +"%d%m%Y"`
# Falls schon mal ein Backup gemacht wurde, Vorgaengerdatei löschen
# -- 2 --
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null
# MYSQL DUMP
# -- 3 --
# Dieses Kommando gilt fuer einen Datenbankserver auf localhost verwendet werden. Bei Bedarf können weitere Optionen hinzugefuegt werden.
echo "Start des Backups:"
mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${FILE}

# Dieses Kommando gilt fuer einen Datenbankserver auf einem separaten Host verwendet werden:
# mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

# Komprimieren der mysql-Datenbank-Dump-Datei mit gzip
# -- 4 --
gzip $FILE
# Ausgabe anzeigen
echo "${FILE}.gz wurde erstellt:"
ls -l ${FILE}.gz
# exit $EXIT_SUCCESS