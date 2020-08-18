--------
-- Migrations will create the database automatically. 
-- You can use this SQL as a reference 
-- or execute this SQL to create the tables if migrations somehow won't work.
--------

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	visible_id VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE cars(
	id INT AUTO_INCREMENT PRIMARY KEY,
	serial_number VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE animals(
	id INT AUTO_INCREMENT PRIMARY KEY,
	visible_id VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE buildings(
	id INT AUTO_INCREMENT PRIMARY KEY,
	visible_id VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE computers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	serial_number VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE keyboards(
	id INT AUTO_INCREMENT PRIMARY KEY,
	serial_number VARCHAR(50),
	name VARCHAR(50)
)

CREATE TABLE books(
	id INT AUTO_INCREMENT PRIMARY KEY,
	page_number INTEGER,
	name VARCHAR(50)
)

CREATE TABLE furnitures(
	id INT AUTO_INCREMENT PRIMARY KEY,
	visible_id INTEGER,
	name VARCHAR(50)
)
