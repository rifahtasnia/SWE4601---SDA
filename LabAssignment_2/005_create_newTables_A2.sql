DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
    id INT NOT NULL PRIMARY KEY ,
    name VARCHAR(100)
);

DROP TABLE IF EXISTS sale;
CREATE TABLE sale (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    product_id INT NOT NULL ,
    invoice_id INT NOT NULL ,
    UnitPrice FLOAT ,
    count INT
);

DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice (
    id INT NOT NULL PRIMARY KEY ,
    customer_id INT NOT NULL ,
    seller_id INT NOT NULL ,
    timestamp datetime
);

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'rifah', '005_create_newTables_A2.sql');
