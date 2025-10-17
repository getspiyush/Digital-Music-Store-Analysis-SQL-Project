'''SET 1
Q1: Who is the senior most employee based on job title?'''

select *from employee
order by levels desc limit 1;

'''Q2: Which countries have the most Invoices?'''

select count(*) as c ,billing_country from invoice
group by billing_country
order by c desc;

'''Q3: What are top 3 values of total invoice'''

select *from invoice
order by total desc limit 3;

'''Q4: Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city 
that has the highest sum of invoice totals. Return both the city name & sum of all 
invoice totals'''

select sum(cast(total as numeric)) as sumtotal,billing_city 
from  invoice 
group by billing_city 
order by sumtotal desc limit 1;

'''Q5: Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent
the most money.'''

select c.customer_id,c.first_name,c.last_name,sum(cast(i.total as numeric)) as total
from customer c join invoice i on c.customer_id=i.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total desc limit 1;

'''SET2
Q1: Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A'''

select distinct email,first_name,last_name,g.name
from customer c 
join invoice i on c.customer_id=i.customer_id
join invoice_line il on i.invoice_id=il.invoice_id
join track t on il.track_id=t.track_id
join genre g on cast(t.genre_id as numeric)=g.genre_id
where g.name = 'Rock'
order by email;

'''Q2: Lets invite the artists who have written the most rock music in our dataset.
Write a query that returns the Artist name and total track count of the top 10
rock bands'''

select artist.name, count(artist.album_id) as no_of_songs
from track
join album  on track.album_id=album.album_id 
join artist  on album.album_id=cast(artist.album_id as numeric)
join genre  on cast(track.genre_id as numeric)=genre.genre_id
where genre.name like 'Rock'
group by artist.album_id,artist.name
order by no_of_songs desc limit 10;

'''Q3: Return all the track names that have a song length longer than the average song
length. Return the Name and Milliseconds for each track. Order by the song
length with the longest songs listed first.'''

SELECT name, milliseconds FROM track
WHERE
   cast( milliseconds as numeric) > (
           SELECT AVG(cast(milliseconds as numeric))
           FROM track
           )
ORDER BY milliseconds DESC;



