

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


                
                














