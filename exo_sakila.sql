SELECT monthname(rental_date) 
from rental 
where year(rental_date) = 2006;

SELECT *, datediff(return_date, rental_date) as duree_location 
from rental;

select * , hour(rental_date) 
from rental
where hour(rental_date) < 1 or year(rental_date) = 2005;

SELECT * , monthname(rental_date) from rental
where month(rental_date) between 4 and 5
order by month(rental_date) ASC;

select title from film 
-- where title not like 'le%';
where LEFT(title,2) <> 'le';

select title,
	case rating 
		when 'NC-17' then 'oui'
        else 'non'
    end as 'oui ou non'
from film 
where rating in ('PG-13', 'NC-17');

-- on peut faire avec IF :
-- if(rating = 'NC-17', 'oui', 'non')

select name from category
where left(name,1) in ('A', 'C');
-- on peut aussi faire :
-- where name like 'A%' or name like 'c%'

select left(name, 3)
from category;

select *, replace(first_name,'E', 'A') as modified_first_name
from actor;