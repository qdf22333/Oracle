/*
SQL (Structed Query Language) : 구조화된 질의 언어, (시퀄)
    select 컬럼
    from 테이블명, 뷰명
    where 조건
    group by 그룹핑할 컬럼명
    having 나온결과에 대한 조건
    order by 정렬할 컬럼 
    
DDL (Data Definition Language) : 데이터 정의 언어, 객체를 생성, 수정, 삭제
        객체(Object) - Table, View, Function, Index, Store Procudure, Triger, USER...
    CREATE(생성), ALTER(수정), DROP(삭제)
    RENAME(객체이름변경), TRUNCATE(레코드 삭제)

DML (Data Manipulation Language) : 데이터 조작언어, 레코드를 생성, 수정, 삭제
    INSERT (생성), UPDATE(수정), DELETE(삭제)
    --트랜잭션을 발생시킴. commit(DB에 영구저장), rollback(원래 상태로 되돌림)
DCL (Data Control Language) : 데이터 제어 언어, 계정에 권한을 부여, 권한 부여, 삭제할 때 사용
    GRANT (권한을 부여), REVOKE (권한을 취소)
    
DQL (Data Query Language) : 데이터 질의 언어 (출력) : SELECT
TCL (Transaction Control Language) : 트랜잭션 처리 언어
    BEGIN TRANSACTION <== 트랜잭션 시작 (INSERT, UPDATE, DELETE <== DML)
    COMMIT <== 트랜잭션을 종료 (DataBase에 영구저장)
    ROLLBACK <== 트랜잭션을 종료 (원래 상태로 되돌림, 트랜잭션 시작 전 상태로 되돌림)
    SAVEPOINT (트랜잭션내의 임시 저장 시점 설정)
    
*/

--테이블 생성 (Create Table)

Create Table dept (      --생성할 테이블 명
    dno number(2) not null,     --컬럼명 자료형 (생략 불가능) NULL 허용여부
    dname varchar2(4) not null,
    loc varchar2(13) null
    );
    
--테이블 구조 확인    
desc dept;    

-- 테이블에 값 넣기 (INSERT INTO 테이블명 (명시할 컬럼명) values (넣을값));
    --BEGIN TRANCTION <==트랜잭션이 자동시작

Begin TRANSACTION
insert into dept (dno, dname, loc) 
values (10,'ACCO', 'SEOUL');


commit;     --Data Base에 영구적으로 저장
rollback;   --트랜잭션 시작시점으로 되돌려라

--데이터 검색하기
select * from dept;

/*
트랜잭션 ( TRANCTION) : 작업(일)을 처리하는 최소 단위
    -- DML (Insert, Update, Delete 문을 사용하면 자동으로 트랜잭션이 시작됨)
    --트랜잭션을 종료하지 않으면 외부에서 다른 사용자가 접근을 못함
    --트랜잭션 종료
        --commit : DB에 영구저장
        --rollback : 원래 상태로 되돌림
        
    --트랜잭션의 4가지 특징
        --원자성(Atomiciy) : 여러 구문을 하나의 작업 단위로 처리됨
        --일관성(Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가져야 한다.
        --독립성(Isolation) : 하나의 트랜잭션이 처리되기 전까지는 다른 트랜잭션과 격리
        --지속성(Durability) : commit 된 트랜잭션은 DB에 영구적으로 처리됨
    

*/
select * from dept;

--컬럼과 값의 순서가 맞아야 한다.
insert into dept (dno, loc, dname)
values (20, 'PUSAN', 'SALE');


--컬럼명을 생략시 값넣기 , 모든 컬럼에 값을 넣어줘야 한다.
insert into dept
values (30, 'abc', 'DEAGU');

insert into dept (dno, dname)
values (30, 'abc');

commit;

--회원 정보를 저장하는 테이블 생성
create table member (
    id varchar2(50) not null primary key,
    pass varchar2(50) not null, 
    addr varchar2(100) null, 
    phone varchar(30) null,
    age number(3) not null,
    weight number (5, 2) not null
    );
    

/*
제약조건 
    --Primary Key : 테이블에서 하나만 존재할 수 있다.
        --primary key가 적용된 컬럼은 중복된 값을 넣을 수 없다.
        --데이터를 수정할 때나, 삭제시 조건을 사용하는 컬럼
        --인덱스가 자동으로 생성된다. <== 검색을 빠르게 할 때 사용
        --NULL을 넣을 수 없다.
        
    --Unique : 중복된 값을 넣을 수 없다. 테이블에서 여러번 넣을 수 있다.
        --NULL을 넣을 수 있다. 1번만 넣을 수 있다.
        --인덱스가 자동으로 생성. <== 검색을 빠르게 함.
        
    --check : 값을 넣을 때 체크해서 값을 넣는다.
    --NOT NULL : 컬럼에 NULL을 넣을 수 없다.
    
*/

desc member;

insert into member (id, pass, addr, phone, age, weight)
values ('aaaa', '1234', '서울 종로구', '010-1111-1111', 20, 50.55);


insert into member (id, pass, addr, phone, age, weight)
values ('bbbb', '1234', '서울 종로구', '010-1111-1111', 20, 50.55);

insert into member (id, pass, addr, phone, age, weight)
values ('cccc', '1234', '서울 종로구', '010-1111-1111', 20, 50.55);
        
select * from member;

--null 허용 컬럼에 null 넣기
desc member;
insert into member
values ('dddd', '1234', null, null, 30, 70.557);

commit;

insert into member (pass, age, weight, id)
values ('1234', 40, 88.888, 'eeee');



--수정 (UPDATE) <==반드시 where 절을 사용해서 수정해야함
    --where 절에 사용되는 컬럼은 중복되지 않는 컬럼을 사용해서 수정 : Primary Key, Unique
    --update 테이블명
    --set 컬럼명 = 바꿀값, 컬럼명 = 바꿀값
    --where 조건
    
select * from member;

update member
set phone = '010-2222-2222', age =55, weight=90.55
where id = 'bbbb'

rollback
commit

--update 시 중복되지 않는 컬럼에 조건을 준 경우
update member
set phone = '010-3333-3333', age = 80
where pass = '1234'

update member
set phone = '010-3333-3333', age = 80
where id = 'eeee'


--delete : 반드시 where 조건을 사용해야 한다. 조건없이 삭제하면 모든 데이터가 삭제됨
    --중복되지 않는 컬럼을 조건에 적용 : primary key, unique
select * from member;
rollback
commit

delete member
where id = 'cccc'

--테이블 복사 (EMP)
create table emp
as
select * from employee;


--복사된 테이블
select * from emp;

/*
1. 값을 3 레코드 입력, 모든값 입력, null이 허용된 컬럼에 null 넣기.
2. update 사용해서 데이터 수정, scott의 보너스 를 500으로 수정
    영업사원들의 보너스 300만원으로수정, 
    ward의 부서를 10번으로 수정
3. delete : eno 778와 7698

*/



    
    