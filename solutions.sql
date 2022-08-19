
# Finding 5 oldest users 
SELECT * FROM users ORDER BY created_at LIMIT 5;



# What day of the week do most users register on?
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users 
GROUP BY day
ORDER BY total DESC;



# Target inactive users with an email campaign, find users who havent posted any photo
SELECT 
	username,
    photos.id,
    users.id
FROM users
	LEFT JOIN photos
    	ON users.id = photos.user_id
	WHERE photos.id IS NULL;
    
    
    
# Contest : most likes on pic wins
SELECT
    photos.user_id,
    users.username,
    COUNT(*) AS total_likes
FROM photos
JOIN users
    ON users.id = photos.user_id
JOIN likes
	ON photos.id = likes.photo_id
    GROUP BY photos.id
    ORDER BY total_likes DESC
    LIMIT 3;
    
    
    
# How many times does the average user post?
SELECT(
    SELECT COUNT(*) FROM photos)/
    (SELECT COUNT(*) FROM users) 
AS average;



# top 5 most used hashtags
SELECT
    tags.tag_name,
	COUNT(*) AS total
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
    GROUP BY tags.id
    ORDER BY total DESC
    LIMIT 5;
  
  
# find users who liked every single photo, find bots?
SELECT
    username,
    COUNT(*) AS total
FROM users
JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING (SELECT COUNT(*) FROM photos) = total;

