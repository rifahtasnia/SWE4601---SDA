ALTER TABLE vote
    RENAME TO rating;

ALTER TABLE rating
    ADD product_rating int not null
        AFTER is_up_vote;

UPDATE rating
SET product_rating = 5
WHERE is_up_vote = true;

UPDATE rating
SET product_rating = 1
WHERE is_up_vote = false;

ALTER TABLE rating
    DROP COLUMN is_up_vote;

ALTER TABLE product
    CHANGE votes average_rating int;

DROP PROCEDURE IF EXISTS recalculate_product_rating;

DELIMITER //
CREATE PROCEDURE recalculate_product_rating()
BEGIN
    UPDATE product p
    SET average_rating = (SELECT SUM(product_rating) FROM rating WHERE product_id = p.id)/
                (SELECT COUNT(*) FROM rating WHERE product_id = p.id)
    WHERE 1=1;
    UPDATE product p
    SET average_rating = 0
    WHERE average_rating is null ;
END //
DELIMITER ;

CALL recalculate_product_rating();


