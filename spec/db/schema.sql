CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  visible_id VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE cars (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  serial_number VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE animals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  visible_id VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE buildings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  visible_id VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE computers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  serial_number VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE keyboards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  serial_number VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_number INTEGER,
  name VARCHAR(50)
);

CREATE TABLE furnitures (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  visible_id INTEGER,
  name VARCHAR(50)
);