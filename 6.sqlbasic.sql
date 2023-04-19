--like 연산자 사용 -와일드 카드 % 사용
select a.customer_id , a.first_name , a.last_name 
from customer A
where first_name like 'Jen%'   --Jen으로만 시작하는 건 다 출력함
;

select a.customer_id , a.first_name , a.last_name 
from customer A
where first_name like '%enni%'   --enni가 들어가는 모든 행을 출력함
;


--like 연산자 사용 -와일드 카드 '_' 사용
select a.customer_id , a.first_name , a.last_name 
from customer A
where first_name like 'Jen___'   --Jen으로 시작하면서 글자수가 총6자리인 행을 다 출력함
;

--like 연산자 사용 -와일드 카드 '_%' 사용
select a.customer_id , a.first_name , a.last_name 
from customer A
where first_name like 'Jen__%'   --Jen으로 시작하면서 글자수가 총5자리 이상인 행을 다 출력함
;

-------------------------------------------------------------------------------------------------------
--NULL 비교
drop table if exists TB_CONTACT;
create table tb_contact 
(
	CONTACT_NO SERIAL primary key ,
	FIRST_NM VARCHAR(50) not NULL ,
	LAST_NAME VARCHAR(50) not null ,
	EMAIL_ADERS VARCHAR(255) not null ,
	PHONE_NUMBER VARCHAR(15)
);

insert into tb_contact (FIRST_NM,LAST_NAME, EMAIL_ADERS, PHONE_NUMBER )
values('순신', '이', 'ASMIRAL@GMAIL.COM', '010-1234-5678');
insert into tb_contact (FIRST_NM,LAST_NAME, EMAIL_ADERS, PHONE_NUMBER )
values('순신', '이', 'ASMIRAL@GMAIL.COM', NULL);
select * from tb_contact tc ;
select A.contact_no , A.first_nm , A.last_name , A.email_aders , A.phone_number 
from tb_contact A 
where A.phone_number is not null  --phone_number컬럼의 값이 NULL이 아닌 행을 리턴

------------------------------------------------------------------------------------------------------

--CASE 문
/*
 * 길이(LENGTH)가 50분 이하면 SHORT으로, 50분 초과하고 120분보다 작거나 같으면 MIDIUM, 120분 초과하면 LONG으로 표시하시오
 */
select A.title , A.length ,
		case when length >0 and length <= 50 then 'SHORT' 		--IF문과 유사함
			when length >50 and length <= 120 then 'MIDIUM'
			when length >120 then 'LONG'
		end DURATION 
from film A
order by A.
;

--길이(LENGTH)가 50분 이하면 1으로, 50분 초과하고 120분보다 작거나 같으면 2, 120분 초과하면 3으로 DESC정렬하시오
--CASE문 -- ORDER BY문에 사용
select A.title , A.length ,
		case when length >0 and length <= 50 then 'SHORT' 		--IF문과 유사함
			when length >50 and length <= 120 then 'MIDIUM'
			when length >120 then 'LONG'
		end DURATION 
from film A
order by case when length >0 and length <= 50 then 1
			  when length >50 and length <= 120 then 2
			  when length >120 then 3
		 end desc , A.title desc 
;

--CASE 연산자
select cast ('100' as INTEGER) as cast_AS_INTEGER;  --문자열->숫자

select cast('2023-03-09' as DATE) as "첫번째", CAST('09-Mar-2023' as DATE) as "두번째";

--CASE 실패
select  cast ('100C' as INTEGER) as cast_AS_INTEGER;  --CAST사용시 문자가 있으면 오류발생

select cast('2023-03-32' as DATE) as "첫번째"; 	 --유효한 일자가 아니므로 변환 실패

--실수형
select CAST('10.2' as DOUBLE PRECISION) as "첫번째";

select cast('십쩜이' as  DOUBLE PRECISION) as "두번째";  --변환 실패

--문자열을 INTERVAL형으로 형변환
select CAST('15 minute' as INTERVAL) as "첫번째" ,
	   CAST('2 hour' as INTERVAL) as "두번째" ,
	   CAST('2 day' as INTERVAL) as "세번째" ,
	   CAST('15 minute' as INTERVAL) as "네번째" ,
	   CAST('3 month' as INTERVAL) as "다섯번째"
;

select CAST('2023-03-09 11:05:30' as TIMESTAMP) - CAST('2 hour' as INTERVAL) as "첫번째";


--age 함수
--첫번째 인자값 - 두번째 인자값으로 시간(세월)의 차이를 리턴함
select age('2023-03-09', '2000-02-20') as "age('2023-03-09', '2000-02-20')" ,
	   age(current_date, '2000-02-20') as "age(current_date, '2000-02-20')" ,
	   age(current_timestamp, current_timestamp-cast('2 hour' as interval )) 
	   as "age(current_timestamp, current_timestamp-cast('2 hour' as interval ))"
;

