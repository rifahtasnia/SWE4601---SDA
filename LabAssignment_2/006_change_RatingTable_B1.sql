-- B1 A
-- Redundant column(s) already exists for the optimized queries

-- B1 B
DROP PROCEDURE  IF EXISTS add_rating;

DELIMITER //
CREATE PROCEDURE add_rating(IN productId INT, IN rating_value INT, IN customerId INT )
    BEGIN
        INSERT INTO rating (product_id, rater_id, value, timestamp) VALUES (productId, customerId, rating_value, now());
    END;//
DELIMITER ;

CALL add_rating(1,5,2);
-- CALL add_rating(2,4,1);
-- CALL add_rating(4,5,3);
-- CALL add_rating(6,3,1);
-- CALL add_rating(3,4,3);

-- B1 C
DROP PROCEDURE  IF EXISTS return_average_rating;

DELIMITER //
CREATE PROCEDURE return_average_rating (IN productId INT, OUT avg_rating FLOAT)
    BEGIN
        SELECT average_rating INTO avg_rating
        FROM product WHERE id = productId;
    END;//

DELIMITER ;

CALL return_average_rating(1, @out_value);
-- CALL return_average_rating(2, @out_value);

CALL recalculate_product_average_rating();

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'rifah', '006_change_RatingTable_B1.sql');
