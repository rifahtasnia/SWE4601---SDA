-- B2 A
ALTER TABLE sale ADD COLUMN category_id INT NOT NULL ;
ALTER TABLE sale ADD COLUMN seller_id INT NOT NULL ;

-- INSERT INTO sale (product_id, invoice_id, unitPrice, count, category_id, seller_id) VALUES (1,1,5,2,1,1);
-- INSERT INTO sale (product_id, invoice_id, unitPrice, count, category_id, seller_id) VALUES (2,1,3,1,2,1);
-- INSERT INTO sale (product_id, invoice_id, unitPrice, count, category_id, seller_id) VALUES (4,1,2,3,1,1);
-- INSERT INTO sale (product_id, invoice_id, unitPrice, count, category_id, seller_id) VALUES (2,2,3,2,2,3);
-- INSERT INTO sale (product_id, invoice_id, unitPrice, count, category_id, seller_id) VALUES (5,3,5,3,3,2);

-- B2 B
DROP PROCEDURE IF EXISTS get_sale_per_category;
DELIMITER //
CREATE PROCEDURE get_sale_per_category(in employeeId int)
    BEGIN
        SELECT S.category_id AS Category_ID, c.name AS Category_Name, sum(count) AS Sale_Count
        FROM sale S, category C WHERE S.seller_id = employeeId AND S.category_id = C.id
        GROUP BY category_id ;
    END //
DELIMITER ;

CALL get_sale_per_category(1);

-- B2 C
DROP PROCEDURE IF EXISTS set_product_category;
DELIMITER //
CREATE PROCEDURE set_product_category (IN productId INT, IN categoryId INT)
    BEGIN
        UPDATE product SET category_id = categoryId WHERE id = productId ;
        UPDATE sale SET category_id = categoryId WHERE product_id = productId ;
    END //
DELIMITER ;

CALL set_product_category(4,3);

-- SELECT * FROM product;
-- SELECT * FROM sale;

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'rifah', '007_change_Sale_Product_Table_B2.sql');
