#!/bin/bash
# Skript: template-bash-script.sh
# Zweck: Basistemplate für eigene Skripte, enthaelt bereits Skript-Standardelemente 
# (usage-Funktion, Optionen parsen mittels getopts, vordefinierte Variablen...)
# Diese Datei ist unter der Commons Attribution-Share Alike Lizenz veröffentlicht.
# Shellskript-Template ursprünglich von Jochen Gruse pro-linux.de
# 
# Globale Variablen
# Es lohnt sich immer, globale Variable am Anfang eines Skriptes zusammenzufassen und dort 
# am besten auch mit sinnvollen Defaultwerten zu belegen. Der Name des Skripts ($SCRIPTNAME) 
# kann in Fehlermeldungen oder Statusmeldungen weiterverwendet werden. Aussagekräftige Namen 
# für Exitcodes, die im Erfolgs-, Misserfolgs-, Fehler- oder Skriptfehlerfall an den auf-
# rufenden Prozess zurückgegeben werden, machen den Abbruchcharakter im späteren Skript deutlich.
# 

SCRIPTNAME=$(basename $0 .sh)
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10
# Variablen für Optionsschalter hier mit Default-Werten vorbelegen
VERBOSE=n
OPTFILE=""

# Funktionen
# Im Fehlerfall ist es gute Sitte, den korrekten Aufruf des Skripts zu beschreiben. 
# Die Funktion usage macht genau das. Außerdem markiert diese Funktion die Stelle, an der 
# man eigene Funktionen aufführen kann, wenn das Skript etwas größer werden sollte.
function usage {
 echo "Usage: $SCRIPTNAME [-h] [-v] [-o arg] file ..." >&2
 [[ $# -eq 1 ]] && exit $1 || exit $EXIT_FAILURE
}
# Die Option -h für Hilfe sollte immer vorhanden sein, die Optionen
# -v und -o sind als Beispiele gedacht. -o hat ein Optionsargument;
# man beachte das auf "o" folgende ":".
# 
# Im Fehlerfall ist es gute Sitte, den korrekten Aufruf des Skripts 
# zu beschreiben. Die Funktion usage macht genau das. Außerdem markiert 
# diese Funktion die Stelle, an der man eigene Funktionen aufführen kann, 
# wenn das Skript etwas größer werden sollte.
# 
# Um die Arbeitsweise eines Kommandos zu variieren, verwendet man unter UNIX Optionen. 
# Dies sind Argumente, die mit einem "-" beginnen und entweder als Schalter (gesetzt/nicht gesetzt) 
# funktionieren oder ein Optionsargument mitgegeben bekommen. Solange ein Shellskript nur eine 
# einzige Option erkennen muss, ist das Parsen noch leicht. Wenn es aber mehrere werden, 
# dann dürfen diese Optionen nach UNIX-Konventionen beliebig zusammen gruppiert werden: 
# ls -l -a, ls -la und ls -al sind gleichwertig! Damit diese Funktionalität nicht immer wieder 
# (meist fehlerhaft oder nur eingeschränkt ) neu implementiert werden muss, gibt es die 
# getopts-Funktion.
# Das erste Argument zu getopts ist eine Zeichenkette, welche die erlaubten Optionen definiert. 
# In unserem Beispiel sind das die Optionen o, h und v. Da auf den Buchstaben o ein Doppelpunkt 
# folgt, wird für -o ein Optionsargument erwartet. Der erste Doppelpunkt weist getopts an, 
# keine eigenen Fehlermeldungen auszugeben, damit wir ungestört unsere eigenen Meldungen ausgeben können.
# Das zweite Argument zu getopts ist der Name der Variablen, die mit der erkannten Option 
# gefüllt werden soll. Ein eventuelles Optionsargument findet man in der Variablen OPTARG.
# Fehlerfälle wie unbekannte Optionen und fehlende Optionsargumente sind bereits abgehandelt. 
# Zum Ende der Schleife, also wenn getopts keine weiteren Optionen mehr oder ein "--" erkennt, 
# werden die abgearbeiteten Optionen mittels shift aus der Argumentliste des Skripts entfernt.

while getopts ':o:vh' OPTION ; do
 case $OPTION in
 v) VERBOSE=y
 ;;
 o) OPTFILE="$OPTARG"
 ;;
 h) usage $EXIT_SUCCESS
 ;;
 \?) echo "Unbekannte Option \"-$OPTARG\"." >&2
 usage $EXIT_ERROR
 ;;
 :) echo "Option \"-$OPTARG\" benötigt ein Argument." >&2
 usage $EXIT_ERROR
 ;;
 *) echo "Dies kann eigentlich gar nicht passiert sein..."
>&2
 usage $EXIT_BUG
 ;;
 esac
done

# Häufig macht der Aufruf des Skriptes nur mit mindestens einem Argument 
# (Dateiname, Username, ...) Sinn. Eine entsprechende Prüfung ist bereits vorgeben. 
# Sie lässt sich schnell erweitern oder aber auch entfernen.
# 
# Verbrauchte Argumente überspringen
shift $(( OPTIND - 1 ))

# echo gibt alle übergebenen Kommandos nach stdout (Standardausgabe) aus. 
# Wenn man das eigene Skript eine Fehlermeldung machen lassen muss, sollte diese 
# Ausgabe nach stderr (Standardfehlerausgabe) umgelenkt werden: echo "Fehler" >&2. 
# Diese Umlenkung liest sich als "Lenke die Standardausgabe (>) auf die 
# Standardfehlerausgabe (&2) um."
# 
# Eventuelle Tests auf min./max. Anzahl Argumente hier

if (( $# < 1 )) ; then
 echo "Mindestens ein Argument beim Aufruf übergeben." >&2
 usage $EXIT_ERROR
fi

# Schleife über alle Argumente
# Ein Skript sollte, wenn es sinnvoll ist, immer mehrere Argumente bei einem Aufruf 
# abarbeiten können. Daher enthält die Schablone eine Beispielschleife, die über alle 
# übergebenen Argumente läuft. Die Variante for VAR ; do ; done ist nicht destruktiv 
# und macht auch bei Argumenten, die Leerzeichen enthalten, keine Probleme.
# Natürlich ist der Inhalt der Schleife in diesem Skript überflüssig, 
# da genau hier der eigentliche Inhalt eingefügt werden soll. 
# So kann man das Skript aber starten, um sich von der Lauffähigkeit zu überzeugen, 
# außerdem sind die wenigen Zeilen schnell gelöscht.

for ARG ; do
 if [[ $VERBOSE = y ]] ; then
 echo -n "Argument: "
 fi
 echo $ARG
done
exit $EXIT_SUCCESS
