--COUNT(*)
--PAYMENT 테이블의 건수를 조회하시오
select COUNT(*) as CNT
from payment A
;

drop table if exists TB_COUNT_TEST;
create table TB_COUNT_TEST
(
	TB_COUNT_NO INT primary key,
	TB_COUNT_NM VARCHAR(50) not NULL
);
select * from tb_count_test ;
select COUNT(*)
from tb_count_test tct 
;

--PAYMENT 테이블에서 CUSTOMER_ID별 건수를 구하시오
select A.customer_id , COUNT(A.customer_id)
from payment A
group by A.customer_id 
;

select *
from payment A
where customer_id = 184
;

--AMOUNT 값 중 유일한 값만 출력하시오
select distinct A.amount 
from payment A
order by amount 
;

--AMOUNT 컬럼값의 유일한 값의 개수를 리턴
select COUNT(distinct A.amount)   --distinct는 중복값을 제거한다
from payment A
;

--PAYMENT 테이블에서 CUSTOMER_ID별 AMOUNT컬럼의 유일값의 개수를 리턴하시오
select customer_id , COUNT(distinct A.amount)
from payment A
group by A.customer_id 
;

--PAYMENT 테이블에서 CUSTOMER_ID별 AMOUNT컬럼의 유일값의 개수를 리턴하시오
--AMOUNT 컬럼의 유일값의 개수가 11이상인 행들만 출력하시오
select customer_id , COUNT(distinct A.amount) 
from payment A
group by A.customer_id 
having COUNT(distinct A.amount) >= 11
order by COUNT
;

--PAYMENT 테이블에서 최대, 최소 AMOUNT값을 리턴
select MAX(A.amount) as MAX_AMOUNT, MIN(A.amount) as MIN_AMOUNT
from payment A
;

--PAYMENT 테이블에서 CUSTOMER_ID별 최대, 최소 AMOUNT값을 리턴
select A.customer_id , MAX(A.amount) as MAX_AMOUNT, MIN(A.amount) as MIN_AMOUNT
from payment A
group by A.customer_id 
order by A.customer_id 
;


--PAYMENT 테이블에서 CUSTOMER_ID별 최대, 최소 AMOUNT값을 리턴
--그 중 최대 AMOUNT값이 11.00보다 큰 집합을 리턴
select A.customer_id , 
		MAX(A.amount) as MAX_AMOUNT, 
		MIN(A.amount) as MIN_AMOUNT
from payment A
group by A.customer_id 
having MAX(A.amount) > 11.00
order by A.customer_id 
;

drop table if exists TB_MAX_MIN_TEST;
create table TB_MAX_MIN_TEST
(
	TB_MAX_MIN_NO CHAR(6) primary key,
	MAX_AMOUNT NUMERIC(15,2),
	MIN_AMOUNT NUMERIC(15,2)
);

insert into TB_MAX_MIN_TEST values ('100001', 100.52, 11.49);

--공집합과 MAX()함수  => NULL나옴
--NULL이라면 문구를 지정해서 출력 => coalesce()
--coalesce함수 : 첫번째 인자의 표현식이 null이라면 두번째 인자 문자열로 출력
--COALESCE(VALUE, EX1, EX2, ...)
--    - 첫 번째로 명시된 인자가 NULL일 경우 두 번째 인자 반환
 --     두 번째 인자가 NULL일 경우 세 번째 인자를 반환
select  coalesce(MAX(TB_MAX_MIN_NO), '없음')
from TB_MAX_MIN_TEST
where TB_MAX_MIN_NO = '100002'
;

--AVG, SUM 함수
--PAYMENT 테이블에서 AMOUNT의 평균값과 AMOUNT의 합계값을 구하시오
--round(): 반올림 함수
select round(avg(A.amount),2),ROUND(sum(A.amount),2)  
from payment A
;


select A.customer_id ,round(avg(A.amount),2) as AVG ,ROUND(sum(A.amount),2) as SUM
from payment A
group by A.customer_id 
having avg(A.amount) >= 5.00
order by SUM desc 
;

--COUSTOM_ID, FIRST_NAME, LAST_NAME별 AMOUNT평균값과 합계값을 구하시오
select A.customer_id , B.first_name , B.last_name ,
		AVG(A.amount)as VAG, sum(A.amount)as SUM 
from payment A join customer B 
ON A.customer_id = B.customer_id 
group by A.customer_id,B.first_name , B.last_name 
having avg(A.amount) >= 5.00
order by SUM desc
;

--VAG, SUM, NULL
drop table if exists TB_AVG_SUM_TEST;
create table TB_AVG_SUM_TEST
(
	AVG_SUM_TEST_NO CHAR(6) primary key,
	AVG_AMOUNT NUMERIC(15,2),
	SUM_AMOUNT NUMERIC(15,2)
);

insert into TB_AVG_SUM_TEST values ('100001', 100.00, 10.00);
insert into TB_AVG_SUM_TEST values ('100002', 100.00, 20.00);
insert into TB_AVG_SUM_TEST values ('100003', 100.00, 30.00);
insert into TB_AVG_SUM_TEST values ('100004', NULL, 10.00);
insert into TB_AVG_SUM_TEST values ('100005', 200.00, NULL);
insert into TB_AVG_SUM_TEST values ('100006', NULL, NULL);
--평균을 구할 때 전체 합계를 4로 나눔(6으로 나누지 않음)
--NULL인 행은 평균을 구할 때 대상에 포함하지 않음
--합계(SUM)를 구할 때도 NULL인 행은 합계를 구하는 대상에 포함하지 않음
select ROUND(AVG(avg_amount),2) as AVG, ROUND(sum(sum_amount),2)as SUM
from TB_AVG_SUM_TEST
;

select 100=null;
select AVG_AMOUNT + SUM_AMOUNT
from tb_avg_sum_test tast 
;


























