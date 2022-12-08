--5. 일반함수
--NVL, NVL2, NULLIF,
--coalesce,

--NVL 함수 : NULL을 처리하는 함수
    --nvl (컬럼명, 값) : 컬럼에 null이 존재할 때 값으로 대치
    --연봉은 = 월급 * 12 + 보너스
    --보너스 컬럼에 null을 연산하면 null
--NVL 함수를 사용해서 총 연봉 계산    
select ename 사원명, salary 월급, commission 보너스, salary * 12 + nvl(commission, 0) 총연봉
from employee;

--NVL2 함수 : NULL을 처리하는 함수
    -- nvl2 (컬럼명, null이 아닐 경우 처리, null일 경우 처리)
--NVL2 함수를 사용해서 총 연봉 계산
select ename 사원명, salary 월급, commission 보너스, 
    nvl2(commission, salary * 12 + commission, salary * 12) 총연봉
from employee;

--nullif 함수 : 두 인자를 비교해서 동일한 경우, NULL`을 반환, 
    --동일하지 않은 경우 첫번째 표현식을 반환
    --nullif (expr1, expr2)
select nullif('A', 'A'), nullif('A', 'B')
from dual;


--coalesce 함수
--    coalesce (expr1, expr2, expr3 ... expr-n) :
--      expr1이 null이 아니면 expr1 반환, 
--      expr1이 null이고 expr2가 null이 아니면 expr2 반환,
--      expr1이 null이고 expr2가 null이고 expr3가 null이 아니면 expr3 반환

select coalesce ('abc', 'bcd', 'cde', 'def', 'efg')
from dual;

select coalesce (null, 'bcd', 'cde', 'def', 'efg')
from dual;

select coalesce (null, null, 'cde', 'def', 'efg')
from dual;

select coalesce (null, null, null, 'def', 'efg')
from dual;

select coalesce (null, null, null, null, 'efg')
from dual;

--decode 함수 : switch case 문과 동일한 함수
/*
    decode (표현식(컬럼명), 조건1, 결과1, 
                조건2, 결과2,
                조건3, 결과3,
                ...
                기본결과n
           )
*/

--DNO : 부서번호 
-- 10 'ACCOUNTING'
-- 20 'RESEARCH'
-- 30 'SALES'
-- 40 'OPERATION'
-- 'DEFAULT'

select ename, dno, 
    decode (dno, 10, 'ACCOUNTING',
    20, 'RESEARCH',
    30, 'SALES',
    40, 'OPERATION',
    'DEFAULT') 부서명
from employee;


--case : if ~ else , else if 와 비슷한 구문
/*
    case WHEN 조건1 THEN 결과1
        WHEN 조건2 THEN 결과2
        WHEN 조건3 THEN 결과3
        ELSE 결과n
    END    
*/
--부서 번호에 대한 부서명 출력 : case
select ename, dno,
    case when dno = 10 then 'ACCOUNTING'
        when dno = 20 then 'RESEARCH'
        when dno = 30 then 'SALES'
        else 'DEFAULT'
    END 부서명
from employee;

--chapter04 : 그룹함수
/*

그룹함수 :  동일한 값에 대해서 그룹핑해서 처리하는 함수
    group by 절에 특정 칼럼을 정의할 경우, 해당 컬럼의 동일한 값을 그룹핑해서 연산처리
    
집계함수 :  연산을 처리하는 함수
    -SUM : 합계를 구하는 함수 
    -AVG : 평균을 구하는 함수
    -MAX : 최대값을 출력
    -MIN : 최소값을 출력
    -COUNT : 레코드수(한 라인의 값이 저장된), ROW(행)
    
    select 컬럼명
    from 테이블명, 뷰 (가상으로 생성된 테이블)
    where 조건        <==테이블에서 원하는 조건을 가지고 올 때
    group by 그룹핑할 컬럼
    heving    group by 를 사용해서 나온 결과에서 조건을 처리
    order by 정렬
*/

--집계함수를 컬럼에사용하면 단일행으로 출력됨
select --salary,
    sum(salary) as 합계, round(avg(salary), 2) 평균,
    max(salary) 최대월급, min(salary) 최소월급
from employee;

--집계함수는 NULL을 0으로 자동 처리해서 연산
select commission
from employee;

select sum(commission), avg(commission), max(commission), min(commission)
from employee;

--count 함수 : 레코드 수를 출력, row(행) 수, 
    --NULL 은 카운트 되지 않음
    
select count(eno) as "레코드 수"
from employee;

--NULL은 카운트 되지 않는다.
select count(manager)
from employee;

-- 보너스를 받는 사원 수 : 4명
select count(commission)
from employee;

--특정 컬럼을 count 함수를 사용하면 전체 레코드 수를 부정확하게 출력할 수 있음
    --NOT NULL 저의된 컬럼을 카운트 해야 한다.
    
desc employee;

select * from employee;

select count(eno)   --not null
from employee;

-- 테이블의 전체 레코드 수를 출력시 : not null로 지정된 컬럼이나 (desc 필드명 으로 확인), *을 사용해서 count 해야함.elect count(*)
 
 --직업의 개수를 출력
select count(distinct job)
from employee;

--부서의 개수
select count(distinct dno) 부서개수
from employee;

--부서별로 급여의 합계, 평균, 최대값, 최소값 구하기 : group by <== 컬럼의 동일한 값을 그룹핑해서 처리
select * from employee
order by dno;

select dno 부서번호, sum(salary) "부서별 월급 합계", trunc(avg(salary)) "부서별 월급 평균", 
    max(salary) "부서별 최대 월급", min(salary) "부서별 최소 월급"
from employee
group by dno    --dno 컬럼의 동일한 값을 그룹핑
order by dno;

-- 직책별로 월급의 합계, 평균, 최대값, 최소값 구하기
select job 직책, sum(salary) "직책별 월급 합계", trunc(avg(salary)) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급"
from employee
group by job
order by job;


--group by 에서 나온 결과를 조건으로 처리해서 출력 :having <조건>
    --별칭이름을 사용해서 조건을 처리하면 오류발생

-- 직책별 평균월급이 2000만원 이상인 경우만 출력
select job 직책, sum(salary) "직책별 월급 합계", trunc(avg(salary)) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급"
from employee
group by job
having trunc(avg(salary)) >= 2000       -- group by 를 사용해서 나온 결과에 대한 조건 처리
order by job;

--having 절에서 별칭이름을 사용할 경우 오류발생  <== ***주의주의***
select job 직책, sum(salary) "직책별 월급 합계", trunc(avg(salary)) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급"
from employee
group by job
having "직책별 월급 평균" >= 2000       -- group by 를 사용해서 나온 결과에 대한 조건 처리, 별칭이름 사용시 오류발생
order by job;

--where : 테이블의 값을 조건을 주어서 가지고 올 때 사용
--having : group by를 사용해서 나온 결과를 조건으로 출력

--20번 부서는 제외하고 부서별 월급 합계, 평균, 최대값, 최소값을 구하되, 부서별 최소월급이 1000만원 이상인 것만 출력
select dno 부서번호, sum(salary) "부서별 월급 합계", trunc(avg(salary)) "부서별 월급 평균", 
    max(salary) "부서별 최대 월급", min(salary) "부서별 최소 월급"
from employee
where dno not in 20     --20번 부서는 제외    <==조건을 사용해서 원하는 값만 테이블에서 가져온 후 
group by dno    --dno 컬럼의 동일한 값을 그룹핑
having min(salary) >= 1000;  --group by로 나온 결과에서 조건을 처리할 때 

--두 컬럼이상을 그룹핑하기 : 두 컬럼 모두 동일할 때 그룹핑 처리됨
select dno, job
from employee
order by dno, job;

-- count(*) 를 사용하면 중복된 레코드가 몇개인지 확인가능
select sum(salary), round(avg(salary)), max(salary), min(salary), dno, job, count(*)
from employee
group by dno, job
order by dno, job;

--group by 를 사용하면서 select 절에 출력할 컬럼
    --집계함수(sum, avg, max, min), count(*), group by 절에 사용된 컬럼
    
--Rollup : 마지막라인에 전체 합계, 전체 평균을 추가적으로 출력 : group by 절에서 사용됨
select sum(salary), round(avg(salary)), max(salary), min(salary), dno, count(*)
from employee
group by dno
order by dno desc;

--rollup 사용 : 그룹핑한 집계함수도 출력, 마지막라인에 전체에 대한 집계함수도 같이 출력됨
select sum(salary), round(avg(salary)), max(salary), min(salary), dno, count(*)
from employee
group by rollup(dno)
order by dno ;

--cube : 부서별 합계와 평균을 출력 후 마지막 라인에 전체 합계 평균 출력
select sum(salary), round(avg(salary)), max(salary), min(salary), dno, count(*)
from employee
group by cube(dno)
order by dno ;


------------------------------------
/*
    서브 쿼리 (Sub Query): Select 문 내에 Select 문이 들어있는 쿼리
    
*/

--ename 이 SCOTT 인 사원과 동일한 부서의 사원을 출력
select * from employee;
    --syb query를 사용하지 않고 출력
        --1. SCOTT의 부서를 확인
select ename 사원명, job 직책
from employee
where ename = 'SCOTT';

        --2. SCOTT의 부서와 동일한 부서를 조건을 사용해서 출력
select ename, job 
from employee
where job = 'ANALYST';

    --sub query를 사용해서 한 라인에 출력
select ename, job
from employee
where job = (select job from employee where ename = 'SCOTT' );

select * from employee;

--SMITH와 동일한 직책의 사원들을 sub query사용해서 출력
select ename 사원명, job 직책
from employee
where job = (select job from employee where ename = 'SMITH');

--SCOTT보다 월급이 많은 사용자, 서브쿼리한 결과 값이 단일값으로 출력되어야함
select ename 사원명, salary 월급
from employee
where salary > (select salary from employee where ename = 'SCOTT');

--SCOTT과 동일한 부서에 근무하는 사원들을 추력
select ename 사원명, dno 부서번호
from employee
where dno = (select dno from employee where ename = 'SCOTT');


--최소급여를 받는 사원의 이름, 담당업무, 급여 출력
select ename 사원명, job 직책, salary 최소급여
from employee
where salary = (select min(salary) from employee);

--각 부서의 최소급여가 30번 부서의최소 급여보다 큰 부서를 출력
--각 부서의 최소급여를 구함
--30 부서의 최소급여보다 큰 부서를 출력

select dno 부서, min(salary) 최소급여, count(*)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30)
order by dno;

/* sub query에서 단일값이 아니라 여러개의 값이 출력될 경우 : IN 연산자를 사용
*/

--각 부서별로 최소급여를 받는 사원의 사원번호와 이름을 출력
select ename 사원명, eno 사원번호, salary 월급, dno 부서번호
from employee
where salary in(
    select min(salary) from employee
    group by dno
    )     --sub query : 부서별로 최소월급을 출력
order by dno;    

--ALL 연산자 : Sub Query에서 반환하는 모든 값을 비교
/*
    ' > all' : 최대값 보다 큼
    ' < all' : 최소값 보다 작음
*/

--직급이 SALESMAN이 아니면서, 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
select eno 사원번호, ename 사원이름, job 직급, salary 급여
from employee
where salary < all (select salary from employee where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
    
--담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무분석가가 아닌 사원들을 출력
select eno, ename, job, salary
from employee
where salary < all (select salary from employee where job = 'ANALYST')
    and job <> 'ANALYST';
    
select salary, job
from employee
where job = 'ANALYST';

select eno, min(salary)


select * from employee;




select * from employee
order by dno;





    