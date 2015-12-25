DROP DATABASE IF EXISTS homamiii;
CREATE DATABASE homamiii;

GRANT ALL ON homamiii.* TO marc@"%" IDENTIFIED BY "marc";
GRANT ALL ON homamiii.* TO marc@"localhost" IDENTIFIED BY "marc";

USE homamiii;

DROP TABLE IF EXISTS creature;
DROP TABLE IF EXISTS resource;
DROP TABLE IF EXISTS population;
DROP TABLE IF EXISTS artifact;
DROP TABLE IF EXISTS hero;
DROP TABLE IF EXISTS hero_specialty;

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
	special VARCHAR(80),
	gold_cost INT,
	resource_cost INT,
	resource_type VARCHAR(20),
	num_shots INT,
	can_fly BOOLEAN,
	tier_level INT,
	is_upgraded_form BOOLEAN,
	upgrade_id INT,
	PRIMARY KEY (id)
);

CREATE TABLE resource (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(20),
	abbrev VARCHAR(20),
	PRIMARY KEY (id)
);

CREATE TABLE population (
	id INT NOT NULL AUTO_INCREMENT,
	label VARCHAR(20),
	pop_min INT,
	pop_max INT,
	PRIMARY KEY (id)
);

CREATE TABLE artifact (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(40),
	slot VARCHAR(20),
	gold_cost INT,
	effect VARCHAR(300),
	set_name VARCHAR(35),
	PRIMARY KEY (id)
);

CREATE TABLE hero_specialty (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(40),
	level VARCHAR(20),
	description VARCHAR(300),
	PRIMARY KEY (id)
);

CREATE TABLE hero (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(40),
	class VARCHAR(20),
	specialty VARCHAR(20),
 	specialty_text VARCHAR(300),
	skill1_id INT,
	skill2_id INT,
	PRIMARY KEY (id),
	CONSTRAINT FOREIGN KEY (skill1_id) REFERENCES hero_specialty(id),
	CONSTRAINT FOREIGN KEY (skill2_id) REFERENCES hero_specialty(id)
);

-- Load creature CSV file into database
LOAD DATA LOCAL INFILE 'creature.csv' INTO TABLE creature FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, army, health, speed, attack, defense, min_damage, max_damage, special, gold_cost, resource_cost, resource_type, num_shots, can_fly, tier_level, is_upgraded_form, upgrade_id);

-- Load resources CSV file into database
LOAD DATA LOCAL INFILE 'resource.csv' INTO TABLE resource FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, abbrev);

-- Load population CSV file into database
LOAD DATA LOCAL INFILE 'population.csv' INTO TABLE population FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (label, pop_min, pop_max);

-- Load artifact CSV file into database
LOAD DATA LOCAL INFILE 'artifact.csv' INTO TABLE artifact FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, slot, gold_cost, effect, set_name);

-- Load hero-specialty CSV file into database
LOAD DATA LOCAL INFILE 'hero-specialty.csv' INTO TABLE hero_specialty FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, level, description);

-- Load hero CSV file into database
LOAD DATA LOCAL INFILE 'hero.csv' INTO TABLE hero FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (name, class, specialty, specialty_text);

DELIMITER //
CREATE PROCEDURE add_hero_skill1_skill2 (IN hero_name VARCHAR(40), IN skill1_level VARCHAR(20), IN skill1 VARCHAR(40), IN skill2_level VARCHAR(20), IN skill2 VARCHAR(40))
BEGIN
  UPDATE hero SET
        skill1_id = (SELECT id FROM hero_specialty WHERE name LIKE skill1 AND level LIKE skill1_level),
        skill2_id = (SELECT id FROM hero_specialty WHERE name LIKE skill2 AND level LIKE skill2_level)
  WHERE name LIKE hero_name;
END //

CREATE PROCEDURE add_hero_skill1 (IN hero_name VARCHAR(40), IN skill1_level VARCHAR(20), IN skill1 VARCHAR(40))
BEGIN
  UPDATE hero SET
        skill1_id = (SELECT id FROM hero_specialty WHERE name LIKE skill1 AND level LIKE skill1_level)
  WHERE name LIKE hero_name;
END //
DELIMITER ;

