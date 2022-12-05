show users;

show user;

--모든 테이블 출력하기
select * from tab;

--테이블의 구조 확인하기
    --select : 출력하라
    /*
        select 컬럼명 
        form 테이블이름 
        
    */
-- 1. employee 테이블의 모든 컬럼을 출력하라.
        --근로자 (고용자)에 대한 정보를 저장
select *
from employee;

--2. department 테이블의 모든 컬럼을 출력하라.
    -- 부서에 대한 정보를 저장하는 테이블
select *
from department;

-- 3. salgrade 테이블의 모든 컬럼을 출력하라.
    --판매 순위를 저장하는 테이블
select *
from salgrade;

-- ============================================
-- 각 테이블의 각각의 컬럼정보
-- 1. employee 테이블
select * from employeel;
select * from employee;
/*
    ENO : 사원 번호
    ENAME : 사원명
    JOB : 직책
    MANAGER : 상관의 사원번호 (사수의 사원번호)
    HIREDATE : 입사일
    SALARY : 월급
    COMMISION : 보너스
    DNO : 부서번호
    
*/

--2. 부서 정보를 저장하는 테이블
select * from department;
/*
    DNO : 부서번호
    DNAME : 부서명
    LOC : 부서 위치
*/


-- 3. 월급의 순위를 저장하는 테이블
select * from salgrade;

/*
    GRADE : 순위  <==월급의 순위
    LOSAL : 제일 낮은 월급
    HISAL : 제일 높은 월급
*/


--=============================
--Select : 출력하라
--컬럼, 필드, 엔티티
--레코드 : 각 컬럼에 들어간 값, 1라인
--레코드 셋 : 레코드들의 집합
select *
from employee;

--특정 컬럼만 출력하기
select ENO
from employee;

--특정 컬럼 여러개 출력하기 (하나의 컬럼이 끝날경우 , 로 구분)
select eno, ename, salary
from employee;

--모든 컬럼 출력하기
select eno,eno,eno, ename, job, manager, hiredate, salary, commission, dno, eno
from employee;

-- 특정 컬럼만 출력시 여러번 출력하기
select eno, ename, salary, ename, ename
from employee;

--테이블의 구조 확인하기 : 테이블의 컬럼들을 확인
DESCRIBE employee;
DESC employee;

--컬럼을 별칭으로 출력하기 (as 별칭)
select eno as 사원번호, ename as 사원명, job as 직책
from employee;

select eno 사원번호, ename 사원명, job 직책
from employee;

--employee 테이블의 모든 컬럼을 별칭으로 출력하기
select eno 사원번호, ename 사원명, job 직책, manager 상관번호,
    hiredate 입사일, salary "월#급", commission 보너스, dno "부서 번호"
from employee;

--조건을 사용하여 출력하기 :where

select *
from employee
where eno = 7499;   --조건을 사용해서 출력할 경우 , eno 컬럼의 값이 7499 

desc employee;  -- <== employee테이블의 구조를 확인

-- 값을 출력시 : number 데이터 타입의 값은 '' 없이 출력
--             number 이외의 데이터 타입은 '' : char, varchar, date

select * from employee
where job = 'MANAGER' ;  -- job  (varchar2), 값을 가져올 때는 대소문자 구별함.
    --job 
    
desc employee;

select * from employee

-- 부서번호가 20번인 모든컬럼을 출력하라.

select * from employee
where dno = 20;

-- 문제>
-- salary (월급) 2000만원 이상인 사용자만 모든컬럼출력
-- 이름이 CLERK인 사용자의 월급만 출력
-- 사원번호(ENO)가 7788인 사용자의 이름과 입사날짜 출력    <==컬럼이름을 별칭으로 출력

select * from employee;

desc employee;

-- 월급 2000만원 이상인 사람들 출력
select *
from employee
where salary >= 2000;


-- 이름 CLARk인 사용자 월급만 출력
select salary 월급, ename 이름, eno 사원번호
from employee
where ename = 'CLARK';

--사원번호 7788 사용자 이름, 입사날짜 출력, 컬럼이름 별칭으로 출력
select ename 사원명, hiredate 입사날짜, eno 사원번호
from employee
where eno = 7788;

--Select 문의 전체 구조 ---------------------------------
/*

select  --컬럼명 : * (모든컬럼), 
distinct    -- 중복된 값을 제거해서 출력하라 (생략가능)
from    -- 테이블명, 뷰이름
where   --조건
group by    --컬럼명 : 특정 컬럼의 동일한 값을 그룹핑
having  -- group by에서 나온 결과를 조건 처리
order by    --정렬해서 출력할 컬럼, asc : 내림차순 정렬, desc : 오름차순 정렬

*/
select * from employee;

select distinct dno 부서번호    
--distinct 중복된 값은 제거 후 출력, 다른 컬럼과 동시에 작동하면 오류 발생
from employee;

select distinct dno     --중복을 제거할 컬럼 1개만 사용
from employee;

--컬럼에 연산을 적용 : 컬럼명이 없어짐. alias(별칭)해서 출력
select eno, ename, salary as 월급, salary * 12 as 연봉, commission 보너스
from employee;

