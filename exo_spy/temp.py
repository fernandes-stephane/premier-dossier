import pandas as pd
import sqlalchemy as db
from datetime import datetime

engine = db.create_engine('mysql+pymysql://Simplon:simplon123!@localhost/exo_workbench')

"""
result = engine.execute('SELECT MAX(cl_id) as Max FROM clients')
row = result.fetchone()
print(row.Max)

result = engine.execute('SELECT * FROM clients')
for line in result:
    print(line.cl_nom)


cl_id = pd.read_sql_query('SELECT max(cl_id) as max FROM clients;' , engine)['max'].values

engine.execute("INSERT INTO clients (cl_id  , cl_nom, cl_prenom, cl_adresse, cl_codepostal, cl_ville) VALUES (122, 'meme', 'lolo', ' 43 reu ii', 83388, 'cannes')")
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

# print(data2)





"""
co_id 2eme facon:
co_id = pd.read_sql_query('select max(co_id) as max2 from contrat',engine)['max'].values
co_id = 1

co_date 2eme facon:
co_date =datetime.today().strftime('%Y-%m-%d')
print(co_date)

co_date = pd.read_sql_query(" SELECT curdate() ", engine)
print(co_date)

-> co_date est dans la requete sql dans VALUES

"""

co_id = pd.read_sql_query('select (max(co_id)+1) from contrat',engine)
co_id = co_id.iloc [0,0] + 1

co_categorie = input("Entrez le type de contrat : ")

chiffre_bonusmalus = input("Entrez le bonus / malus : ")
while chiffre_bonusmalus.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre_bonusmalus = input("Entrez le bonus / malus  : ")
co_bonusmalus = int(chiffre_bonusmalus)

chiffre_prix = input("Entrez le prix : ")
while chiffre_prix.isdigit() != True:
    print("votre chiffre n'est pas un chiffre ")
    chiffre_prix = input("Entrez le prix : ")
prix = int(chiffre_prix)

co_client_fk = cl_id
co_vehicule_utilitaire_fk = 1
co_avenant_fk = 1
co_vehicule_tourisme_fk = 1
co_agence_fk = 1

engine.execute('INSERT INTO contrat (co_id, co_date, co_categorie, co_bonusmalus, prix, co_client_fk, co_vehicule_utilitaire_fk, co_avenant_fk, co_vehicule_tourisme_fk, co_agence_fk) VALUES ( %s, CURDATE() , "%s", %s, %s, %s, %s, %s, %s, %s);' %(co_id, co_categorie, co_bonusmalus, prix, co_client_fk, co_vehicule_utilitaire_fk, co_avenant_fk, co_vehicule_tourisme_fk, co_agence_fk )) 












print(data2)


Contrat = pd.read_sql_query('SELECT * FROM contrat;', engine)





print(Contrat)



# pd.read_sql_query("SHOW columns FROM contrat;", engine)


