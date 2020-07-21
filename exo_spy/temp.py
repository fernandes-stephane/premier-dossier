
import pandas as pd
import sqlalchemy as db

engine = db.create_engine('mysql+pymysql://Simplon:simplon123!@localhost/exo_workbench')


#result = engine.execute('SELECT MAX(cl_id) as Max FROM clients')
#row = result.fetchone()
#print(row.Max)
"""
result = engine.execute('SELECT * FROM clients')
for line in result:
    print(line.cl_nom)

data = pd.read_sql_query('SELECT * FROM clients;', engine)

print(data)

cl_id = pd.read_sql_query('SELECT max(cl_id) as max FROM clients;' , engine)['max'].values

engine.execute("INSERT INTO clients (cl_id  , cl_nom, cl_prenom, cl_adresse, cl_codepostal, cl_ville) VALUES (122, 'meme', 'lolo', ' 43 reu ii', 83388, 'cannes')")

cl_id = input("Entreez l'id : ")
cl_id = 0
cl_id = cl_id[0] + 1
"""


cl_id =pd.read_sql_query('select max(cl_id) from clients',engine)
cl_id = cl_id.iloc [0,0] + 1

cl_prenom = input("Entrez votre prenom : ")
cl_nom = input("entrez votre nom : ").upper()
cl_adresse = input("Entrez votre adresse : ")
chiffre = input("Entrez votre code postal : ")

while chiffre.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre = input("Entrez votre code postal : ")
cl_codepostal = int(chiffre)

cl_ville = input("Entrez votre ville : ")

engine.execute('INSERT INTO clients (cl_id, cl_nom, cl_prenom,  cl_adresse,  cl_codepostal, cl_ville) VALUES ( %s, "%s", "%s", "%s", %s, "%s" );' %(cl_id, cl_nom, cl_prenom,  cl_adresse,  cl_codepostal, cl_ville))

data2 = pd.read_sql_query('SELECT * FROM clients;', engine)

print(data2)


co_id =pd.read_sql_query('select max(co_id) from contrat',engine)
co_id = cl_id

co_date = input()

# co_date =datetime.today().strftime('%Y-%m-%d')
# print(co_date)

chiffre_categorie = input("Entrez la categorie : ")
while chiffre_categorie.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre_categorie = input("Entrez votre categorie : ")
co_categorie = int(chiffre_categorie)

chiffre_bonusmalus = input("Entrez la categorie : ")
while chiffre_bonusmalus.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre_bonusmalus = input("Entrez votre categorie : ")
co_bonusmalus = int(chiffre_bonusmalus)

chiffre_prix = input("Entrez la categorie : ")
while chiffre_prix.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre_prix = input("Entrez votre categorie : ")
prix = int(chiffre_prix)

co_client_fk = cl_id

co_vehicule_utilitaire_fk = 1

co_avenant_fk = 1

co_vehicule_tourisme_fk = 1

co_agence_fk = 1

engine.execute('INSERT INTO contrat (co_id, co_date, co_categorie, co_bonusmalus, prix, co_client_fk, co_vehicule_utilitaire_fk, co_avenant_fk, co_vehicule_tourisme_fk, co_agence_fk) VALUES (%s, %s, "%s", %s, %s, %s, %s, %s, %s, %s);' %co_id, co_date, co_categorie, co_bonusmalus, prix, co_client_fk, co_vehicule_utilitaire_fk, co_avenant_fk, co_vehicule_tourisme_fk, co_agence_fk ) 

Contrat = pd.read_sql_query('SELECT * FROM contrat;', engine)

print(Contrat)

import datetime

d1 = date.today.strftime("%d/%m/%Y")
print("d1 =", d1)
