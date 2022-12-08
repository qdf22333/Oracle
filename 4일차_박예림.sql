
select * from emp;
desc emp;
--1. 값을 3 레코드 입력, 모든값 입력, null이 허용된 컬럼에 null 넣기.
insert into emp (eno, ename, job, manager, hiredate, salary, commission, dno)
values (5551, 'YERIM', 'STUDENT', 7777, '22/12/08', 300, 300, 40);

insert into emp (eno, ename, job, manager, hiredate, salary, commission, dno)
values (5552, 'TAEEUN', null, 8888, '95/02/22', 400, 400, null);

insert into emp (eno, ename, job, manager, hiredate, salary, commission, dno)
values (5553, 'JKJK', 'SALESMAN', null, '93/04/28', 1000, null, null);

-- 2. update 사용해서 데이터 수정, scott의 보너스 를 500으로 수정
/*    영업사원들의 보너스 300만원으로수정, 
    ward의 부서를 10번으로 수정
    allen의 manager를7839, 월급을 1800, 입사월 22/01/01로 수정
*/
commit

select * from emp;

update emp
set commission = 500
where ename = 'SCOTT';

--/*    영업사원들의 보너스 300만원으로수정, 
update emp
set commission = 300
where job = 'SALESMAN';

select job, commission
from emp
where job = 'SALESMAN'

--    ward의 부서를 10번으로 수정
select * from emp;

update emp
set dno = 10
where ename = 'WARD';

commit
--allen의 manager를7839, 월급을 1800, 입사월 22/01/01로 수정
select * from emp
where ename = 'ALLEN'

update emp
set manager = 7839, salary = 1800, hiredate = '22/01/01'
where ename = 'ALLEN';

--3. delete : eno 7782와 7698의 레코드 삭제
select * from emp
where eno in (7839 , 7698)

delete emp
where eno in (7839, 7698)




/*
Unique 제약조건 : 중복된 데이터를 넣d 수 없다.
    -NULL을 넣을 수 있다. 1번만 넣을 수 있다.
    -테이블에 특정 컬럼을 여러번 넣을 수 있다.
    -인덱스를 자동으로 생성한다 <==검색을 아주 빠르게함
    -JOIN시 ON 절, Where 조건
*/

create table customer1 (
    id varchar(20) not null primary key,    --오류 발생, primary key : not null
    pass varchar(20) not null unique,    --중복되지 않는 컬럼
    name varchar(20) null unique,       --null 허용, 테이블에 여러번 넣을 수 있다.
    phone varchar(20) null unique,
    addr varchar(20) null
    );
    
select * from customer1;   

desc customer1;

insert into customer1 ( id, pass, name, phone, addr)
values ('bbb', '1235', '홍길동2', '010-1111-1112', '서울 종로');

--제약 조건 확인하기
select * from user_constraints
where table_name = 'CUSTOMER1';

/* check 제약 조건: 값을 컬럼에 넣을 때 체크해서 값을 넣음
*/

--테이블 생성시 제약조건의 이름을 부여하면서 테이블생성
 --제약조건 이름 생성 규칙: 테이블이름_컬럼명_제약조건유형
 
create table emp3 (
    eno number(4) constraint emp3_eno_PK primary key,
    ename2 varchar2(10),
    salary number(7,2) constraint emp3_salary_CK check (salary > 0)
    );
    
--emp3 테이블에 할당된 제약조건 확인하기
select * from user_constraint;
where table_name = 'EMP3';


rollback;
insert into emp3(eno, ename, salary)
values (1111,'smith', -10 );

select * from emp3;


create table emp4 (
    eno number(4) constraint emp4_eno_PK primary key,
    ename varchar2(10),
    salary number(7,2) constraint emp4_salary_CK check (salary > 0),
    dno number (2) constraint emp4_dno_CK check (dno in 10,20,30,40))
     );
     
select * from user_constraincs
where table_name ;

select * from employee;

/* FOREIGN KEY (참조키) : 다른 테이블의 (부모) primary key, unique 컬럼을 참조해서 값을 할당
*/

select * from employee; --dno : FK (department 테이블의 dno를 참조)

select * from department;   --,부모, dno

insert into employee
values (9999, 'aaaa', 'aaaa', 7788, '22/12/08', 60000, null, 10);


rollback;

--부모 테이블 생성 : Foreign key가 참조하는 컬럼은 primary key, unique키 컬럼을 참조
create table ParentTb1 (
    name varchar2 (20),
    age number(3) constraint ParentTbl_age_CK check (age>0 and age<200),
    gender varchar2 (3) constraint ParentTbl_gender_CK check (gender IN ( 'M' , 'W')),
    infono number constraint ParentTbl_infono_PK primary key
    );
    
create table ChildTbl (
    id varchar2(40) constraint ChildTbl_id_PK Primary Key,
    pw varchar2(40) ,
    infono number,
    constraint ChildTbl_infono_FK foreign key (infono) references ParentTbl (infono)
    );

    
--부모 테이블에 값 넣기    
insert into ParentTb1 values ('홍길동', 30, 'M', 1);
insert into ParentTb1 values ('김똘똘', 20, 'M', 2);
insert into ParentTb1 values ('원 빈', 25, 'M', 3);
insert into ParentTb1 values ('홍길순', 40, 'W', 4);

commit;

select * from ParentTb1;

--자식 테이블에 값 넣기
insert into ChildTbl1 values ('aaa', '1234', 1);
insert into ChildTbl1 values ('bbb', '1234', 2);
insert into ChildTbl1 values ('ccc', '1234', 3);

/*
    default : 컬럼의 값을 넣지 않을 때 default 로 설정된 값이 기본적으로 들어간다.
        --제약 조건은 아니어서 제약 조건이름을 할당할 수 없다.
*/

create table emp5 (
    eno number(4) constraint emp5_eno_PK primary key,
    ename varchar2(10),
    salary number(7,2) default 1000
    );
    

insert into emp5 (eno, ename, salary)
values (3333, 'aaaa', default);

insert into emp5 (eno, ename, salary)
values (4444, 'aaaa', 1000);

select * from member;
commit;

--테이블 삭제
drop table member;



