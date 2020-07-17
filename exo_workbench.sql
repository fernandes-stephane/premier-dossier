

CREATE database IF NOT exists exo_workbench;

use exo_workbench;

CREATE TABLE IF NOT EXISTS clients(
	cl_id INT NOT NULL PRIMARY KEY,
	cl_nom 	varchar(30) NOT NULL,
    cl_prenom VARCHAR(30) NOT NULL,
	cl_adresse VARCHAR(100) NOT NULL,
	cl_codepostal INT NOT NULL,
	cl_ville VARCHAR (30) NOT NULL CHECK (cl_ville = "")
);

CREATE TABLE IF NOT EXISTS contrat(
	co_id INT NOT NULL PRIMARY KEY,
    co_date DATE NOT NULL,
    co_categorie VARCHAR (30) NOT NULL,
    co_bonusmalus FLOAT NOT NULL,
    prix FLOAT NOT NULL,
    co_client_fk INT NOT NULL,
	FOREIGN KEY (co_client_fk) REFERENCES clients (cl_id)
);
INSERT INTO clients (cl_id, cl_nom, cl_prenom, cl_adresse, cl_codepostal, cl_ville) VALUES
 	(9,'DUPON', 'Patrick', 'avenue de la ville', 06400, 'cannes'),
	(7, 'DULAC', 'René', 'avenue des champs', 06400, 'cannes'),
    (12, 'DELAFORET', 'Fred', 'avenue des iles', 06110, 'le cannet');
    
INSERT INTO contrat(co_id, co_date, co_categorie, co_bonusmalus, prix, co_client_fk) VALUES
 	(12, '2019-02-16', 'tiers', 0.5, 100, 9),
	(14, '2019-10-24', 'tout-risque', 1,200, 7),
	(13, '2020-01-11', 'tiers', 1.5,  150, 12);

SELECT * FROM clients;








