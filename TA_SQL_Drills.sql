USE db_zoo1;

/*p.67, 76% Database & SQL course DRILL 1*/
SELECT * FROM tbl_habitat;

/*p.68, 78% Database & SQL course DRILL 2*/
SELECT species_name FROM tbl_species WHERE species_order = 3;

/*p.69, 78% Database & SQL course DRILL 3*/
SELECT nutrition_type FROM tbl_nutrition WHERE nutrition_cost <= 600;

/*p.70, 80% Database & SQL course DRILL 4*/
SELECT species_name
	FROM tbl_species
	INNER JOIN tbl_nutrition ON tbl_nutrition.nutrition_id = tbl_species.species_nutrition
	WHERE nutrition_id BETWEEN 2202 AND 2206;

/*p.71, 81% Database & SQL course DRILL 5*/
SELECT species_name AS 'Species Name',nutrition_type AS 'Nutrition Type:' FROM tbl_species
	INNER JOIN tbl_nutrition ON tbl_nutrition.nutrition_id = tbl_species.species_nutrition
;

/*p.72, 82% Database & SQL course DRILL 6*/
SELECT specialist_fname,specialist_lname,specialist_contact 
	FROM tbl_specialist
	INNER JOIN tbl_care ON tbl_care.care_specialist = tbl_specialist.specialist_id
	INNER JOIN tbl_species ON tbl_species.species_care = tbl_care.care_id
	WHERE species_name = 'penguin'
;

/*p.73, 83% Database & SQL course DRILL 7*/
CREATE DATABASE tech_academy_drills;
USE tech_academy_drills;

CREATE TABLE tbl_name(
	name_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	f_name VARCHAR(50) NOT NULL, 
	l_name VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_contact(
	contact_id INT PRIMARY KEY NOT NULL IDENTITY (100,1),
	contact_name INT NOT NULL CONSTRAINT fk_name_id FOREIGN KEY REFERENCES tbl_name(name_id) ON UPDATE CASCADE ON DELETE CASCADE,
	contact_phone VARCHAR(50) NOT NULL,
	contact_address VARCHAR(100) NOT NULL
);

INSERT INTO tbl_name
	(f_name,l_name)
	VALUES
	('bob','knob'),
	('george','boor'),
	('larry','harry'),
	('lisa','ann'),
	('genna','lawlz')
;

INSERT INTO tbl_contact(contact_name,contact_address,contact_phone)
	VALUES
	(1,'12345 Bob Rd NW, Bobville, BO, 21520','123-456-7890'),
	(2,'09876 Geo Ln SW, Boorsville, GE, 11111','098-765-4321'),
	(3,'54321 Hair Street, Hogwarts, Mars, 001100','112-344-5678'),
	(4,'10293 Lez Rd, Ramsey, MN, 55303','989-898-9988'),
	(5,'14523 Bowers Dr NW, Ramsey, MN, 55303','001-898-0800')
;

SELECT f_name AS 'First Name',contact_phone AS 'Phone #'
	FROM tbl_name
	INNER JOIN tbl_contact ON tbl_contact.contact_name = tbl_name.name_id
	WHERE f_name = 'bob'
;
