-- C1 A
-- reporting_rating_table is my Fact table. Category, Product, Customer - these are dimension tables

DROP TABLE IF EXISTS reporting_rating_table;
CREATE TABLE reporting_rating_table (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    category_id INT ,
    product_id INT ,
    customer_id INT ,
    rating_value INT ,
    timestamp DATETIME
);

-- C1 B
DROP PROCEDURE IF EXISTS get_top_3_products;
DELIMITER //
CREATE PROCEDURE get_top_3_products ()
    BEGIN
        SELECT P.name AS Product_Name
        FROM product P, reporting_rating_table R
        WHERE P.id = R.product_id
        GROUP BY product_id
        ORDER BY SUM(rating_value) DESC
        LIMIT 3;
    END //
DELIMITER ;

CALL get_top_3_products();

-- C1 C
DROP PROCEDURE IF EXISTS get_top_2_categories;
DELIMITER //
CREATE PROCEDURE get_top_2_categories ()
    BEGIN
        SELECT C.name AS Category_Name
        FROM category C, reporting_rating_table R
        WHERE C.id = R.category_id
        GROUP BY category_id
        ORDER BY SUM(rating_value) DESC
        LIMIT 2;
    END //
DELIMITER ;

CALL get_top_2_categories();

-- C1 D
DROP PROCEDURE IF EXISTS get_frequent_rater;
DELIMITER //
CREATE PROCEDURE get_frequent_rater ()
    BEGIN
        SELECT DISTINCT C.name AS Customer_Name
        FROM customer C, reporting_rating_table R
        WHERE C.id = R.customer_id
        GROUP BY customer_id
        ORDER BY COUNT(customer_id) DESC
        LIMIT 1;
    END //
DELIMITER ;

CALL get_frequent_rater();

-- C1 E
-- C1 F
DROP PROCEDURE IF EXISTS get_top_product_by_category;
DELIMITER //
CREATE PROCEDURE get_top_product_by_category(IN categoryId INT)
    BEGIN
        SELECT P.name AS Product_Name
        FROM product P, reporting_rating_table R
        WHERE P.id = R.product_id AND R.category_id = categoryId
        GROUP BY R.category_id
        ORDER BY SUM(rating_value) DESC
        LIMIT 1;
    END //
DELIMITER ;

CALL get_top_product_by_category(1);

-- C1 G
DROP PROCEDURE IF EXISTS populate_reporting_db;
DELIMITER //
CREATE PROCEDURE populate_reporting_db()
    BEGIN
        INSERT INTO reporting_rating_table (id, product_id, rating_value, timestamp, customer_id)
        SELECT id, product_id, value, timestamp, rater_id FROM rating WHERE id NOT IN (SELECT DISTINCT id FROM reporting_rating_table);

        UPDATE reporting_rating_table
        SET category_id = (SELECT category_id FROM product WHERE reporting_rating_table.product_id = product.id);
    END //
DELIMITER ;

CALL populate_reporting_db();

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'rifah', '008_create_reporting_table_C.sql');