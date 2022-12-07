--1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select substr(hiredate, 1, 2) 입사년도,  substr(hiredate, 4, 2) 입사달
from employee;

select * from employee;


--2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename 사원명, substr(hiredate, 4, 2) 입사한달
from employee
where substr(hiredate, 4, 2) like '_4';  


--3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select *
from employee
where mod(manager, 2) = 1;


--3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select *
from employee
where mod(salary, 3) = 0;


--4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오.
select hiredate, to_char(hiredate, 'YY/MON/DD DY')
from employee;

desc employee;


--5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 
    --TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오.
select to_date ('2022-12-07' , 'YYYY-MM-DD') - to_date ('2022-01-01', 'YYYY-MM-DD') 지난날
from dual;

--5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc(sysdate - to_date ('1995-05-26', 'YYYY-MM-DD')) 태어난지며칠
from dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc(months_between(sysdate, '1995-05-26')) 태어난지몇달
from dual;


--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename 사원명, nvl(manager, 0) 상관사번
from employee;


--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALYST' 사원은 200 , 'SALESMAN' 사원은 180,
--    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select job 직급, salary 급여,
    decode (job, 'ANALYST', salary + 200,
    'SALESMAN', salary + 200,
    'MANAGER', salary + 150,
    'CLERK', salary + 100 ) 인상된급여
from employee;

--8.   사원번호,
--      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
--      이름, 
--       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"

select eno,
    RPAD(SUBSTR(eno,1,2),4,'*') "가린 번호",
    ename,
    RPAD(SUBSTR(ename,1,1), 4, '*')"가린 이름"
from employee;


--9.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
--	dual 테이블 사용

select rpad(substr('801210-1111111',1,8),14,'*') 주민번호
from dual;
    
select rpad(substr('010-1234-5678',1,6),12,'*') 전화번호 
from dual; 


--10. 사원번호, 사원명, 직속상관, 
--	[직속상관의 사원번호가 없을 경우 : 0000
--	 직속상관의 사원번호가  앞 2자리가 75일 경우 : 5555
--	직속상관의 사원번호가  앞 2자리가 76일 경우 : 6666
--	직속상관의 사원번호가  앞 2자리가 77일 경우 : 7777
--	직속상관의 사원번호가  앞 2자리가 78일 경우 : 8888
--	그외는 그대로 출력. ] 

select ename 사원명, eno 사원번호, manager 직속상관,
    case when manager is null then '0000' 
        when manager like '75%%' then '5555'
        when manager like '76%%' then '6666'
        when manager like '77%%' then '7777' 
        when manager like '78%%' then '8888'
        else 'DEFAULT'
    end 직속상관2
from employee;




       
    







