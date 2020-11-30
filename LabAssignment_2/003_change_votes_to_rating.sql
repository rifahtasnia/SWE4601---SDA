alter table vote rename to rating;
alter table rating add column value int;
update rating set value = 1 where is_up_vote = false;
update rating set value = 5 where is_up_vote = true;
alter table rating drop column is_up_vote;

alter table product add column average_rating float;
alter table product drop column votes;

drop procedure recalculate_product_votes;
delimiter //
create procedure recalculate_product_average_rating()
begin
    update product p
        set average_rating = (select avg(value ) from rating where rating.product_id = p.id)
    where 1 = 1;
end;//
delimiter ;

call recalculate_product_average_rating();

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'mohayemin', '002_change_votes_to_rating.sql');