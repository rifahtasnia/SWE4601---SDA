drop database if exists kids_shop;
create database kids_shop;
use kids_shop;

/*
Note that the above three would not actually exist in a real scenario.
Those are added so that the students can smoothly cleanup their database and rerun the scripts.
*/

create table _changelog(
    id int not null auto_increment primary key,
    applied_at datetime not null,
    created_by varchar(100) not null,
    filename varchar(200) not null
);

insert into _changelog(applied_at, created_by, filename) VALUE (now(), 'mohayemin', '000_init.sql');
