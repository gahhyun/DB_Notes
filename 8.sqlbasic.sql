--LEFT (OUTER) JOIN
--LEFT쪽 집합은 모두 출력하고 RIGHT쪽 집합은 매칭되는 것만 출력하는 조인 연산 방식임

-- film 테이블이 LEFT(왼쪽)에 위치 => film 테이블의 내용은 모두 나옴
--inventory 테이블은 RIGHT (오른쪽)에 위치 => 매칭되는 것만 나옴

select a.film_id , a.title , b.inventory_id 
from film A
left outer join inventory b
on a.film_id = b.film_id 
order by a.title 
;


--SELF JOIN----------------------------------------------------------
drop table if exists TB_EMP;
create table TB_EMP 
(
	EMP_NO INT primary key ,
	EMP_NM VARCHAR(50) not null,
	DIRECT_MANAGER_EMP_NO INT,
	foreign KEY(DIRECT_MANAGER_EMP_NO)
	references TB_EMP(EMP_NO) on delete no ACTION
	
);

insert into tb_emp values (1, '김회장', NULL);
insert into tb_emp values (2, '박사장', 1);
insert into tb_emp values (3, '송전무', 2);
insert into tb_emp values (4, '이상무', 2);
insert into tb_emp values (5, '정이사', 2);
insert into tb_emp values (6, '박부장', 3);
insert into tb_emp values (7, '정차장', 3);
insert into tb_emp values (8, '김과장', 4);
insert into tb_emp values (9, '오대리', 8);
insert into tb_emp values (10, '신사원', 8);

select *
from tb_emp te ;

--모든 직원을 출력하면서 직속상사의 이름을 출력하시오(null허용 따라서 outer join)
select a.emp_no , a.emp_nm , b.emp_nm as direct_manager_no 
from tb_emp A
left join tb_emp b 
on a.direct_manager_emp_no = b.emp_no 
;


--title 이름은 다르지만 상영시간이 동일한 film에 대한 정보를 출력하시오
select a.title ,b.title ,a.length 
from film a
join film b 
on a.length = b.length 
and a.title  <> b.title 
;

--FULL OUTER JOIN 
drop table if exists TB_DEPT;
--아직 어떠한 사원도 존재하지 않는 4차산업지원팀이 있음
create table TB_DEPT
(
	DEPT_NO INT primary key,
	DEPT_NM VARCHAR(100)
);

insert into TB_DEPT values (1, '회장실');
insert into TB_DEPT values (2, '경영지원본부');
insert into TB_DEPT values (3, '영업부');
insert into TB_DEPT values (4, '개발1팀');
insert into TB_DEPT values (5, '개발2팀');
insert into TB_DEPT values (6, '4차산업지원팀');

select *
from TB_DEPT;

drop table if exists TB_EMP;
--아직 부서 배정을 받지 못한 '송인턴' 직원이 있음
create table tb_EMP 
(
	EMP_NO INT primary key,
	EMP_NM VARCHAR(50) not null,
	DEPT_NO INT ,
	foreign key (DEPT_NO) references TB_DEPT(DEPT_NO)
);

insert into tb_emp values (1, '김회장', 1);
insert into tb_emp values (2, '박사장', 1);
insert into tb_emp values (3, '송전무', 2);
insert into tb_emp values (4, '이상무', 2);
insert into tb_emp values (5, '정이사', 2);
insert into tb_emp values (6, '박부장', 3);
insert into tb_emp values (7, '정차장', 3);
insert into tb_emp values (8, '김과장', 4);
insert into tb_emp values (9, '오대리', 4);
insert into tb_emp values (10, '신사원', 5);
insert into tb_emp values (11, '송인턴', NULL);

select *
from TB_EMP;
----------------------------------------------
select A.emp_no , A.emp_nm , A.dept_no ,
		B.dept_no , B.dept_nm 
from tb_emp A
full outer join tb_dept B
on A.dept_no =B.dept_no ;

--오른쪽에만 존재하는 형
--직원없는 부서를 출력하세요
select A.emp_no , A.emp_nm , A.dept_no ,
		B.dept_no , B.dept_nm 
from tb_emp A
full outer join tb_dept B
on A.dept_no =B.dept_no 
where A.emp_nm is NULL;

--왼쪽에만 존재하는 행
--부서없는 직원을 출력하세여
select A.emp_no , A.emp_nm , A.dept_no ,
		B.dept_no , B.dept_nm 
from tb_emp A
full outer join tb_dept B
on A.dept_no =B.dept_no 
where B.dept_nm is NULL;

--CROSS JOIN
drop table if exists T1;
create table T1
(
	COL_1 CHAR(1) primary key
);

drop table if exists T2;
create table T2
(
	COL_2 INT primary key
);

insert into T1 (COL_1) values ('A');
insert into T1 (COL_1) values ('B');
insert into T1 (COL_1) values ('C');
insert into T2 (COL_2) values ('1');
insert into T2 (COL_2) values ('2');
insert into T2 (COL_2) values ('3');

select *
from T1
;
select *
from T2
;

select *
from T1 A
cross join T2 B 
order by A.COL_1, B.COL_2
;
--||--
select *
from T1 A, T2 B
order by A.COL_1, B.COL_2
;
















