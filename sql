SELECT * from crime_scene_report where date like "20180115" and city like "SQL City" and type like"murder";
-> Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT *,MAX(address_number) from person where address_street_name like "Northwestern Dr";
-> 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949	4919

SELECT *from person where address_street_name like "Franklin Ave" and name like "Annabel%";
-> 16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT * from interview where person_id like 14887 or person_id like 16371;
-> 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
   16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT f.name, f.person_id, f.membership_status
FROM get_fit_now_member f
left JOIN person p ON f.person_id like p.id
left JOIN drivers_license d ON p.license_id like d.id
WHERE f.membership_status like "gold"
AND d.plate_number like "%H42W%";
-> Jeremy Bowers	67318	gold

INSERT INTO solution VALUES (1, 'Jeremy Bowers');    
        SELECT value FROM solution;
-> Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.

SELECT * from interview where person_id like "67318";
-> I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. 

SELECT * from drivers_license
where height BETWEEN "65" AND "67"
AND hair_color like "red"
AND car_make like "Tesla"
AND car_model like "Model S";

SELECT * FROM facebook_event_checkin
WHERE event_name like "SQL Symphony Concert"
AND date like "201712%"
group by person_id
having count(distinct date) = 3;

SELECT *
FROM facebook_event_checkin f
JOIN person p ON f.person_id like p.id
JOIN drivers_license d ON p.license_id like d.id
WHERE d.height BETWEEN "65" AND "67"
AND d.hair_color like "red"
AND d.car_make like "Tesla"
AND d.car_model like "Model S";
AND f.event_name like "SQL Symphony Concert"
AND f.date like "201712%"
group by f.person_id
having count(distinct f.date) = 3;
-> Miranda Priestly
