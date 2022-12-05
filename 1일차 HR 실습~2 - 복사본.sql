

select * from employee;
/*  employee ���̺��� �۾�, Select ���� ���, where ������ ����ؼ� ���
<���� 1> �÷� �˸�� (��Ī), commission (���ʽ�) �÷��� null�� ���� ����ϵ�, �����ȣ, ����̸�, �Ի糯¥�� ���
<���� 2> dno (�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
<���� 3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
<���� 4> commission�� null�� �ƴ� ������� �̸��� ���
<���� 5> manager (���޻��)7698 �� ����̸��� ��å�� ���.
<���� 6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸�, �Ի糯¥ , �μ���ȣ , ���� ���
<���� 7> �Ի糯¥�� 81�� 4�� 1�Ϻ��� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
<���� 8> ��å�� (job) salesman�̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
<���� 9> ������ 1500 �����̸鼭 �μ���ȣ�� 20���� �ƴ� ����̸��� ����, �μ���ȣ ���
<���� 10> �����ȣ (eno)�� 7788, 7782�� ����� �μ���ȣ�� �̸�, ��å ���
*/

--<���� 1> �÷� �˸�� (��Ī), commission (���ʽ�) �÷��� null�� ���� ����ϵ�, �����ȣ, ����̸�, �Ի糯¥�� ���
select commission ���ʽ�, eno �����ȣ, ename ����̸�, hiredate �Ի糯¥
from employee
where commission is null;

--<���� 2> dno (�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
select ename, job, hiredate
from employee
where dno = 20 and hiredate > '1981.04.01';

--<���� 3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
select eno �����ȣ, ename ����̸�, salary ����, commission ���ʽ�, (salary *12) + nvl(commission, 0) ��ü����
from employee;

--<���� 4> commission�� null�� �ƴ� ������� �̸��� ���
select ename
from employee
where commission is not null;

--<���� 5> manager (���޻��)7698 �� ����̸��� ��å�� ���.
select ename ����̸�, job ��å
from employee
where manager = 7698;

--<���� 6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸�, �Ի糯¥ , �μ���ȣ , ���� ���
select ename ����̸�, hiredate �Ի糯¥, dno �μ���ȣ, salary ����
from employee
where salary >= 1500 and dno = 20;

--<���� 7> �Ի糯¥�� 81�� 4�� 1�Ϻ��� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate between to_date('1981-04-01', 'yyyy-mm-dd')
                and to_date('1981-12-31', 'yyyy-mm-dd');
                
--<���� 8> ��å�� (job) salesman�̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���                
select ename ����̸�
from employee
where job = 'SALESMAN' and salary >=1500 and dno = 30;

--<���� 9> ������ 1500 �����̸鼭 �μ���ȣ�� 20���� �ƴ� ����̸��� ����, �μ���ȣ ���
select ename ����̸�, salary ����, dno �μ���ȣ
from employee
where salary <=1500 and dno != 20;


--<���� 10> �����ȣ (eno)�� 7788, 7782�� ����� �μ���ȣ�� �̸�, ��å ���
select ename ����̸�, job ��å, dno �μ���ȣ
from employee
where eno = 7788 or eno = 7782;


                
                














