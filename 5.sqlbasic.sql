--WHERE 절 --AND연산자
--FIRST_NAME이 'Tiffany'이고 LAST_NAME이 'Jordan'인 행을 출력하시오
select A.first_name ,A.last_name 
from customer A
where A.first_name = 'Tiffany' and A.last_name ='Jordan'
;

--WHERE 절 -- OR 연산자
select A.first_name ,A.last_name 
from customer A
where A.first_name = 'Micheal' or A.last_name ='Lee'
;

--WHERE 절 --<> 연산자
select A.first_name ,A.last_name
from customer A
where A.first_name <> 'Tiffany' and A.last_name <>'Jordan';

--WHERE 절 -- >연산자
--amount 컬럼의 값이 11.00보다 큰 행을 추출하시오
--(payment_id, amount, payment_date)
select p.payment_id , p.amount , p.payment_date 
from payment P
where p.amount > 11.00;

select p.payment_id , p.amount , p.payment_date 
from payment P
where p.amount <= 0.99;

--LIMIT 절
--file_id 기준으로 정렬한 후 정렬된 집합 중에서 5건만을 출력하세여
select A.film_id , A.title , A.release_year 
from film A
order by A.film_id 
limit 5
;

--LIMIT ~ OFFSET 사용
--file_id 기준으로 정렬한 후 정렬된 집합 중에서 2건만을 출력하세여
--출력하는 시작 행은 4번째 행부터 2건만을 출력하시오
select A.film_id ,A.title ,A.release_year 
from film A
order by A.film_id
offset 3
limit 2
;

--LIMIT 절 사용 -가장 최근에 렌탈한 10건을 조회해 주시오
-- rentak_date컬럼 기준으로 내림차순 정렬한 후 정렬된 집합 중에서 10건만 출력
select *
from rental A
order by a.rental_date desc
limit 10
;

--FETCH 절
select A.film_id ,A.title ,A.release_year 
from film A
order by A.film_id
fetch first 5 row only 
;

--LIMIT ~ OFFSET 사용
--file_id 기준으로 정렬한 후 정렬된 집합 중에서 5건만을 출력하세여
--출력하는 시작 행은 4번째 행부터 5건만을 출력하시오
--OFFSET 3 : 0,1,2,3 즉 4번째 행
select A.film_id ,A.title ,A.release_year 
from film A
order by A.film_id
offset 3 ROWS
fetch first 5 row ONLY
;

-- IN 연산자 사용
--CUSTOMER_ID가 1혹은 2인 행을 모두 리턴하시오
select a.customer_id , a.rental_id , a.rental_date 
from rental A
where a.customer_id =1 or A.customer_id =2  --where a.customer_id IN(1,2)
order by a.rental_date desc 
;


--NOT IN 연산자 사용
--CUSTOMER_ID가 1혹은 2인 아닌 행을 모두 리턴하시오
select a.customer_id , a.rental_id , a.rental_date 
from rental A
where a.customer_id not IN(1,2)
order by a.rental_date desc 
;

--"<>"연산자 + AND 조건으로 NOT IN과 동일한 집합 출력
select a.customer_id , a.rental_id , a.rental_date 
from rental A
where a.customer_id <>1 and A.customer_id <>2
order by a.rental_date desc 
;


--BETWEEN 연산자 사용
--AMOUNT가 10부터 11사이에 있는 행을 모두 리턴하시오
select A.customer_id , A.payment_id , A.amount 
from payment A
where A.amount  between 10 and 11
;


--NOT BETWEEN 연산자 사용
--AMOUNT가 10부터 11사이에 있지 않은 행을 모두 리턴하시오
select A.customer_id , A.payment_id , A.amount 
from payment A
where A.amount NOT between 10 and 11
;

--BETWEEN 연산자 사용 - 일자비교
--PAYMENT_DATE가 2007년 2월 14일의 모든 행을 출력하시오
select A.customer_id , A.payment_id , A.amount ,A.payment_date 
from payment A 
where A.payment_date between '2007-02-14 00:00:00.0000' and '2007-02-14 23:59:59.9999'
order by A.payment_date
;





























































