use sakila;
 # 1. Lister les 10 premiers films ainsi que leur langues:
 
 
 # 2. Afficher les films dans les quel:
 
SELECT title, first_name, last_name FROM actor as a
JOIN film_actor as fa
	ON a.actor_id = fa.actor_id
JOIN film 
	ON fa.film_id = fa.film_id
WHERE a.last_name = 'DAVIS'
	AND a.first_name = 'JENNIFER'
	AND film.release_year = 2006;
    
# Afficher le noms des clients ayant emprunté "ALABAMA DEVIL"

SELECT first_name, last_name, film.title FROM customer as client
JOIN rental
	ON client.customer_id = rental.customer_id
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
WHERE film.title = 'ALABAMA DEVIL';

# 4. Afficher les films louer par des personne habitant à « Woodridge ».#	
#	 Verifie s’il y a des films qui n’ont jamais ete emprunte.


select film.title from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join customer on rental.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
where city.city = 'Woodridge'
union
select film.title from film 
join inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;




# Quel sont les 10 films dont la durée d’emprunt à été la plus courte ?

SELECT title, datediff(return_date, rental_date) as duree_location 
FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
    where datediff(return_date, rental_date) is not null
order by duree_location
LIMIT 10;

# 6. Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

select title, category.name FROM film 
JOIN film_category
	ON film.film_id =  film_category.film_id
JOIN category
	ON film_category.category_id = category.category_id 
WHERE category.name = 'Action';

# 7. Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?

USE sakila;

SELECT DISTINCT film.title, datediff(rental.return_date, rental.rental_date)
FROM rental
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
WHERE datediff(rental.return_date, rental.rental_date) <2 ;


select datediff(return_date, rental_date) from rental;

SELECT F.title, timediff(R.return_date, R.rental_date)
FROM film as F
JOIN inventory as I
	ON F.film_id = I.film_id
JOIN rental as R
	ON I.inventory_id = R.inventory_id
WHERE timediff(R.return_date, R.rental_date) < '47:00:00'
AND timediff(R.return_date, R.rental_date) IS NOT NULL;



SELECT DISTINCT title,timediff(return_date,rental_date),date_sub(timediff(return_date,rental_date ), INTERVAL 48 HOUR)
FROM film 
INNER JOIN inventory ON inventory.inventory_id = film.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
WHERE return_date IS NOT NULL AND date_sub(timediff(return_date,rental_date ), INTERVAL 48 HOUR) < 0
ORDER BY timediff(return_date,rental_date);


SELECT datediff('2020-07-13 10:33:55', '2020-07-01 13:22:00');

SELECT F.title, L.name FROM film AS F
LEFT JOIN language AS L
	ON F.language_id = L.language_id
WHERE L.name IS NULL;
    
SELECT F.title, L.name FROM film AS F
RIGHT JOIN language AS L
	ON F.language_id = L.language_id
WHERE F.title IS NULL;




SELECT COUNT(F.title), C.name
FROM film AS F
JOIN film_actor AS FA
	ON F.film_id = FA.film_id
JOIN actor AS A
	ON FA.actor_id = A.actor_id
JOIN film_category AS FC
	ON F.film_id = FC.film_id
JOIN category as C
	ON FC.category_id = C.category_id
WHERE A.last_name = 'LOLLOBRIGIDA' AND A.first_name = 'JOHNNY'
GROUP BY C.name;

SELECT COUNT(F.title) AS total, C.name
FROM film AS F
JOIN film_actor AS FA
	ON F.film_id = FA.film_id
JOIN actor AS A
	ON FA.actor_id = A.actor_id
JOIN film_category AS FC
	ON F.film_id = FC.film_id
JOIN category as C
	ON FC.category_id = C.category_id
WHERE A.last_name = 'LOLLOBRIGIDA' AND A.first_name = 'JOHNNY'
GROUP BY C.name
HAVING total > 3;

SELECT AVG(datediff(R.return_date,R.rental_date)), A.first_name, A.last_name FROM rental AS R
JOIN inventory AS I
	ON R.inventory_id = I.inventory_id
JOIN film AS F
	ON I.film_id = F.film_id
JOIN film_actor AS FA
	ON F.film_id = FA.film_id
JOIN actor AS A
	ON FA.actor_id = A.actor_id
GROUP BY A.actor_id 
ORDER BY AVG(datediff(R.return_date, R.rental_date))
;

#4.

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY total DESC;

# afficher tous les films ayant été loués 10 fois ou plus

SELECT film.title, count(rental.rental_date)
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id


# 1- Quels acteurs ont le prénom "Scarlett "

use sakila;

SELECT A.first_name, A.last_name FROM actor AS A
WHERE A.first_name = 'Scarlett';

# 2- Quels acteurs ont le nom de famille "Johansson"

SELECT A.first_name, A.last_name FROM actor AS A
WHERE A.last_name = 'Johansson';

# 3- Combien de noms de famille d'acteurs distincts y a-t-il ? 

#SELECT  A.last_name FROM actor AS A
#GROUP BY A.last_name ;

SELECT COUNT(DISTINCT last_name)
FROM actor;

# 4- Quels noms de famille ne sont pas répétés ? 

SELECT A.last_name FROM actor AS A
GROUP BY A.last_name 
HAVING COUNT(last_name) =1
;



# 5- Quels noms de famille apparaissent plus d'une fois ? 

SELECT A.last_name FROM actor AS A
GROUP BY A.last_name 
HAVING COUNT(last_name) >1
;


# 6- Quel acteur est apparu dans le plus grand nombre de films ? 

SELECT A.first_name FROM actor AS A


# 7- Insérez un enregistrement représentant Mary Smith louant "Academy Dinosaur" de Mike Hillyer au magasin 1 aujourd'hui. 

# 8- Quand "Academy Dinosaur" est-il sortie ? 

# 9- Quelle est la durée moyenne de tous les films ? 

# 10- Quelle est la durée moyenne des films par catégorie ?