--null 컬럼과 연산( + ' * ,/)을 하게되면 전체가 NULL
--전체 연봉 구하기 : 월급 * 12 + commisstion = 전체 연봉
select eno, ename, salary, commission, salary * 12 as 연봉, (salary*12)+ commission as 전체연봉
from employee;

--전체 연봉을 계산할 때 null이 들어간 컬럼을 0으로 변경 후 연산을 적용해야함.
    --nvl 함수 :null이 들어간 컬럼을 다른값으로 변환해서 처리해주는 함수
    --nvl (commission, 0);  <==commission 컬럼이 null을 0으로 수정해서 처리해라

select eno, ename, salary, commission, salary * 12 as 연봉, (salary*12)+ nvl(commission, 0) as 전체연봉
from employee;


---- null 이 들어간 컬럼을 출력하기 <== 주의    ------
    --null을 검색할 때는 is를 사용 , = 를 사용하면 오류

select * 
from employee
where commission is null;

select * 
from employee
where commission is not null;

--where 조건에서 and , or 사용하기

-- 부서번호가 20번과 30번인 모든 컬럼 출력
select *
from employee
where dno = 20 or dno = 30;


select *
from employee
where dno = 20 or salary >=2000;

select *
from employee
where dno = 20 and salary <= 1500;

-- job (직책) MANAGER 이면서 월급이 2000만원 이상인 사용자만 출력
select *
from employee
where job = 'MANAGER' and salary >= 2000;


select * from employee;
/*  employee 테이블에서 작업, Select 문을 사용, where 조건을 사용해서 출력
<문제 1> 컬럼 알리어스 (별칭), commission (보너스) 컬럼의 null인 값만 출력하되, 사원번호, 사원이름, 입사날짜를 출력
<문제 2> dno (부서번호) 가 20이고 입사날짜가 81년 4월 이후 사원의 이름과 직책과 입사날짜를 출력
<문제 3> 연봉을 계산해서 사원번호, 사원이름, 월급, 보너스, 전체 연봉을 출력
<문제 4> commission이 null이 아닌 사용자의 이름만 출력
<문제 5> manager (직급상사)7698 인 사원이름과 직책을 출력.
<문제 6> 월급이 1500 이상이고 부서가 20인 사원의 사원이름, 입사날짜 , 부서번호 , 월급 출력
<문제 7> 입사날짜가 81년 4월 1일부터 12월 말일까지인 사원 이름과 입사날짜를 출력
<문제 8> 직책이 (job) salesman이면서 연봉이 1500 이상이면서 부서번호가 30인 사원명을 출력
<문제 9> 월급이 1500 이하이면서 부서번호가 20번이 아닌 사원이름과 월급, 부서번호 출력
<문제 10> 사원번호 (eno)가 7788, 7782인 사원의 부서번호와 이름, 직책 출력
*/

--<문제 1> 컬럼 알리어스 (별칭), commission (보너스) 컬럼의 null인 값만 출력하되, 사원번호, 사원이름, 입사날짜를 출력
select commission 보너스, eno 사원번호, ename 사원이름, hiredate 입사날짜
from employee
where commission is null;

--<문제 2> dno (부서번호) 가 20이고 입사날짜가 81년 4월 이후 사원의 이름과 직책과 입사날짜를 출력
select ename, job, hiredate
from employee
where dno = 20 and hiredate > '1981.04.01';

--<문제 3> 연봉을 계산해서 사원번호, 사원이름, 월급, 보너스, 전체 연봉을 출력
select eno 사원번호, ename 사원이름, salary 월급, commission 보너스, (salary *12) + nvl(commission, 0) 전체연봉
from employee;

--<문제 4> commission이 null이 아닌 사용자의 이름만 출력
select ename
from employee
where commission is not null;

--<문제 5> manager (직급상사)7698 인 사원이름과 직책을 출력.
select ename 사원이름, job 직책
from employee
where manager = 7698;

--<문제 6> 월급이 1500 이상이고 부서가 20인 사원의 사원이름, 입사날짜 , 부서번호 , 월급 출력
select ename 사원이름, hiredate 입사날짜, dno 부서번호, salary 월급
from employee
where salary >= 1500 and dno = 20;

--<문제 7> 입사날짜가 81년 4월 1일부터 12월 말일까지인 사원 이름과 입사날짜를 출력
select ename 사원이름, hiredate 입사날짜
from employee
where hiredate between to_date('1981-04-01', 'yyyy-mm-dd')
                and to_date('1981-12-31', 'yyyy-mm-dd');
                
--<문제 8> 직책이 (job) salesman이면서 연봉이 1500 이상이면서 부서번호가 30인 사원명을 출력                
select ename 사원이름
from employee
where job = 'SALESMAN' and salary >=1500 and dno = 30;

--<문제 9> 월급이 1500 이하이면서 부서번호가 20번이 아닌 사원이름과 월급, 부서번호 출력
select ename 사원이름, salary 월급, dno 부서번호
from employee
where salary <=1500 and dno != 20;


--<문제 10> 사원번호 (eno)가 7788, 7782인 사원의 부서번호와 이름, 직책 출력
select ename 사원이름, job 직책, dno 부서번호
from employee
where eno = 7788 or eno = 7782;


                
                














