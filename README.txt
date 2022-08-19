README.txt
----------------------------

a. Auteurs du projet
- Sofien HENCHIR : sofien.henchir.tn@gmail.com 
- Leonard NAMOLARU : leonard.namolaru@etu.u-paris.fr 

b. Informations g�n�rales
L�objectif du projet est la mod�lisation, le peuplement, et la mise en place d�une base de donn�es d�une agence artistique.
Conform�ment � la recommandation de M. Zielonka, lors de la pr�-soutenance tenue en avril, nous avons d�cid� d'axer notre projet
sur la cr�ation d'une base de donn�es pour une agence repr�sentant des musiciens.

c. Les donn�es
Pour g�n�rer des donn�es sous forme de fichiers csv, nous avons utilis� l'outil 'Mockaroo' qui est un g�n�rateur de donn�es.

Nous avons choisi d'ins�rer les donn�es comme ci-dessous :
-1000 musiciens
-1000 agents
-1000 producteurs
-6 instruments
-6 styles de musique
-50 demande
-100 contrat agence artiste
-30 albums

d. Instructions pour le d�marrage

Afin de d�marrer le projet, veuillez, s'il vous pla�t, suivre les instructions ci-dessous :

1. Depuis votre bureau, cliquez sur "SQL Shell (psql)".

2. Cr�ation d'une base de donn�es
postgres=# CREATE DATABASE projet_bdd;
CREATE DATABASE
postgres=# \c projet_bdd;
Vous �tes maintenant connect� � la base de donn�es � projet_bdd � en tant qu'utilisateur � YOUR_USER_NAME �.

3.L'importation du fichier create_all.sql peut �tre effectu�e par la commande suivante :
projet_bdd=# \i 'C:/Users/lenny/git/bdav-agence-artistique/CREATION/create_all.sql'

4. \include 'C:/Users/lenny/git/bdav-agence-artistique/CREATION/create_triggers.sql'
5. \include 'C:/Users/lenny/git/bdav-agence-artistique/CREATION/create_functions.sql'

6. Ouvrez, s'il vous pla�t, le fichier /CREATION/insert_data.sql et modifiez les chemins des fichiers .csv en fonction de l'emplacement o� ils se trouvent sur votre ordinateur.
Pour �viter de recevoir des messages d'erreur de type "ERREUR:  n'a pas pu ouvrir le fichier ... pour une lecture : Permission denied",
Il est recommand� de placer les fichiers sous le dossier 'C:\Users\Public' (si vous utilisez Windows) ou sous '/tmp' (si vous utilisez Mac ou Linux) [1].

7. Les donn�es peuvent maintenant �tre import�es :
projet_bdd=# \i 'C:/Users/lenny/git/bdav-agence-artistique/CREATION/insert_data.sql'

Si vous recevez un message d'erreur de type "ERREUR: valeur du champ date/time en dehors des limites ...Peut-�tre avez-vous besoin d'un param�trage � datestyle � diff�rent.",
une fa�on de r�soudre ce probl�me est de taper la commande suivante (pour le format : dd/mm/yyyy) [2] :
projet_bdd=# SET DATESTYLE = US; 


e. Les fonctions suivantes sont � votre disposition (fonctions PL/pgSQL pour les operations courantes de gestion) :

---------------------------------------- TABLE MUSICIEN ---------------------------------------------------------

----- musicien_existe(nom text, prenom text, date_naissance date, telephone text, adresse text, mail text) -> INTEGER
Description : Une fonction qui re�oit comme param�tres nom, prenom, t�l�phone, etc. et v�rifie si un tel musicien existe.

Parametres :
nom text : la nom du musicien.
prenom text : le prenom du musicien.
date_naissance date : la date de naissance du musicien
telephone text : le telephone de l'agent (format : '123-456-1234')
adresse text : l'adresse du musicien
mail text : l'adresse mail du musicien (format : 'X@Y.Z')
  
Valeur de retour : le numero d'id du musicien si il existe ou -1 en cas d�erreur (le musicien existe PAS).

-----  ajout_musicien(nom text, prenom text, date_naissance date, telephone text, adresse text, mail text, instruments INTEGER[], styles_musique INTEGER[]) -> BOOLEAN
Description : Une fonction qui re�oit comme param�tres : nom, prenom, t�l�phone, etc. et ajoute un nouveau musicien s'il n'existe pas deja.
               De plus, la fonction re�oit en param�tre 2 tableaux : 
                - un tableau des id des instruments de musique que le musicien maitrise
                - un tableau des id des styles de musique du musicien. 
              La fonction ajoute ces informations aux tables appropri�es.
 
