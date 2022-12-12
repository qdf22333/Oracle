/*
    조인, 뷰, 인덱스
*/

/*
    조인 (Join) : 두 개 이상의 테이블 컬럼을 출력시 Join을 사용해서 컬럼의 정보를 가져옴.
        --employee, department 테이블은 원래 하나의 테이블이었다.
        --모델링(중복제거, 성능향상)을 사용해서 두 테이블로 분리.
        --두 개 이상의 테이블에 컬럼을 가져오기 위해서는 Join 문을 사용해서 출력
        --두 테이블을 Join하기 위해서는 두 테이블에서 공통의 키 컬럼이 존재해야함.
        --ANSI 호환 JOIN : 모든 SQL에서 공통으로 사용하는 JOIN구문
            Oracle, My SQL(MariaDB), MS-SQL, IBM DB2, ...<=== DBMS
*/

select * from employee;
select * from department;

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 Join, <== 오라클에서만 사용
    -- ANSI 호환의 SQL 구문에서 INNER JOIN과 같은 구문
        --두 테이블에서 공통으로 적용된 값만 출력해줌. <교집합>
    -- from 절에 join할 테이블 명시 , 를 사용해서 나열(콤마) 
    -- where 절에 두 테이블의 공통의 키 컬럼을 찾아서 = 
    -- and 절에서 조건을 처리
    --두 테이블의 공통 키 컬럼을 select 문에서 출력 할 때 반드시 테이블명을 명시해야함.
        --명시하지 않으면 오류발생

select eno 사원번호, ename 사원명, employee.dno 부서번호, dname 부서명, loc 부서위치
from employee, department               --조인할 테이블 나열 : ,
where employee.dno = department.dno     --두 테이블의 공통의 키 컬럼을 찾아서 : =
and employee.dno >= 20;                 --조건을 처리


select eno 사원번호, ename 사원명, department.dno 부서번호, dname 부서명, loc 부서위치
from employee, department
where employee.dno = department.dno
and employee.dno >= 20;

--위 구문의 전체 구문을 출력

select employee.eno, employee.ename, employee.dno, 
    department.dname, department.loc
from employee, department
where employee.dno = department.dno
and employee.dno >= 20;


--테이블 이름을 알리어스 (별칭) 해서 사용 <== 주로 사용

select eno, ename, salary, hiredate, e.dno, dname, loc
from employee e, department d       --테이블 이름을 별칭 이름으로 사용
where e.dno = d.dno;

-- ANSI 호환의 INNER JOIN <== 모든 SQL 에서 공통으로 사용되는 SQL 구문
    -- Oracle의 EQIE JOIN과 동일한 구문
-- 두 테이블의 공통인 값만 출력 <교집합>
-- ***주의*** : select 절에 공통 키 컬럼을 출력시 테이블을 명시해야함.
-- from 절에 : INNER JOIN 키를 사용해서 JOIN 
-- on 절에 공통의 키 컬럼을 ' = ' 로 처리
-- where 에서 조건을 처리.


select e.eno 사원번호, e.ename 사원명, e.dno 부서번호, d.dname 부서명, d.loc 부서위치
from employee e INNER JOIN department d     -- INNER JOIN 
on e.dno = d.dno        -- 두 테이블의 공통의 키 컬럼을 = 로 처리
where e.dno >= 20;      -- where로 조건을 처리함





-- employee, department 테이블의 사원명과 월급과 입사일, 부서명, 부서위치를 출력하되,
    -- 월급이 2,000 이상인 사원만 출력.

--EQIE JOIN (등가조인) < ==Oracle 에서만 사용
select ename 사원명, salary 월급, hiredate 입사일, dname 부서명, loc 부서위치
from employee e, department d
where e.dno = d.dno     --join 시 두 테이블의 공통 키 컬럼
and salary >= 2000;


--ANSI 호환 INNER JOIN <== 모든 SQL에서 공통으로 사용
select ename 사원명, salary 월급, hiredate 입사일, dname 부서명, loc 부서위치
from employee e INNER JOIN department d
on e.dno = d.dno
where salary >=2000;


-- 두 테이블을 JOIN 해서 부서별 월급의 최대 값을 출력 (employee, department)
    --부서명을 출력 (group by 사용)

--EQIE JOIN
select d.dno 부서번호, dname 부서명, max(salary) 월급, count(*)
from employee e, department d
where e.dno = d.dno                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
group by d.dname, d.dno;

