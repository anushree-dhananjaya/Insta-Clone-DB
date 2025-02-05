-- To reward our users who have been around the longest; to find 5 oldest users

select * from users Order by created_at Limit 5;

-- AD Campagin - What day of the week do most users register on ?

Select dayname(created_at) as day, count(*) as total  from users
Group by day
Order by total desc
Limit 2;

-- To target our inactive users with an email campaign 

select username
From users
left Join photos
 on users.id = photos.user_id
 where photos.id is Null;

-- Planning to run a new contest to see who can get the most likes on single photo

select 
	users.username,
    photos.image_url,
    photos.id ,
    count(*) as total
from users
Inner join photos
	on users.id = photos.user_id
Inner Join likes
   on photos.id = likes.photo_id
Group by photos.id 
order by total desc
Limit 2;




-- How many times does average users post ? ( avg no of photos per users) 

Select(
(Select count(*) from photos) /
(select count(*) from users) ) as avg;



-- A brand wants to know which hashtags to use in a post; top 5



SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 



-- We have a small problem with bots on site ( to identify the user who has liked every single photo on the site)

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 


