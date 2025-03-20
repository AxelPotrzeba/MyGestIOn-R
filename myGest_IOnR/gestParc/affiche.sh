#!bin/bash

#import des configs et fonctions
source config.sh
source fonction.sh

BDD_NOM="MyGest"
USER="UserMygest"
MDP="btsinfo"

afficheTitre "Consultation des donnees"
quitter=1
while [[ $quitter -ne 0 ]]

do
echo "1) Afficher la liste des tables"
echo "2) Afficher toutes les tables"
echo "3) Afficher la table des équipements"
echo "4) Afficher la table des types d'équipements"
echo "5) Exécuter manuellement une requête SQL"
echo "0) Retour au menu gestion du parc"
echo -e "Veuillez choisir une option :"
read choix

case $choix in 
	1 )
		echo "Liste des tables disponibles dans la base de données $BDD_NOM :"
        mysql -u $USER -p$MDP -D $BDD_NOM -e "show tables;"
		;;
	2 )
		mysql -u $USER -p$MDP -D $BDD_NOM -e "select * from Equipement; select * from TypeE;"
		;;
    3 )
        mysql -u $USER -p$MDP -D $BDD_NOM -e "select * from Equipement;"
        ;;
    4 )
        mysql -u $USER -p$MDP -D $BDD_NOM -e "select * from TypeE;"
        ;;
	5 )
		echo "Veuillez saisir votre requête SQL :"
     	read REQUETE
		mysql -u $USER -p$MDP -D $BDD_NOM -e "$REQUETE"
		;;
	0 )
		quitter=0
		;;
	* )
		echo "Erreur dans la saisie"
		;;
		
esac
done
