DROP DATABASE IF EXISTS homamiii;
CREATE DATABASE homamiii;

GRANT ALL ON homamiii.* TO marc@"%" IDENTIFIED BY "12345";
GRANT ALL ON homamiii.* TO marc@"localhost" IDENTIFIED BY "12345";

USE homamiii;

DROP TABLE IF EXISTS creature;
CREATE TABLE creature (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(20),
	army VARCHAR(20),
	health INT,
	speed INT,
	attack INT,
	defense INT,
	min_damage INT,
	max_damage INT,
	gold_cost INT,
	resource_cost INT,
	resource_type VARCHAR(20),
	num_shots INT,
	can_fly BOOLEAN,
	has_special_ability BOOLEAN,
	tier_level INT,
	is_upgraded_form BOOLEAN,
	upgrade_id INT,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS resource;
CREATE TABLE resource (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(20),
	abbrev VARCHAR(20),
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS population;
CREATE TABLE population (
	id INT NOT NULL AUTO_INCREMENT,
	label VARCHAR(20),
	pop_min INT,
	pop_max INT,
	PRIMARY KEY (id)
);

-- Load creature CSV file into database
LOAD DATA LOCAL INFILE 'creature.csv' INTO TABLE creature FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, army, health, speed, attack, defense, min_damage, max_damage, gold_cost, resource_cost, resource_type, num_shots, can_fly, has_special_ability, tier_level, is_upgraded_form, upgrade_id);

-- Load resources CSV file into database
LOAD DATA LOCAL INFILE 'resource.csv' INTO TABLE resource FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, abbrev);

-- Load population CSV file into database
LOAD DATA LOCAL INFILE 'population.csv' INTO TABLE population FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (label, pop_min, pop_max);
