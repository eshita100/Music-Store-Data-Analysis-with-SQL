--Who is the senior most employee based on job title?
select first_name,last_name,levels from employee
	order by levels desc
		limit 1

--which country have the most Invoices?
select * from invoice

select billing_country,count(invoice_id) as c from invoice 
	group by billing_country 
		order by c

--what are the top 3 values of total invoice
select total from invoice 
	order by total desc limit 3

--city name and sum of all invoice totals
select billing_city,sum(total) invoice_total from invoice
	group by billing_city
	order by invoice_total desc
	limit 3


--write a quary that returns the person who spent the most money
select * from customer c join invoice i on c.customer_id=i.customer_id


--which city has the best customers?
select * from invoice
select * from customer

select c.city,i.total from invoice i join customer c on i.customer_id=c.customer_id order by total desc


--Best customer(who purchased the most)
select c.first_name,c.last_name,sum(i.total) as Total_amount
	from customer c join invoice i
		on i.customer_id=c.customer_id
			group by c.customer_id
			order by Total_amount desc
			limit 1

--Write a query to return the email,name,Genre of all rock music listener.And
--Return the list ordered alphebetically by email start with A

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

--Another easy way
SELECT DISTINCT email,first_name, last_name,genre.name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track on  invoice_line.track_id=track.track_id
JOIN genre on track.genre_id=genre.genre_id
where genre.name = 'Rock'

order by email

--The singer who have written the most rock music
select artist.artist_id,artist.name, count(artist.artist_id) as Number_Of_Songs from artist
join album on artist.artist_id=album.artist_id
join track on album.album_id=track.album_id
join genre on track.genre_id=genre.genre_id
where genre.name='Rock'
group by artist.artist_id
order by Number_Of_Songs desc
limit 10


--return track name that have song length longer than average song length.
--return name, miliseconds of each track
--Order by the song length with the longest songs listed first.
select * from track

select track_id,name,milliseconds
from track
where milliseconds> (select avg(milliseconds) from track)
ORDER BY milliseconds DESC;



