create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30) null,    
    gugum varchar2(30) null,      
    dong varchar2(30) null,
    bungi varchar2(30) null
    );
    
select * from tb_zipcode;

insert into tb_zipcode
values ('02459', '서울', '동대문구', '휘경동', '32-5');
insert into tb_zipcode
values ('02460', '대구', '북구', null, '13');
insert into tb_zipcode
values ('02470', '부산', '사하구', '휘경동', '15');
insert into tb_zipcode
values ('02480', '대전', '중구', null, '20');
insert into tb_zipcode
values ('02490', '춘천', null, '춘천동', '30');

select * from user_constraints
where table_name = 'member';

create table member (
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20) null,    
    name varchar2(50) null,      
    zipcode varchar2(7), 
        constraint member_zipcode_FK foreign key (zipcode) references tb_zipcode (zipcode),
    address varchar2(20) null,
    tel varchar2(13) null,
    indate DATE DEFAULT SYSDATE
    );
    
    
insert into member
values ('aaa', '1234', '홍길동', '02459', '동대문구', '010-1111-1111', default);    

insert into member
values ('bbb', '1234', '항정살', '02460', '서울', '010-2222-2222', default);

insert into member
values ('cccc', '1234', '삼겹살', '02470', '부산', '010-3333-3333', default);

insert into member
values ('dddd', '1234', '오겹살', '02480', '대구', '010-4444-4444', default);
insert into member
values ('eeee', '1234', '꼬들살', '02490', '대전', '010-5555-5555', default);
    
select * from tb_zipcode;
select * from member;

commit;


create table products (
    product_code varchar2(20) not null constraint PK_products_product_code
 primary key,
    product_name varchar2(100) null,    
    product_kind char(1) null,      
    product_price1 varchar2(10) null,
    product_price2 varchar2(10) null,
    product_content varchar2(1000) null,
    product_image varchar2(50) null,
    sizeSt varchar2(5) null,
    sizeEt varchar2(5) null,
    product_quantity varchar2(5) null,
    useyn char(1) null,
    indate date null
    );
    
create table orders (
    o_seq number(10) not null constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
        constraint orders_product_code_FK foreign key (product_code) references products (product_code),    
    id varchar2(16),
        constraint orders_id_FK foreign key (id) references member (id),
    product_size varchar2(5),        
    quantity varchar2(5) null,
    result char(1) null,
    indate DATE DEFAULT sysdate
    );    
    

insert into products
values ('1', 't', '1', '10000', '20000', '웅애웅앵', '티', '85', '100', '100', 'n', default );    
insert into products
values ('2', 'bottom', '2', '5000', '10000', '좋아요', '바지', '24', '30', '100', 'n', default );    
insert into products
values ('3', 'outer', '1', '40000', '80000', '따뜻해요', '아우터', '85', '105', '100', 'n', default );    
    
insert into orders
values ('1111', '1', 'aaa', '90', '100', 'y', default );   
insert into orders
values ('2222', '2', 'bbb', '85', '150', 'y', default );  
insert into orders
values ('3333', '1', 'aaa', '100', '1', 'y', default );  

select * from products;

select * from orders;

commit;
