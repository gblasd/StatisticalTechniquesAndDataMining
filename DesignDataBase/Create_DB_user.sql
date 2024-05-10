CREATE DATABASE DEMO;
USE DEMO;

-- Create new user
DROP USER IF EXISTS 'gblasd'@'localhost';
CREATE USER 'gblasd'@'localhost' IDENTIFIED BY 'gblasd';
GRANT ALL PRIVILEGES ON *.* TO 'gblasd'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Create database
CREATE DATABASE gblasd_BD1;
USE gblasd_BD1;

-- Create table
CREATE TABLE table1(
    col1 int,
    col2 char(3)
);