--age() 함수 활용
--rental 테이블에서 대여시간이 가장 길었던 렌탈내역을 뽑아주세요
select A.rental_id , A.customer_id , AGE(A.return_date, A.rental_date) as DURATION
from rental A
where A.return_date is not null 
order by DURATION desc 
limit 10
;

--현재시간 정보 조회
select current_date 		--현재일자 리턴
		, current_time 		--현재시간 리턴(세꼐표준시간에서 9시간 플러스된 시간)
		, current_timestamp --현재일자와 시간 리턴
		, localtime(6) 		--현재 시간리턴
		, localtimestamp    --현재일자와 시간리턴 
		, now()				--현재일자와 시간리턴
		, now() + interval '1 day' --현재일자와 시간에 1을 더함
		, now() - interval '1 day 2 hours 30 minutes' -- 현재일자와 시간에
;


--일자 및 시간 추출 함수
select cast(date_part('year', current_timestamp) as varchar )
		--현재일시에서 연도를 추출한 후 varchar 타입으로 형변환 함
		, cast(date_part('month', current_timestamp) as varchar )
		--현재일시에서 월을 추출한 후 varchar 타입으로 형변환 함
		, cast(date_part('day', current_timestamp) as varchar )
		, cast(date_part('hour', current_timestamp) as varchar )
		, cast(date_part('minute', current_timestamp) as varchar )
		, cast(date_part('second', current_timestamp) as varchar )
		, cast(extract(year from current_timestamp) as varchar)
		, cast(extract(month from current_timestamp) as varchar)
		, cast(extract(week from current_timestamp) as varchar)
		, cast(extract(day from current_timestamp) as varchar)
		, cast(extract(hour from current_timestamp) as varchar)
		, cast(extract(minute from current_timestamp) as varchar)
		, cast(extract(second from current_timestamp) as varchar)
;


--문자열을 일자 및 시간형으로 형변환하는 함수
select to_date('20230309', 'YYYYMMDD')
		,to_date('2023-03-09', 'YYYY-MM-DD')
		,to_date('2023/03/09', 'YYYY/MM/DD')
		,to_timestamp('20230309120001', 'YYYYMMDDHH24MISS') 
		,to_timestamp('2023-03-09 12:00:01', 'YYYY-MM-DD HH24:MI:SS')
		,to_timestamp('2023/03/09 12/00/01', 'YYYY/MM/DD HH24/MI/SS')
;

--문자열 관련 함수
select ascii('A')		--문자'A'의 아스키코드값 리턴
		, chr('65')     --아스키코드 65의 문자를 리턴
		, concat('A','B', 'C') 	--문자열 합침 
		, concat_ws('|', 'A','B', 'C')   --문자열을 구분자로 구분하면서 합침
		, left ('ABC',1) 		--왼쪽에서 1번째 문자 리턴
		, right  ('ABC',1)		--오른쪽에서 1번째 문자 리턴
		, LENGTH ('ABC')		--문자열 길이 함수
		, LOWER ('ABC')			--소문자로 변경
		, upper('abc')			--대문자로 변경
		, lpad('123',6,'0')  	--총 6자리 문자열로 왼쪽에 0으로 채움
		, rpad('123',6,'0') 	--총 6자리 문자열로 오른쪽에 0으로 채움
		, ltrim(' 123')			--왼쪽에 있는 공백 제거
		, rtrim('123 ')			--오른쪽에 있는 공백 제거
		, trim('  123  ')		--양쪽에 있는 공백 제거 
		, repeat('*', 10)		--반복함
		, reverse('NEZE')  		--문자열을 거꾸로 출력함
		, substring('ABC',2,2)  --2번째 문자로부터 2개의 문자를 출력함
;

--반올림, 올림, 내림, 자름 관련 함수
select round(10.78, 0) as "round(10.78, 0)"	--0의 자리에서 반올림
		,round(10.78, 1)as "round(10.78, 1)" --소수점 첫번째 자리에서 반올림
		,round(10.781, 2)as "round(10.781, 2)" --소수점 두번째 자리에서 반올림
		,ceil (12.4)		--0의 자리에서 올림
		,ceil (12.8)
		,ceil (12.1)
		,ceil (12.0)		--0의 자리에서 올림해도 그대로 12가됨
		,floor(12.4) 		--버림 즉 내림
		,floor(12.8)
		,trunc(10.78,0)		--0의 자리에서 잘라서 10이됨
		,trunc(10.78,1)	 	--소수점 첫번째에서 잘라서 10.7이됨
		,trunc(10.78,2)		--소수점 두번째에서 잘라서 10.78이됨
;

--연산 관련 함수
select abs(-10)		--절댓값
		,sign(-3)
		,sign(0)
		,div(9,2)	 --9나누기4 몫 4 리턴
		,mod (9,2)	 --나머지 1 리턴
		,log(10,1000)
		,log(2,8)
		,power(2,3)
		,sqrt(2)
		,sqrt(4)
		,random() 
		,pi()
		,degrees(1) 





