CALL add_hero_skill1_skill2('Adela', 'Basic', 'Wisdom', 'Basic', 'Diplomacy');
CALL add_hero_skill1('Adelaide', 'Advanced', 'Wisdom');
CALL add_hero_skill1_skill2('Adrienne', 'Basic', 'Wisdom', 'Expert', 'Fire Magic');
CALL add_hero_skill1_skill2('Aenain', 'Basic', 'Wisdom', 'Basic', 'Air Magic');
CALL add_hero_skill1_skill2('Aeris', 'Basic', 'Wisdom', 'Basic', 'Scouting');
CALL add_hero_skill1_skill2('Aine', 'Basic', 'Wisdom', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Aislinn', 'Basic', 'Necromancy', 'Basic', 'Wisdom');
CALL add_hero_skill1_skill2('Ajit', 'Basic', 'Leadership', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Alagar', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Alamar', 'Basic', 'Wisdom', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Alkin', 'Basic', 'Armorer', 'Basic', 'Offense');

CALL add_hero_skill1_skill2('Andra', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Arlach', 'Basic', 'Offense', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Ash', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');
CALL add_hero_skill1('Astral', 'Advanced', 'Wisdom');
CALL add_hero_skill1_skill2('Axsis', 'Basic', 'Wisdom', 'Basic', 'Mysticism');
CALL add_hero_skill1_skill2('Ayden', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Boragus', 'Basic', 'Offense', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Brissa', 'Basic', 'Wisdom', 'Basic', 'Air Magic');
CALL add_hero_skill1_skill2('Broghild', 'Basic', 'Armorer', 'Basic', 'Scouting');

CALL add_hero_skill1_skill2('Bron', 'Basic', 'Armorer', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Caitlin', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Calh', 'Basic', 'Archery', 'Basic', 'Scouting');
CALL add_hero_skill1_skill2('Calid', 'Basic', 'Wisdom', 'Basic', 'Learning');
CALL add_hero_skill1_skill2('Catherine', 'Basic', 'Leadership', 'Basic', 'Offense');
CALL add_hero_skill1_skill2('Charna', 'Basic', 'Necromancy', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Christian', 'Basic', 'Leadership', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Ciele', 'Basic', 'Wisdom', 'Basic', 'Water Magic');
CALL add_hero_skill1_skill2('Clancy', 'Basic', 'Resistance', 'Basic', 'Pathfinding');

CALL add_hero_skill1_skill2('Clavius', 'Basic', 'Necromancy', 'Basic', 'Offense');
CALL add_hero_skill1_skill2('Coronius', 'Basic', 'Wisdom', 'Basic', 'Scholar');
CALL add_hero_skill1('Crag Hack', 'Advanced', 'Offense');
CALL add_hero_skill1_skill2('Cuthbert', 'Basic', 'Wisdom', 'Basic', 'Estates');
CALL add_hero_skill1_skill2('Cyra', 'Basic', 'Wisdom', 'Basic', 'Diplomacy');
CALL add_hero_skill1_skill2('Dace', 'Basic', 'Offense', 'Basic', 'Tactics');
CALL add_hero_skill1('Damacon', 'Advanced', 'Offense');
CALL add_hero_skill1_skill2('Daremyth', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Darkstorn', 'Basic', 'Wisdom', 'Basic', 'Learning');

CALL add_hero_skill1_skill2('Deemer', 'Basic', 'Wisdom', 'Advanced', 'Scouting');
CALL add_hero_skill1_skill2('Dessa', 'Basic', 'Wisdom', 'Basic', 'Logistics');
CALL add_hero_skill1('Dracon', 'Advanced', 'Wisdom');
CALL add_hero_skill1_skill2('Drakon', 'Basic', 'Armorer', 'Basic', 'Leadership');
CALL add_hero_skill1_skill2('Edric', 'Basic', 'Leadership', 'Basic', 'Armorer');
CALL add_hero_skill1_skill2('Elleshar', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Erdamon', 'Basic', 'Tactics', 'Basic', 'Estates');
CALL add_hero_skill1_skill2('Fafner', 'Basic', 'Scholar', 'Basic', 'Resistance');
CALL add_hero_skill1('Fiona', 'Advanced', 'Scouting');

CALL add_hero_skill1('Fiur', 'Advanced', 'Offense');
CALL add_hero_skill1_skill2('Galthran', 'Basic', 'Necromancy', 'Basic', 'Armorer');
CALL add_hero_skill1_skill2('Gelare', 'Basic', 'Wisdom', 'Basic', 'Water Magic');
CALL add_hero_skill1_skill2('Gelu', 'Basic', 'Archery', 'Basic', 'Leadership');
CALL add_hero_skill1_skill2('Gem', 'Basic', 'Wisdom', 'Basic', 'First Aid');
CALL add_hero_skill1_skill2('Geon', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');
CALL add_hero_skill1_skill2('Gerwulf', 'Basic', 'Armorer', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Gird', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Gretchin', 'Basic', 'Offense', 'Basic', 'Pathfinding');

CALL add_hero_skill1_skill2('Grindan', 'Basic', 'Wisdom', 'Basic', 'Earth Magic');
CALL add_hero_skill1_skill2('Gundula', 'Basic', 'Wisdom', 'Basic', 'Offense');
CALL add_hero_skill1_skill2('Gunnar', 'Basic', 'Tactics', 'Basic', 'Logistics');
CALL add_hero_skill1_skill2('Gurnisson', 'Basic', 'Offense', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Halon', 'Basic', 'Wisdom', 'Basic', 'Mysticism');
CALL add_hero_skill1_skill2('Ignatius', 'Basic', 'Tactics', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Ignissa', 'Basic', 'Offense', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Ingham', 'Basic', 'Wisdom', 'Basic', 'Mysticism');
CALL add_hero_skill1_skill2('Inteus', 'Basic', 'Wisdom', 'Basic', 'Fire Magic');

CALL add_hero_skill1_skill2('Iona', 'Basic', 'Scholar', 'Basic', 'Intelligence');
CALL add_hero_skill1('Isra', 'Advanced', 'Necromancy');
CALL add_hero_skill1_skill2('Ivor', 'Basic', 'Archery', 'Basic', 'Offense');
CALL add_hero_skill1_skill2('Jabarkas', 'Basic', 'Offense', 'Basic', 'Archery');
CALL add_hero_skill1_skill2('Jaegar', 'Basic', 'Wisdom', 'Basic', 'Mysticism');
CALL add_hero_skill1('Jeddite', 'Advanced', 'Wisdom');
CALL add_hero_skill1('Jenova', 'Advanced', 'Archery');
CALL add_hero_skill1_skill2('Josephine', 'Basic', 'Mysticism', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Kalt', 'Basic', 'Tactics', 'Basic', 'Learning');

CALL add_hero_skill1('Kilgor', 'Advanced', 'Offense');
CALL add_hero_skill1_skill2('Korbac', 'Basic', 'Armorer', 'Basic', 'Pathfinding');
CALL add_hero_skill1_skill2('Krellion', 'Basic', 'Offense', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Kyrre', 'Basic', 'Archery', 'Basic', 'Logistics');
CALL add_hero_skill1_skill2('Labetha', 'Basic', 'Wisdom', 'Basic', 'Earth Magic');
CALL add_hero_skill1('Lacus', 'Advanced', 'Tactics');
CALL add_hero_skill1_skill2('Lord Haart', 'Basic', 'Leadership', 'Basic', 'Estates');
CALL add_hero_skill1_skill2('Lord Haart', 'Basic', 'Necromancy', 'Basic', 'Estates');
CALL add_hero_skill1_skill2('Lorelei', 'Basic', 'Leadership', 'Basic', 'Scouting');

CALL add_hero_skill1_skill2('Loynis', 'Basic', 'Wisdom', 'Basic', 'Learning');
CALL add_hero_skill1_skill2('Luna', 'Basic', 'Wisdom', 'Basic', 'Fire Magic');
CALL add_hero_skill1_skill2('Malcolm', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');
CALL add_hero_skill1_skill2('Malekith', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
CALL add_hero_skill1('Marius', 'Advanced', 'Armorer');
CALL add_hero_skill1_skill2('Melodia', 'Basic', 'Wisdom', 'Basic', 'Luck');
CALL add_hero_skill1_skill2('Mephala', 'Basic', 'Leadership', 'Basic', 'Armorer');
CALL add_hero_skill1_skill2('Merist', 'Basic', 'Wisdom', 'Basic', 'Learning');
CALL add_hero_skill1('Mirlanda', 'Advanced', 'Wisdom');

CALL add_hero_skill1_skill2('Moandor', 'Basic', 'Necromancy', 'Basic', 'Learning');
CALL add_hero_skill1_skill2('Monere', 'Basic', 'Offense', 'Basic', 'Logistics');
CALL add_hero_skill1_skill2('Mutare Drake', 'Basic', 'Estates', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Mutare', 'Basic', 'Estates', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Nagash', 'Basic', 'Necromancy', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Neela', 'Basic', 'Armorer', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Nimbus', 'Basic', 'Necromancy', 'Basic', 'Eagle Eye');
CALL add_hero_skill1('Nymus', 'Advanced', 'Offense');
CALL add_hero_skill1_skill2('Octavia', 'Basic', 'Scholar', 'Basic', 'Offense');

CALL add_hero_skill1_skill2('Olema', 'Basic', 'Wisdom', 'Basic', 'Ballistics');
CALL add_hero_skill1_skill2('Oris', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');
CALL add_hero_skill1_skill2('Orrin', 'Basic', 'Leadership', 'Basic', 'Archery');
CALL add_hero_skill1_skill2('Pasis', 'Basic', 'Offense', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Piquedram', 'Basic', 'Mysticism', 'Basic', 'Scouting');
CALL add_hero_skill1_skill2('Pyre', 'Basic', 'Logistics', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Rashka', 'Basic', 'Wisdom', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Rion', 'Basic', 'Wisdom', 'Basic', 'First Aid');
CALL add_hero_skill1_skill2('Rissa', 'Basic', 'Mysticism', 'Basic', 'Offense');

CALL add_hero_skill1_skill2('Roland', 'Basic', 'Leadership', 'Basic', 'Armorer');
CALL add_hero_skill1_skill2('Rosic', 'Basic', 'Wisdom', 'Basic', 'Mysticism');
CALL add_hero_skill1_skill2('Ryland', 'Basic', 'Leadership', 'Basic', 'Diplomacy');
CALL add_hero_skill1_skill2('Sandro', 'Basic', 'Necromancy', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Sanya', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');
CALL add_hero_skill1_skill2('Saurug', 'Basic', 'Wisdom', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Sephinroth', 'Basic', 'Wisdom', 'Basic', 'Intelligence');
CALL add_hero_skill1_skill2('Septienna', 'Basic', 'Necromancy', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Serena', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');

CALL add_hero_skill1_skill2('Shakti', 'Basic', 'Offense', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Shiva', 'Basic', 'Offense', 'Basic', 'Scouting');
CALL add_hero_skill1('Sir Mullich', 'Advanced', 'Leadership');
CALL add_hero_skill1_skill2('Solmyr', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Sorsha', 'Basic', 'Leadership', 'Basic', 'Offense');
CALL add_hero_skill1_skill2('Straker', 'Basic', 'Necromancy', 'Basic', 'Resistance');
CALL add_hero_skill1_skill2('Styg', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
CALL add_hero_skill1_skill2('Sylvia', 'Basic', 'Leadership', 'Basic', 'Navigation');
CALL add_hero_skill1_skill2('Synca', 'Basic', 'Leadership', 'Basic', 'Scholar');

CALL add_hero_skill1_skill2('Tamika', 'Basic', 'Necromancy', 'Basic', 'Offense');
CALL add_hero_skill1('Tazar', 'Advanced', 'Armorer');
CALL add_hero_skill1_skill2('Terek', 'Basic', 'Wisdom', 'Basic', 'Tactics');
CALL add_hero_skill1('Thane', 'Advanced', 'Scholar');
CALL add_hero_skill1_skill2('Thant', 'Basic', 'Necromancy', 'Basic', 'Mysticism');
CALL add_hero_skill1_skill2('Theodorus', 'Basic', 'Wisdom', 'Basic', 'Ballistics');
CALL add_hero_skill1('Thorgrim', 'Advanced', 'Resistance');
CALL add_hero_skill1_skill2('Thunar', 'Basic', 'Tactics', 'Basic', 'Estates');
CALL add_hero_skill1_skill2('Tiva', 'Basic', 'Wisdom', 'Basic', 'Eagle Eye');

CALL add_hero_skill1_skill2('Torosar', 'Basic', 'Mysticism', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Tyraxor', 'Basic', 'Offense', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Tyris', 'Basic', 'Leadership', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Ufretin', 'Basic', 'Resistance', 'Basic', 'Luck');
CALL add_hero_skill1_skill2('Uland', 'Basic', 'Wisdom', 'Basic', 'Ballistics');
CALL add_hero_skill1_skill2('Valeska', 'Basic', 'Leadership', 'Basic', 'Archery');
CALL add_hero_skill1_skill2('Verdish', 'Basic', 'Wisdom', 'Basic', 'First Aid');
CALL add_hero_skill1_skill2('Vey', 'Basic', 'Wisdom', 'Basic', 'Leadership');
CALL add_hero_skill1('Vidomina', 'Advanced', 'Necromancy');

CALL add_hero_skill1_skill2('Vokial', 'Basic', 'Necromancy', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Voy', 'Basic', 'Wisdom', 'Basic', 'Navigation');
CALL add_hero_skill1_skill2('Wystan', 'Basic', 'Armorer', 'Basic', 'Archery');
CALL add_hero_skill1_skill2('Xarfax', 'Basic', 'Wisdom', 'Basic', 'Leadership');
CALL add_hero_skill1_skill2('Xeron', 'Basic', 'Leadership', 'Basic', 'Tactics');
CALL add_hero_skill1_skill2('Xsi', 'Basic', 'Necromancy', 'Basic', 'Learning');
CALL add_hero_skill1_skill2('Xyron', 'Basic', 'Wisdom', 'Basic', 'Scholar');
CALL add_hero_skill1_skill2('Yog', 'Basic', 'Offense', 'Basic', 'Ballistics');
CALL add_hero_skill1_skill2('Zubin', 'Basic', 'Wisdom', 'Basic', 'Artillery');
CALL add_hero_skill1_skill2('Zydar', 'Basic', 'Wisdom', 'Basic', 'Sorcery');
