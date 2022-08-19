------NOTES IMPORTANTES :
--> N'oubliez pas de changer le chemin des fichiers csv lorsque vous les avez sur votre propre ordinateur
--> Ne changez pas le nom des fichiers csv car ils correspondent aux tableaux dans les commandes ci-dessous
--> Ex�cuter les commandes exactement dans le m�me ordre


COPY musicien FROM 'C:\Users\Public\Csv files\table musicien.csv' CSV HEADER; --1000 rows
COPY agent FROM 'C:\Users\Public\Csv files\table agent.csv' CSV HEADER; --1000 rows
COPY producteur FROM 'C:\Users\Public\Csv files\table producteur.csv' CSV HEADER; --1000 rows
COPY instrument FROM 'C:\Users\Public\Csv files\table instrument.csv' CSV HEADER; --6 rows
COPY style_musique FROM 'C:\Users\Public\Csv files\table style_musique.csv' CSV HEADER; --6 rows
COPY contrat_agent_artiste FROM 'C:\Users\Public\Csv files\table contrat_agent_artiste.csv' CSV HEADER;--100 rows
COPY contrat_artiste_producteur FROM 'C:\Users\Public\Csv files\table contrat_artiste_producteur.csv' CSV HEADER;
COPY demande FROM 'C:\Users\Public\Csv files\table demande.csv' CSV HEADER; --50 rows
COPY paiement_artiste FROM 'C:\Users\Public\Csv files\table paiement_artiste.csv' CSV HEADER;
COPY albums FROM 'C:\Users\Public\Csv files\table album.csv' CSV HEADER; --30
COPY joue FROM 'C:\Users\Public\Csv files\table joue.csv' CSV HEADER;--1000 rows (matching the musicians)
COPY maitrise FROM 'C:\Users\Public\Csv files\table maitrise.csv' CSV HEADER; --1000 rows (matching the musicians)