--ANSI
select d.dno 부서번호, dname 부서명, max(salary) 월급, count(*)
from employee e INNER JOIN department d     -- , 대신 INNER JOIN
on e.dno = d.dno                            -- where 대신 on 절
group by d.dname, d.dno;

-- NATURAL JOIN : Oracle 9i 지원  <==Oracle 에서만 지원되는 구문
    -- 두 테이블을 JOIN시 두 테이블에서 공통의 키 컬럼을 찾아야 한다.
    -- 두 테이블의 공통의 키 컬럼을 Oracle 내부에서 찾아서 처리함.
    -- EQUI JOIN에서 where 절의 두 테이블의 공통의 키 컬럼을 명시하지 않아도 됨. (where 절 없앰)
    -- where 절 생략시 오라클에서 두 테이블의 공통 키 컬럼을 자동으로 찾아줌.
    -- 두 테이블의 공통 키 컬럼은 동일한 타입이어야 한다. 
    -- select 절에서 공통 키 컬럼을 출력시 테이블명을 명시하면 오류발생
    -- from 절에 natural join 을 사용
    -- where 절에서 조건을 처리
    
-- NATURAL JOIN 을 사용해서 출력하기
-- ***주의*** select 문에서 두 테이블의 공통 키 컬럼을 출력시 테이블 이름을 명시하면 안됨.
-- 
select eno, ename, salary, dno, dname, loc
from employee e NATURAL JOIN department d
where dname = 'SALES';
    --  where 절 생략되어 자동으로 Oracle 내부에서 키 컬럼을 자동으로 찾음
    
    
/*
    select 절에서 두 테이블의 공통의 키 컬럼 출력시
            --EQUI JOIN (INNER JOIN) -- 반드시 키 컬럼앞에 테이블 이름 명시.
            --NATURAL JOIN -- 키 컬럼 앞 테이블 이름 명시하면 오류발생
*/
    

-- <문제> 사원이름, 월급, 부서이름, 부서번호를 출력하되 월급이 2000 이상인 사용자만 출력'

-- EQIE JOIN (등가 조인) : Oracle 만 사용 
select ename 사원이름, salary 월급, e.dno 부서번호, dname 부서이름
from employee e, department d
where e.dno = d.dno
and salary > = 2000;


-- NATURAL JOIN         : Oracle 만 사용 <== 두 테이블의 공통키 컬럼을 자동으로 Oracle 에서 찾음
select ename 사원이름, salary 월급, dno 부서번호, dname 부서이름
from employee e NATURAL JOIN department d
where salary > = 2000;


-- ANSI 호환 : 모든 SQL 에서 사용, INNER 는 생략가능
select ename 사원이름, salary 월급, e.dno 부서번호, dname 부서이름
from employee e INNER JOIN department d     -- INNER JOIN (두 테이블의 공통인 값만 출력)
on e.dno = d.dno
where salary > = 2000;



--NON EQUI JOIN (비 가조인): Oracle 에서만 적용
    -- from 절에 테이블을 , 로 나열
    -- where 절에 = 을 사용하지 않는 JOIN 구문 <== 공통 키 컬럼없이 JOIN
    
-- 월급에 대해서 등급을 출력하는 테이블
select * from salgrade;     

-- 사원 정보를 출력하는 테이블
select * from employee;

-- 사원의 부서정보를 저장하는 테이블
select * from department;

-- NON EQUI JOIN : EQUI JOIN 구문에서 where 절의 공통 키 컬럼없이 JOIN : = 없이 
-- employee, salgrade 테이블을 join 해서 각 사원의 월급의 등급을 출력
select ename, salary, grade
from employee e, salgrade s         -- from 절에서 테이블을 ,로 나열됨 (EQUI JOIN)
where salary between losal and hisal;

--employee, department, salgrade 테이블을 join 해서 
    --사원이름, 부서이름, 월급, 월급의 등급
select ename 사원이름, dname 부서이름, salary 월급, grade 월급등급
from employee e, department d, salgrade s
where e.dno = d.dno         --employee 테이블, department 테이블
and salary between losal and hisal;     --employee 테이블, salgrade 테이블

