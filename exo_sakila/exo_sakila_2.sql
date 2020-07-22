-- Questions pour aller plus loin : 
USE sakila;

# 1- Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée)

SELECT C.first_name, C.last_name, F.title, S.store_id, datediff(R.return_date, R.rental_date) 
FROM rental AS R
JOIN inventory AS I
	ON R.inventory_id = I.inventory_id
JOIN film AS F
	ON I.film_id = F.film_id
JOIN customer AS C
	ON R.customer_id = C.customer_id
JOIN store AS S
	ON C.store_id = S.store_id
ORDER BY datediff(R.return_date, R.rental_date) DESC LIMIT 10
;

# 2- Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé)

SELECT customer.last_update, customer.first_name, payment.amount FROM payment
JOIN rental
	ON payment.rental_id = rental.rental_id
JOIN customer
	ON rental.customer_id = customer.customer_id
ORDER BY payment.amount DESC
LIMIT 10
;

# 3- Afficher la durée moyenne de location par film triée de manière descendante

SELECT film.title, AVG(datediff(rental.return_date, rental.rental_date) ) FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY AVG(datediff(rental.return_date, rental.rental_date) ) DESC
;

# 4- Afficher tous les films n'ayant jamais été empruntés

select film.title from film 
left join inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE inventory.inventory_id IS NULL;

# 5- Afficher le nombre d'employés (staff) par video club

SELECT count(staff_id) FROM staff
JOIN store
	ON staff.staff_id = store.manager_staff_id
GROUP BY store.store_id;

# 6- Afficher les 10 villes avec le plus de video clubs

SELECT city.city FROM store
JOIN address
	ON store.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
;

SELECT * FROM address
JOIN store
	ON store.address_id = address.address_id
;

# 7- Afficher le film le plus long dans lequel joue Johnny Lollobrigida

SELECT film.title, actor.last_name, max(film.length) FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id
WHERE actor.last_name = 'Lollobrigida' AND actor.first_name = 'Johnny'
GROUP BY film.title
ORDER BY MAX(film.length) DESC
LIMIT 1
;

# 8- Afficher le temps moyen de location du film 'Academy dinosaur'

SELECT film.title, AVG(datediff(rental.return_date, rental.rental_date) ) FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
WHERE film.title = 'Academy dinosaur'
;

# 9- Afficher les films avec plus de deux exemplaires en invenatire (store id, titre du film, nombre d'exemplaires)


# pas fini ---> 
SELECT * FROM inventory
;


SELECT film.title, inventory.store_id, inventory.film_id  FROM inventory
JOIN film
	ON inventory.film_id = film.film_id
 WHERE inventory.film_id > 2 ;

;


SELECT DISTINCT film.title, inventory.store_id, COUNT(inventory.film_id) AS inventaire FROM inventory
JOIN film
	ON inventory.film_id = film.film_id
# WHERE inventaire > 2 ;
GROUP BY film.title, inventory.store_id

;

# 10- Lister les films contenant 'din' dans le titre

SELECT film.title FROM film
WHERE film.title LIKE '%din%'
;

# 11- Lister les 5 films les plus empruntés

SELECT film.title,  COUNT(rental.rental_date) FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title 
ORDER BY COUNT(rental.rental_date) DESC
LIMIT 5
;

# 12- Lister les films sortis en 2003, 2005 et 2006

SELECT film.title, film.release_year FROM film
WHERE film.release_year = '2003' or '2005' or '2006'
;

# 13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. Afficher seulement les 10 premiers.

SELECT film.title, rental.rental_date FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date IS NULL
ORDER BY rental.rental_date 
LIMIT 10
;

# 14- Afficher les films d'action durant plus de 2h

SELECT film.title, film.length, category.name FROM film
JOIN film_category
	ON film.film_id = film_category.film_id
JOIN category
	ON film_category.category_id = category.category_id
WHERE film.length > 120 AND category.name = 'action'
;

# 15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17

select customer.first_name, customer.last_name, film.title, film.rating from film 
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
JOIN customer
	ON rental.customer_id = customer.customer_id
where rating in ( 'NC-17');

# 16- Afficher les films d'animation dont la langue originale est l'anglais

SELECT film.title, category.name, language.name FROM film
JOIN film_category
	ON film.film_id = film_category.film_id
JOIN category
	ON film_category.category_id = category.category_id
JOIN language
	ON film.language_id = language.language_id 
WHERE category.name = 'action' AND language.name = 'English'
;

# 17- Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny)

SELECT film.title, actor.first_name FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id

WHERE actor.first_name = 'Johnny'
UNION 
SELECT film.title, actor.first_name FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id

WHERE actor.first_name = 'Jennifer'
;

# 18- Quelles sont les 3 catégories les plus empruntées?

SELECT film.title, COUNT(rental.rental_date) FROM rental
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_date) DESC
;

# 19- Quelles sont les 10 villes où on a fait le plus de locations?

SELECT city.city, COUNT(rental.rental_date) FROM rental
JOIN customer
	ON rental.customer_id = customer.customer_id
JOIN address
	ON customer.address_id = address.address_id 
JOIN city
	ON address.city_id = city.city_id
GROUP BY city.city 
ORDER BY COUNT(rental.rental_date) DESC LIMIT 10
;

# 20- Lister les acteurs ayant joué dans au moins 1 film

SELECT DISTINCT actor.first_name, actor.last_name FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id
WHERE film.film_id IS NOT NULL

;



SELECT DISTINCT actor.first_name, actor.last_name FROM film
LEFT JOIN film_actor
	ON film.film_id = film_actor.film_id
LEFT JOIN actor
	ON film_actor.actor_id = actor.actor_id
WHERE film.film_id IS NOT NULL

;




