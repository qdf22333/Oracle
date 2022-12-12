create table grade_pt_rade (
    mem_grade varchar2(20) not null constraint GRADE_PT_RADE_MEM_GRADE_PK primary key,
    grade_pt_rate number(3,2)
    );
    
insert into grade_pt_rade  
values ('gold', 1);
insert into grade_pt_rade  
values ('silver', 2);
insert into grade_pt_rade  
values ('dia', 3);

create table nation (
    nation_code varchar2(26) not null constraint NATION_NATION_CODE_PK primary key,
    nation_name varchar2(50)
    );
    
insert into nation
values ('82', 'KOREA');
insert into nation
values ('85', 'JAPAN');
insert into nation
values ('75', 'CHINA');

    
    
create table wine_type (
    wine_type_code varchar2(6) not null constraint WINE_TYPE_WINE_TYPE_CODE_PK primary key,
    wine_type_name varchar2(50)
    );    
    
insert into wine_type
values ('AB', 'APPLE');
insert into wine_type
values ('BB', 'ORANGE');
insert into wine_type
values ('CB', 'BANANA');
    
create table theme (
    theme_code varchar2(6) not null constraint THEME_THEME_CODE_PK primary key,
    theme_name varchar2(50)
    );   
    
insert into theme
values ('ZZ', '테마1');
insert into theme
values ('qq', '테마2');
insert into theme
values ('yy', '테마3');


create table today (
    today_code varchar2(6) not null constraint TODAY_TODAY_CODE_PK primary key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );   
    
insert into today
values ('BB', 99, 100, 50);
insert into today
values ('BA', 100, 90, 80);
insert into today
values ('BC', 99, 50, 50);

    
create table wine (
    wine_code varchar2(26) not null constraint WINE_WINE_CODE_PK primary key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
        constraint WINE_NATION_CODE_FK foreign key (nation_code) references nation (nation_code),
    wine_type_code varchar2(6),
        constraint WINE_WINE_TYPE_CODE_FK foreign key (wine_type_code) references wine_type (wine_type_code),
    wine_sugar_code number(2),
    wine_price number (15) default 0 not null,
    wine_vintage date,
    theme_code varchar2(6),
        constraint WINE_THEME_CODE_FK foreign key (theme_code) references theme (theme_code),
    today_code varchar2(6),
        constraint WINE_TODAY_CODE_FK foreign key (today_code) references today (today_code)
    );      

insert into wine
values ('abab', 'hkhkhk', null, '82', 'CB', 1, 5000, '2022-12-09', 'yy', 'BB');
    
create table manager (
    manager_id varchar2(30) not null constraint MANAGER_MANAGER_ID_PK primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );       
    
insert into manager
values ('abcd', '1234', '010-1111-1111');


    
drop table member cascade constraint purge;

create table member (
    mem_id varchar2(6) not null constraint MEMBER_MEM_ID_PK primary key,
    mem_grade varchar2(20),
    mem_pw varchar2(20) not null,
    mem_birth date DEFAULT sysdate not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) DEFAULT 0 not null,
    constraint MEMBER_MEM_GRADE_FK foreign key(mem_grade) references grade_pt_rade(mem_grade)
    );  

insert into member
values ('abcd', 'gold', '1234', default, '010-1111-1111', '1');

    
create table sale (
    sale_date date default sysdate not null constraint SALE_SALE_DATE_PK primary key,
    wine_code varchar2(6) not null,
        constraint SALE_WINE_CODE_FK foreign key(wine_code) references wine(wine_code),
    mem_id varchar2(30) not null,
        constraint SALE_MEM_ID_FK foreign key(mem_id) references member (mem_id),
    sale_amount varchar2(5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null
    );    
    
insert into sale
values (default, 'abab', 'abcd', '500', '5000', '10000');
    
    
create table stock_mamagement (
    stock_code varchar2(6) not null constraint STOCK_MANAGEMENT_STOCK_CODE_PK primary key,
    wine_code varchar2(6),
        constraint STOCK_MANAGEMENT_WINE_CODE_FK foreign key(wine_code) references wine(wine_code),
    manager_id varchar2(30),
        constraint STOCK_MANAGEMENT_MANAGER_ID_FK foreign key(manager_id) references manager (manager_id),
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null
    );          

insert into stock_mamagement
values ('A', 'abab', 'abcd', default, 1000);


    
commit;
select * from grade_pt_rade;
    
    
    
    