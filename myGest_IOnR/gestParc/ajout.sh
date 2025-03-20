#!/bin/bash

#import des configs et fonctions
source config.sh
source fonction.sh

BDD_NOM="MyGest"
USER="UserMygest"
MDP="btsinfo"

afficheTitre "Ajouter des donnees"
quitter=1
while [[ $quitter -ne 0 ]]

do
echo "1) Ajouter un équipement"
echo "2) Ajouter un type d'équipement"
echo "0) Retour au menu gestion du parc"
echo -e "Veuillez choisir une option :"
read choix

case $choix in 
	1 )
        read -p "Saisissez l'identifiant de l'équipement : " id
        check_id=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM Equipement WHERE id='$id';")
        if [[ "$check_id" -ne 0 ]]; then
            echo "L'ID existe déjà dans la table Equipement."
            continue
        fi

        read -p "Saisissez le nom de l'équipement : " nom

        while true; do
            read -p "Saisissez l'adresse MAC (format XX:XX:XX:XX:XX:XX) : " mac
                if [[ ! "$mac" =~ ^([A-Fa-f0-9]{2}:){5}[A-Fa-f0-9]{2}$ ]]; then
                    echo "Format invalide. L'adresse MAC doit être au format XX:XX:XX:XX:XX:XX (hexadécimal uniquement)."
                continue
                fi

            check_mac=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM Equipement WHERE adMAC='$mac';")
                if [[ "$check_mac" -ne 0 ]]; then
                    echo "Cette adresse MAC existe déjà dans la base de données."
                continue
                fi
                break
        done

        while true; do
            read -p "Saisissez l'adresse IP : " ip
            if [[ ! "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
                echo "Format invalide. L'adresse IP doit être au format xxx.xxx.xxx.xxx."
            continue
            fi

            valid=true
            IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
            for octet in $o1 $o2 $o3 $o4; do
                if ((octet < 0 || octet > 255)); then
                    valid=false
                break
                fi
        done

            if [[ $valid = false ]]; then
                echo "Adresse IP invalide : chaque octet doit être entre 0 et 255."
            continue
            fi

            if ((o1 < 1 || o1 > 223)); then
                echo "Classe IP non valide (A/B/C uniquement)."
            continue
            fi

            check_ip=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM Equipement WHERE adIP='$ip';")
            if [[ "$check_ip" -ne 0 ]]; then
                echo "Cette adresse IP existe déjà dans la base de données."
            continue
            fi
            break
        done

        while true; do
            read -p "Saisissez le CIDR (valeur entre 1 et 24) : " cidr

            if [[ ! "$cidr" =~ ^[0-9]{1,2}$ ]]; then
                echo "Format invalide : le CIDR doit être un nombre entier."
            continue
            fi

            if ((cidr < 1 || cidr > 24)); then
                echo "Valeur CIDR hors plage : doit être entre 1 et 24."
            continue
            fi
            break
        done

        while true; do
            read -p "Saisissez l'identifiant du type d'équipement : " idT
            check_type=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM TypeE WHERE id='$idT';")
            if [[ "$check_type" -eq 0 ]]; then
                echo "Cet identifiant de type d’équipement n'existe pas dans la base."
            continue
            fi
            break
        done

        mysql -u $USER -p$MDP -D $BDD_NOM -e "INSERT INTO Equipement (id, nom, adMAC, adIP, CIDR, idT) VALUES ('$id', '$nom', '$mac', '$ip', '$cidr', '$idT');"
        echo "Équipement ajouté avec succès !"
		;;
	2 )
        read -p "Saisissez l'identifiant du type : " id
        check_id=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM TypeE WHERE id='$id';")
        if [[ "$check_id" -ne 0 ]]; then
            echo "L'ID existe déjà dans la table TypeE."
            continue
        fi

        while true; do
            read -p "Saisissez le libellé du type : " libelle
            check_libelle=$(mysql -u $USER -p$MDP -D $BDD_NOM -N -s -e "SELECT COUNT(*) FROM TypeE WHERE libelle='$libelle';")
            if [[ "$check_libelle" -ne 0 ]]; then
                echo "Ce libellé existe déjà dans la base de données."
            continue
            fi
            break
        done

        mysql -u $USER -p$MDP -D $BDD_NOM -e "INSERT INTO TypeE (id, libelle) VALUES ('$id', '$libelle');"
        echo "Type d'équipement ajouté avec succès !"
		;;
	0 )
		quitter=0
		;;
	* )
		echo "Erreur dans la saisie"
		;;
esac
done