--사원번호, 입사일, 부서번호, 월급, 월급의 등급, 부서명
--employee, department, salgrade를 join 해서 출력
select eno 사원번호, hiredate 입사일, e.dno 부서번호, salary 월급, grade 월급등급, dname 부서명
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal;


/*
    INNER JOIN : 90%, 두 테이블에서 공통의 내용을 출력 (e.dno = d.dno)
        --EQUI JOIN, NATURAL JOIN : Oracle
        --INNER JOIN : ANSI 호환 (모든 DBMS에서 공통으로 사용되는 구문)
*/

--관리자가 7788인 eno, ename, manager
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where manager = 7788
order by ename;

--직속상관의 정보를 출력
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where eno = 7788;

select * from employee;

--SELF JOIN 을 사용해서 자신의 테이블을 JOIN해서 사원에 대한 직속 상관 정보를 한 번에 출력

--EQUE JOIN 을 사용해서 SLEF JOIN출력
select e.ename 사원이름, m.manager, m.eno, m.eno 직속상관번호, m.ename 직속상관이름
from employee e, employee m        --두 테이블 모두 employee 테이블, 반드시 별칭 이름을 사용
where e.manager = m.eno
order by e.ename;

select eno, ename, manager , eno, ename, manager
from employee;



select * from employee
order by ename;


--ANSI 호환 구문을 사용해서 SELF JOIN 
--employee 테이블을 SELF JOIN해서 사원에 대한 직속상관을 출력
select e.ename || '의 직속상관은 '|| m.ename || '입니다.'
from employee e INNER JOIN employee m
on e.manager = m.eno
order by e.ename;

select eno, ename, manager, eno, ename, manager
from employee;

select * from employee
order by ename;

/*
    Outer JOIN:
        --특정 컬럼의 내용은 두 테이블에 공통적이지 않은 내용도 출력해야 할 때
        --NULL 출력
        -- + 를 사용해서 Outer Join : Oracle
        --ANSI 호환 구문 사용할 때는 : Outer Join 구문 사용
            --LEFT OUTER JOIN, LEFT JOIN
            --RIGHT OUTER JOIN, RIGHT JOIN
            --FULL OUTER JOIN, FULL JOIN
*/

-- EQUI JOIN 을 사용하여 INNER JOIN
select e.ename ||' 의 직속 상관은 '|| m.ename ||' 입니다. '
from employee e, employee m
where e.manager = m.eno;        --enmanager와 m.eno의 값이 일치하는 내용만 출력. (13개 레코트 출력)

-- EQUI JOIN 을 사용하여 Outer JOIN
select e.ename ||' 의 직속 상관은 '|| m.ename ||' 입니다. '
from employee e, employee m
where e.manager = m.eno (+);        --m.eno 컬럼의 내용은 e.manager의 값이 없더라도 무조건 출력


select eno, ename, manager, eno, ename, manager
from employee ;

-- ANSI 호환에서 Outer JOIN
    -- LEFT OUTER JOIN, LEFT JOIN   : 왼쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- RIGHT OUTER JOIN, RIGHT JOIN : 오른 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- FULL OUTER JOIN, FULL JOIN   : 왼쪽, 오른쪽 모두 매칭되지 않는 내용도 무조건 출력
    
select e.ename ||' 의 직속 상관은 '|| m.ename ||' 입니다. '
from employee e LEFT JOIN employee m
on e.manager = m.eno
order by e.ename;



/* SELF JOIN : 자신의 테이블(원본)을 가상의 테이블 (원본을 복사한 테이블) JOIN 함.
        --자신의 테이블을 다시 한 번 조인
        --반드시 테이블을 별칭이름으로 만들고 별칭이름을 사용해서 JOIN
        --회사의 조직도를 SQL 구문으로 출력할 때, 직급 상사가 누구인지 출력할 때 주로 사용
        

*/


/*
    카다시안 곱 : 왼쪽 테이블의 하나의 레코드에서 오른쪽 테이블의 모든 레코드를 곱한다.
    employee : 14
    department : 4
    카다시안 곱 : 14 * 4 = 56 레코드 출력
*/

select count(*) from employee;
select count(*) from department;

--employee(14), departtment(4) 카다시안 곱 :56
select *
from employee, department;

--INNER JOIN : e.dno = d.dno가 매칭되는 것만 출력
    --EQUI JOIN : Oracle 구문으로 출력
select *
from employee e, department d
where e.dno = d.dno (+);


    





