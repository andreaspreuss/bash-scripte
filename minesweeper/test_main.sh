#!/bin/bash

OK=0
FALSE=1
ANSI_PRIFIX="\033["

function stty_init()
{
	stty_save=$(stty -g) 	# Sicherung der aktuellen Terminal-Einstellungen
	clear					# Bildschirm löschen
	trap "game_exit;" 2 15	# Aufruf der Funktion game_exit(), wenn das Programm SIGINT(2)- und SIGTERM(15)-Signale empfängt, bevor es das Programm beendet
	stty -echo				# Schaltet Zeicheneingabeechos aus, d.h. alle eingegebenen Zeichen werden nicht angezeigt

	echo -ne "${ANSI_PRIFIX}?25l" 	# Den Cursor ausblenden.
 	return $OK
}

function game_exit()
{
	stty $stty_save			# ursprüngliche Terminal-Einstellungen wiederherstellen
	stty echo				# Zeicheneingabe zur Anzeige zurückkehren
	clear
	trap 2 15
	echo -ne "${ANSI_PRIFIX}?25h${ANSI_PRIFIX}0m"		# Wiederherstellen der Cursor-Anzeige und aller anderen Attribute (einschließlich Vorder- und Hintergrundfarben usw.)

	exit $OK
}

cd $(dirname $0)
stty_init

# Prüfen des Codes hier, indem das Shell-Skript mit dem bash-Befehl 
# ausgeführt wird, zum Beispiel: bash xxx.sh
bash ./color_output.sh "Hello World!\n" grey sblue
bash ./color_output.sh "Hello World!\n" blue
bash ./color_output.sh "Hello World!"
bash ./game_interface.sh 10 10 30
read -s -n 1				# Zum Beenden eine beliebige Taste drücken.
game_exit
exit 0
