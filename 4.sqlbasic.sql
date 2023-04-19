--customer테이블에서 first_name 컬럼을 조회하시오.
--select 문의 끝이 ;으로 끝남
select first_name 
from customer c ;

--customer테이블에서 first_name, last_name, email 컬럼을 조회하시오.
select first_name, last_name, email
from customer c ;


--customer테이블이 가지고 있는 모든 컬럼을 조회하시오.
select  *
from customer c ;

--" || "를 이용해서 first_name컬럼과 last_name컬럼의 문자열을 결합하여 출력하시오
select  first_name ||' '||last_name as first_last_name , email  
from customer c ;

-- select문을 이용한 계산
select (((5*3)/5)+2)*2 as calc;


-- select  distinct  절
drop table if exists TB_DISTINCT_TEST;
create table TB_DISTINCT_TEST
(
	distinct_test_no serial not null primary key 
	, back_color varchar
	, fore_color varchar
);

insert into tb_distinct_test (back_color, fore_color) values ('red', 'red');
insert into tb_distinct_test (back_color, fore_color) values ('red', 'red');
insert into tb_distinct_test (back_color, fore_color) values ('red', null);
insert into tb_distinct_test (back_color, fore_color) values (null, 'red');
insert into tb_distinct_test (back_color, fore_color) values ('blue', 'blue');
insert into tb_distinct_test (back_color, fore_color) values ('blue', 'blue');
insert into tb_distinct_test (back_color, fore_color) values (null, 'blue');
insert into tb_distinct_test (back_color, fore_color) values ('blue', null);
insert into tb_distinct_test (back_color, fore_color) values ('red', 'blue');
insert into tb_distinct_test (back_color, fore_color) values ('blue', 'red');


-- select 절 - 컬럼1개 조회
-- 중복된 컬럼의 값이 모두 출력되고 있음
select back_color
from tb_distinct_test tdt ;


--select distinct 절
--중복이 제거된 유일한 값인 red, blue가 출력되고 null도 출력됨
select distinct back_color
from tb_distinct_test tdt ;


-- select 절 - 컬럼2개 조회
-- 중복된 컬럼의 값이 모두 출력되고 있음
select back_color , fore_color
from tb_distinct_test tdt ;


--select distinct 절 - 컬럼2개 조회
--2개 컬럼 조합 기준 중복된 형이 제거 된 집합이 출력된 것임
select distinct back_color , fore_color
from tb_distinct_test tdt ;



-- as사용
select A.customer_id as customer_id , 
	   a.first_name ||' '||a.last_name as "full name" ,
	   a.email as 이메일
from customer as A;


--ORDER BY - 1개 컬럼 - ASC(오름차순) 정렬
--first_name 컬럼의 값을 기준으로 오름차순 정렬함
select a.customer_id , a.first_name  , a.last_name 
from customer as A
order by a.first_name asc;

--ORDER BY - 1개 컬럼 - EESC(내림차순) 정렬
--first_name 컬럼의 값을 기준으로 내림차순 정렬함
select a.customer_id , a.first_name  , a.last_name 
from customer as A
order by a.first_name DESC;


--ORDER BY절 -2개 컬럼 - DESC(내림차순) + ASC(오름차순) 정렬
/*
 * first_name 컬럼의 값을 기준으로 내림차순 정렬 한 후
 * 그 상태에서 last_name 컬럼의 값을 기준으로 오름차순 정렬함
 * -> 동일한 first_name이 존재하는 경우 last_name 기준으로 오름차순 정렬되는 것
 */
select a.customer_id , a.first_name  , a.last_name 
from customer as A
order by a.first_name desc, A.last_name ASC;


--ORDER BY절 --LAST_NAME의 길이가 긴 행이 가장 위로 올라가게 정렬하세여
--해당 AS가 출력하는 값을 기준으로 내림차순 정렬
select A.customer_id , A.first_name , LENGTH(A.last_name) as LENGTH_LAST_NAME, A.last_name 
from customer as A
order by LENGTH_LAST_NAME desc;


--ORDER BY 절 -- select 절 컬럼 기재 순서를 기재하여 정렬
select A.customer_id , A.first_name , LENGTH(A.last_name) as LENGTH_LAST_NAME, A.last_name 
from customer as A
order by 3 desc; -- select 절에서 3번째로 기재한 컬럼


--ORDER BY절 -- NULLS FIRST, NULLS LAST
drop table if exists TB_SORT_TEST;
create table TB_SORT_TEST
(
	NUM INT
);
insert into tb_sort_test values(1);
insert into tb_sort_test values(2);
insert into tb_sort_test values(3);
insert into tb_sort_test values(NULL);

select *
from tb_sort_test tst 
order by NUM DESC nulls first --NULL이 무조건 맨 위로 올라가게 됨
;							  --NULL이 아닌 값을 대상으로 DESC정렬함

select *
from tb_sort_test tst 
order by NUM DESC nulls last  --NULL이 무조건 맨 아래오 내려가게 됨
;							  --NILL이 아닌 값을 대상으로 DESC정렬함































