use role sysadmin;
create or replace database frosty_db;
create or replace schema frosty_db.challenges;
create or replace table frosty_db.challenges.week27 
(
    icecream_id int,
    icecream_flavour varchar(15),
    icecream_manufacturer varchar(50),
    icecream_brand varchar(50),
    icecreambrandowner varchar(50),
    milktype varchar(15),
    region_of_origin varchar(50),
    recomendad_price number,
    wholesale_price number
);

insert into frosty_db.challenges.week27 values
    (1, 'strawberry', 'Jimmy Ice', 'Ice Co.', 'Food Brand Inc.', 'normal', 'Midwest', 7.99, 5),
    (2, 'vanilla', 'Kelly Cream Company', 'Ice Co.', 'Food Brand Inc.', 'dna-modified', 'Northeast', 3.99, 2.5),
    (3, 'chocolate', 'ChoccyCream', 'Ice Co.', 'Food Brand Inc.', 'normal', 'Midwest', 8.99, 5.5);
    
select * from frosty_db.challenges.week27;
select * exclude milktype from frosty_db.challenges.week27;

select * rename icecreambrandowner as ice_cream_brand_owner from frosty_db.challenges.week27;
