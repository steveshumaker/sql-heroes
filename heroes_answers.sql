-- 1. How many powers are there?
SELECT count(name) FROM super_powers;
-- 8

-- 2. List all heroes and their powers.
SELECT heroes.name, super_powers.name
FROM heroes
JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
JOIN super_powers ON super_powers.id = heroes_powers.super_power_id;

--Superman	Flight
--Superman	Super Strength
--Superman	Laser Vision
--Superman	Super Speed
--Batman	Super Intelligence
--Batman	Super Strength
--Batman	Super Speed
--Professor X	Telekinesis
--Professor X	Telepathy
--Professor X	Super Intelligence
--Wolverine	Healing Factor
--Wolverine	Super Strength
--Cyclops	Super Strength
--Cyclops	Laser Vision
--Cyclops	Super Speed

-- 3. Find all of Professor X's powers.
SELECT super_powers.name 
FROM super_powers
JOIN heroes_powers ON super_powers.id = heroes_powers.super_power_id
JOIN heroes ON heroes_powers.hero_id = heroes.id
WHERE heroes.name = 'Professor X';

--Telekinesis
--Telepathy
--Super Intelligence

-- 4. Add a new super power. 
INSERT INTO super_powers (name, description) VALUES ('Invisibility', 'Can be seen by nobody');

-- 5. Add this power to an existing hero.
INSERT INTO heroes_powers (hero_id, super_power_id, power_level) VALUES (4, 9, 2);

-- 6. Which heroes have laser vision? Include their name and alias.
SELECT heroes.name, heroes.alias
FROM heroes
JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
JOIN super_powers ON heroes_powers.super_power_id = super_powers.id
WHERE super_powers.name = 'Laser Vision';

--Superman	Clark Kent
--Cyclops	Scott Summers

-- 7. How many can fly? A twist on the above...
SELECT count(heroes.name), heroes.name
FROM heroes
JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
JOIN super_powers ON heroes_powers.super_power_id = super_powers.id
WHERE super_powers.name = 'Flight'
GROUP BY heroes.name;

-- 1 Superman

-- 8. What is the average super strength power level?
SELECT SUM(power_level) / count(power_level) AS average_ss_power_level FROM heroes_powers
JOIN super_powers ON super_powers.id = heroes_powers.super_power_id
WHERE super_powers.name = 'Super Strength';

-- 3

-- 9. Show all the information for heroes with super strength power level over 2.
SELECT heroes.name AS hero_name, alias AS alias, super_powers.name AS power, description AS description, power_level 
FROM heroes
JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
JOIN super_powers ON heroes_powers.super_power_id = super_powers.id
WHERE super_powers.name = 'Super Strength'
AND power_level > 2;

-- 10. Find the average power level for all powers. Include the power name and descriptions.
SELECT super_powers.name, description, AVG(heroes_powers.power_level) 
FROM super_powers
JOIN heroes_powers ON heroes_powers.super_power_id = super_powers.id
GROUP BY super_powers.name, description;
