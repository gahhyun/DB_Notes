--WITH문
--영화의 상영시간별로 SHORT, MEDIUM, LONG으로 나눔
select film_id , title , (case when length<30 then 'SHORT'
								when length>=30 and length <90 then 'MEDIUM'
								when length >90 then 'LONG'
						end )length 
from film 

--WITH문을 이용해서 앞선 집합을 TMP1으로 지정하고
--다른 SELECT문에서 CTE_FILE을 조회하기
with CTE_FILM as (

	select film_id , title , (case when length<30 then 'SHORT'
									when length>=30 and length <90 then 'MEDIUM'
									when length >90 then 'LONG'
							end )as length_SML , length  
	from film
)
--select * from TMP1 where length  = 'LONG';
select A.FILM_ID, A.TITLE, A.length_SML, A.LENGTH 
from CTE_FILM A
where length_SML = 'MEDIUM'
order by A.FILM_ID
;

--WITH절 + JOIN SQL 
--STAFF_ID별 RENTAL수를 조회하시오
with CTE_RENTAL as (
	select A.staff_id  , COUNT(A.staff_id) as RENTAL_CNT
	from rental A
	group by A.staff_id 
	)
select A.staff_id , B.first_name , B.last_name , A.RENTAL_CNT
from staff B join CTE_RENTAL as A
on B.staff_id  = A.staff_id 
order by A.staff_id 
;

--WITH절 + 원도우 함수
--FILM테이블을 조회하면서 윈도우함수 RANK을 사용하여 
--RATING별 LENGTH가 긴순으로 순위를 매긴다
with CTE_FILM as ( 
	select A.film_id , A.title , A.rating , A.length 
			, RANK() OVER(partition by A.rating order by A.length desc )as LENGTH_RANK
	from film A
)
select B.film_id, B.title, B.rating, B.length, B.LENGTH_RANK
from CTE_FILM B
where B.LENGTH_RANK = 1
;

--WITH절 + 게층형 SQL문
drop table if exists TB_EMP;
create table TB_EMP
(
	EMP_NO INT primary key ,
	EMP_NM VARCHAR(50) not null,
	DIRECT_MANAGER_EMP_NO INT,
	foreign key (DIRECT_MANAGER_EMP_NO) references TB_EMP(EMP_NO) on delete no action 
);
insert into TB_EMP values (1, '김회장', NULL);
insert into TB_EMP values (2, '박사장', 1);
insert into TB_EMP values (3, '송전문', 2);
insert into TB_EMP values (4, '이상무', 2);
insert into TB_EMP values (5, '정이사', 2);
insert into TB_EMP values (6, '최부장', 3);
insert into TB_EMP values (7, '정차장', 4);
insert into TB_EMP values (8, '김과장', 5);
insert into TB_EMP values (9, '오대리', 8);
insert into TB_EMP values (10,'신사원', 8);

--순방향 (위에서 아래로)전개
with recursive CTE_EMP as 
(
	select A.emp_no , A.emp_nm , A.DIRECT_MANAGER_EMP_NO, 1 as RNUM
	from tb_emp A
	where A.DIRECT_MANAGER_EMP_NO is null  --직속사원번호가 NULL인 경우로부터 시작, 기준이된다
	union 
	select B.emp_no , B.emp_nm , B.direct_manager_emp_no , A.RNUM+1 as RNUM
	from tb_emp B
	join CTE_EMP a 
	on b.direct_manager_emp_no = a.emp_no  
)
select emp_no ,
		lpad(emp_nm,rnum*4,' ') as emp_nm ,
		direct_manager_emp_no ,
		rnum
from CTE_EMP
;

--역방향 (아래서 위로) 전개
with recursive CTE_EMP as 
(
	select A.emp_no , A.emp_nm , A.DIRECT_MANAGER_EMP_NO, 1 as RNUM
	from tb_emp A
	where A.DIRECT_MANAGER_EMP_NO = 8  --직속사원번호가 NULL인 경우로부터 시작, 기준이된다
	union 
	select B.emp_no , B.emp_nm , B.direct_manager_emp_no , A.RNUM+1 as RNUM
	from tb_emp B
	join CTE_EMP a 
	on a.direct_manager_emp_no = b.emp_no  
)
select emp_no ,
		lpad(emp_nm,rnum*4,' ') as emp_nm ,
		direct_manager_emp_no ,
		rnum
from CTE_EMP
;











