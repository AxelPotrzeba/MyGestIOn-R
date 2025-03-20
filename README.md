Projet MyGest IOn'R

Introduction :

MyGest IOn'R est un projet de gestion de parc informatique, développé en Bash avec une base de données MySQL, dans le but de simplifier le quotidien des techniciens système et réseau. Ce projet propose une interface en ligne de commande permettant d'accéder à des outils utiles pour la gestion, la maintenance et le suivi d'un parc informatique, sans avoir à mémoriser toutes les commandes shell ou requêtes SQL complexes.

Le projet a été réalisé dans le cadre d'un module de développement automatisé pour les techniciens réseau. Il permet à l'utilisateur de gérer une base de données contenant les informations d'équipements réseau.

Le projet a été réalisé en équipe :
- **Axel Potrzeba** : Consultation et ajout de données
- ambengue23 : Suppression et modification de données
- Ehavox : Outils réseau
Je mets à disposition leurs liens vers leur GitHub :
- https://github.com/ambengue23/
- www.github.com/Ehavox

---

Structure du projet :

Le projet se divise en deux grandes parties :

### 1. Gestion du parc informatique
Permet la gestion de l'inventaire des équipements informatiques via une base MySQL.

2. Outils réseau
Permet d'utiliser des outils automatisés pour tester la connectivité et le fonctionnement du réseau.

---

Fonctionnalités des scripts :

### Partie 1 : Gestion du parc :

#### Mission 1 : Consultation des équipements
- Affiche les équipements enregistrés dans la base de données

#### Mission 2 : Ajout d'équipement ou de type d'équipement
- Ajout d'un nouvel équipement
- Ajout d'un type d'équipement

 Mission 3 : Suppression de données
- Suppression d'un équipement ou d'un type d'équipement à partir de son ID

Mission 4 : Modification de données
- Modification des informations d'un équipement existant (nom, IP, etc.)

Partie 2 : Outils réseau :

Mission 1 : Test d'une adresse IP
- Envoie un ping à une IP et affiche si elle est active ou non

Mission 2 : Test d'un port TCP
- Vérifie si un port spécifique est ouvert sur une IP donnée

Mission 3 : Export de la base vers un fichier texte
- Génère un fichier .txt contenant des données de la BDD (ex : liste des IP)

Mission 4 : Scan d'activité des IP
- Teste toutes les IP de la BDD et affiche en couleur celles qui répondent

---

Structure de la base de données :

Table `Equipement`
| Champ  | Type    | Description                        |
|--------|---------|------------------------------------|
| id     | VARCHAR | Identifiant de l'équipement        |
| nom    | VARCHAR | Nom de l'équipement                |
| adMAC  | VARCHAR | Adresse MAC                       |
| adIP   | VARCHAR | Adresse IP                        |
| CIDR   | INT     | Notation CIDR (1 à 24)             |
| idT    | VARCHAR | Référence vers TypeE (foreign key) |

Table `TypeE`
| Champ   | Type    | Description                    |
|--------|---------|--------------------------------|
| id      | VARCHAR | Identifiant du type            |
| libelle | VARCHAR | Libellé du type d'équipement     |

---

Arborescence et exécution du projet :

Le projet est composé de plusieurs scripts qui sont appelés via des menus.

L'utilisateur lance le script principal `myGestIOnR.sh`, qui présente un menu interactif. À partir de ce menu, l'utilisateur accède aux différentes fonctionnalités via des sous-menus ou des scripts d'action.

> Des captures d'écran seront ajoutées pour illustrer les menus affichés et la navigation utilisateur.
![menu](https://github.com/user-attachments/assets/922a8136-25fa-41b0-9d13-311e2aa2ccc9)
![menu-gest-parc](https://github.com/user-attachments/assets/9544c5b0-216a-47d0-bbad-f36f9a9f2305)
![menu-outils-reseau](https://github.com/user-attachments/assets/176e38a8-5ef8-4561-b2af-74198c17ab70)


Exemple d'arborescence :
```
MyGest/
├── myGestIOnR.sh
├── ajout.sh
├── consultation.sh
├── suppression.sh
├── modification.sh
├── outils_ip.sh
├── outils_ports.sh
├── export_txt.sh
├── scan_ip.sh
├── config.sh
├── fonction.sh
├── install.sh
└── README.md
```

