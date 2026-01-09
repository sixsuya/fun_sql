create table lunch(
        restaurant_no number(3)
        ,restaurant_name varchar2(50) not null
        ,restaurant_address varchar2(100)
        ,restaurant_category varchar2(20) not null
        ,restaurant_menu varchar2(100)
        ,restaurant_price number(10)
        ,restaurant_myung number(3)
        ,restaurant_score number(3)
        ,restaurant_discount number(10)
        ,restaurant_etc varchar(1000)        
        );
        
insert into lunch
values(1, '차차반점', '현대백화점 맞은편', '중식', '고추짬뽕', 10000, 1, 5, 0, '캐치테이블 웨이팅 가능');

select * from lunch;

alter table lunch modify restaurant_discount varchar2(30);

delete from lunch where restaurant_discount is not null;

select * from lunch order by 1;