DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(100)
);

ALTER TABLE rating ADD COLUMN timestamp DATETIME NOT NULL ;
ALTER TABLE rating ADD COLUMN rater_id INT NOT NULL ;

-- INSERT INTO customer VALUES (1, 'Alice');
-- INSERT INTO customer VALUES (2, 'Bob');
-- INSERT INTO customer VALUES (3, 'Dan');

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'rifah', '004_add_CustomerTable_A1.sql');
