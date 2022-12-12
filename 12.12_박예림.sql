--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오.
select e.ename 사원명, e.dno 부서번호, d.dname 부서이름
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

select * from employee;
select * from department;

--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
select e.ename 사원명, d.dname 부서이름, d.loc 지역명
from employee e INNER JOIN department d
on e.dno = d.dno
order by ename;

--3. INNER JOIN을 사용하여 10번 부서에 속하는 
--모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
select e.eno 사원번호, loc 지역명, job 담당업무
from employee e inner join department d
on e.dno = d.dno and d.dno = 10;

--4. NATURAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select ename 사원명, dname 부서명, loc 지역명, nvl(commission, 0) 커미션
from employee e NATURAL JOIN department d
where commission <> 0;

--5.EQUI 조인과 WildCard ( _ , %)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename 사원명, dname 부서명
from employee e, department d
where e.dno = d.dno
and ename like '%A%';

--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename 사원명, job 업무, dno 부서번호, dname 부서명, loc 근무지역
from employee e NATURAL JOIN department d
where loc = 'NEW YORK';

--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
-- 	각 열(컬럼)에 별칭값을 한글로 넣으시오. 
select e.ename 사원명, e.eno 사원번호, m.ename 관리자이름, m.eno 관리자번호
from employee e INNER JOIN employee m
on e.manager = m.eno
order by e.ename;

--8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
select e.ename 사원명, e.eno 사원번호, m.ename 관리자
from employee e, employee m
where e.manager = m.eno (+)
order by e.eno desc;

--9. SELF JOIN을 사용하여 지정한 사원의 이름(SCOTT), 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
--   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
select e.ename 이름, e.dno 부서번호, m.ename 동료
from employee e, employee m
where e.dno = m.dno
and e.ename = 'SCOTT';

--10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select e.ename 사원명, e.hiredate 입사일, m.ename "늦게 입사한 사원명", m.hiredate "늦게 입사한 사원 입사일"
from employee e, employee m
where e.hiredate < m.hiredate
and e.ename = 'WARD';

--11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
--    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
select e.ename 사원이름, e.hiredate 입사일, m.ename 관리자이름, m.hiredate 관리자입사일
from employee e, employee m
where e.hiredate < m.hiredate
and e.manager = m.eno;



--<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>
--1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.
select ename 사원이름, job 담당업무, eno 사원번호
from employee
where eno = (select eno from employee where eno = 7788);

--2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename 사원이름, job 담당업무, eno 사원번호, salary 월급
from employee
where salary > (select salary from employee where eno = 7499);

--3. 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary = (select min(salary) from employee);

--4. 평균 급여가 적은 사원의 담당 업무를 찾아 직급과 평균 급여를 표시하시오.
select job 담당업무, avg(salary) 평균급여
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

--5. 각 부서의 초소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename 사원명, salary 급여, dno 부서번호
from employee
where salary in (select min(salary) from employee group by dno)
order by dno;

--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시
                        --(사원번호, 이름, 담당업무, 급여) 하시오.    
select eno 사원번호, ename 사원이름, job 담당업무, salary 급여
from employee
where salary < all (select salary from employee where job = 'ANALYST')
    and job <> 'ANALYST';
    
--7. 부하직원이 없는 사원의 이름을 표시 하시오.     
select ename 사원명
from employee
where eno in (select eno from employee where manager is null);

select * from employee;

--8.부하직원이 있는 사원의 이름을 표시 하시오. 
select ename 사원명
from employee
where eno in (select eno from employee where manager is not null);

--9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename 사원명, hiredate 입사일
from employee
where dno = (select dno from employee where ename = 'BLAKE')
    and ename <> 'BLAKE';
    
--10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno 사원번호, ename 사원명, salary 급여
from employee
where salary > (select avg(salary) from employee)
order by salary;

--11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno 사원번호, ename 사원명, dno 부서번호
from employee
where dno in (select dno from employee where ename like '%K%');

--12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오.
select ename 사원명, dno 부서번호, job 담당업무
from employee
where dno = (select dno from department where loc = 'DALLAS');

--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename 사원명, salary 급여
from employee
where manager = (select eno from employee where ename = 'KING');

--14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
select ename 사원이름, job 담당업무, dno 부서번호
from employee
where dno = (select dno from department where dname = 'RESEARCH');

--15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno 사원번호, ename 사원명, salary 급여
from employee
where salary > (select avg(salary) from employee)
    and dno in (select dno from employee where ename like '%M%');
    
--16. 평균 급여가 가장 적은 업무를 찾으시오.
select job 업무, avg(salary) 평균급여
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

--17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select ename 사원이름
from employee
where dno in (select dno from employee where job = 'MANAGER');
