Parametres :
nom text : la nom du musicien.
prenom text : le prenom du musicien.
date_naissance date : la date de naissance du musicien
telephone text : le telephone de l'agent (format : '123-456-1234')
adresse text : l'adresse du musicien
mail text : l'adresse mail du musicien (format : 'X@Y.Z')
instruments INTEGER[] : un tableau des id des instruments de musique que le musicien maitrise (Par exemple : '{1,2}')
 styles_musique INTEGER[] : un tableau des id des styles de musique du musicien (Par exemple : '{1,2}')

Valeur de retour : true si le musicien est ajout� avec succ�s, false si le musicien existe d�j�.

---------------------------------------- TABLE CONTRAT_ARTISTE_PRODUCTEUR --------------------------------------------
-----  contrat_reste_a_payer(id_contrat integer) ->  integer
Description : Trouver les demandes adapt�es a un musicien. C'est-�-dire des demandes qui 
               n'ont pas encore expir� (qui n'ont pas encore atteint leur date de fin) et 
               qui incluent des instruments de musique et un style de musique qui conviennent au musicien.
 
Parametres :
id_contrat integer : ID du contrat artiste producteur.

Valeur de retour : La fonction retourne le reste a payer (somme de la renumeration total - paiements anterieurs)

---------------------------------------- TABLE DEMANDE ---------------------------------------------------------------
-----  trouver_musiciens_repondre_demande(id_demande integer, musiciens_exclure_resultats integer[]) -> BOOLEAN
Description : Trouver des musiciens pour r�pondre � une demande. C'est-�-dire que la fonction trouve la liste des musiciens 
 			  qui contr�lent l'instrument qui appara�t dans la demande et en m�me temps ce sont des musiciens dont le style 
               de musique est tel qu'il appara�t dans la demande.
 
Parametres :
id_demande integer : ID de la demande.

Valeur de retour : La fonction retourne un type �ensemble� (SETOF) de la table musicien 

-----  trouver_demandes_adaptees_musicien(id_musicien integer)  ->  SETOF demande
Description : Trouver les demandes adapt�es a un musicien. C'est-�-dire des demandes qui 
              n'ont pas encore expir� (qui n'ont pas encore atteint leur date de fin) et 
              qui incluent des instruments de musique et un style de musique qui conviennent au musicien.
 
Parametres :
id_musicien integer : ID du musicien.

Valeur de retour : La fonction retourne un type �ensemble� (SETOF) de la table demande 

---------------------------------------- TABLE CONTRAT_AGENT_ARTISTE --------------------------------------------
----- exportation_contrats_en_vigueur(systeme_exploitation text) -> void
Description : Exportation de tous les contrats actuellement en vigueur. 
               La destination pour l'exportation sur Windows : C:\Users\Public\contrats_en_vigueur.csv 
 	          La destination pour l'exportation sur Linux ou Mac : /tmp/contrats_en_vigueur.csv

Parametres :
systeme_exploitation text : Cette fonction ne peut accepter que une les valeurs suivantes en tant que parametre : WINDOWS LINUX MAC.

Valeur de retour : void

---------------------------------------- TABLE AGENT ---------------------------------------------------------
----- agent_existe(nom text, prenom text, telephone text, date_embauche DATE) -> INTEGER
Description : Une fonction qui re�oit comme param�tres nom, prenom, t�l�phone, etc. et v�rifie si un tel agent existe.

Parametres :
nom text : la nom de l'agent.
prenom text : le prenom de l'agent.
telephone text : le telephone de l'agent (format : '123-456-1234')
date_embauche DATE : la date d'embauche de l'agent

Valeur de retour : le numero d'id de l'agent si il existe ou -1 en cas d�erreur (l'agent existe PAS).

----- ajout_agent(nom text, prenom text, telephone text, date_embauche DATE) -> BOOLEAN
Description : Une fonction qui re�oit comme param�tres : nom, prenom, t�l�phone, etc. et ajoute un nouveau agent s'il n'existe pas deja.
 
Parametres :
nom text : la nom de l'agent.
prenom text : le prenom de l'agent.
telephone text : le telephone de l'agent (format : '123-456-1234')
date_embauche DATE : la date d'embauche de l'agent

Valeur de retour : true si l'agent est ajout� avec succ�s, false si l'agent existe d�j�.

-----
[1] Permission Denied error when using PostgreSQL's COPY FROM/TO command : https://www.neilwithdata.com/copy-permission-denied
[2] PostgreSQL Documentation
    https://www.postgresql.org/docs/9.1/datatype-datetime.html#DATATYPE-DATETIME-OUTPUT2-TABLE
    https://www.postgresql.org/docs/7.2/sql-set.html