--film 테이블에서 길이가 가장 긴 길이의 값은 얼마인가요
select max(a.length) as max_length
from film a
;

--영화 길이가185인 영화의 정보를 조회하시오
select a.film_id , a.title ,a.description , a.release_year , a.length 
from film a
where a.length =185
order by a.title 
;

--서브쿼리 (비교연산자)
--길이가 가장 긴 영화들에 대한 정보를 조회하시오
select a.film_id , a.title ,a.description , a.release_year , a.length
from film a
where a.length = (
			select max(a.length) as max_length
			from film a
)
order by a.title 
;

--영화들의 평균길이보다 크거나 같은 영화들의 리스트를 출력하시오
select a.film_id , a.title ,a.description , a.release_year , a.length
from film a
where a.length >= (
			select avg(a.length) as avg_length  --115.27
			from film a
)
order by a.title 
;

--rental_rate 평균보다 큰 집합을 추출하세여
--film_id, title, rental_rate
select avg(a.rental_rate)
from film a
;

select a.film_id , a.title , a.rental_rate 
from film a
where rental_rate > (
			select (avg(a.rental_rate)) as avg  --평균 3
			from film a
)
order by rental_rate  
;



--서브쿼리(IN연산자)
--반납일자가 2005년 5월29일인 렌탈 내역의 FILM_ID를 조회하시오
--INNER JOIN
select b.film_id 
from rental a
inner join inventory b 
on a.inventory_id = b.inventory_id 
where a.return_date between '2005-05-29 00:00:00.000000'
					and  '2005-05-29 23:59:59.999999'
;
--메인쿼리 밑에(하위에) 존재하는 퀴리를 (중첩)서브쿼리라고 하고, IN연산자로 연산을 수행함
--반납일자가 2005년 5월29일인 렌탈 내역의 film_id 기준으로 film테이블 정보를 출력하시오
select c.film_id , c.title
from film c
where c.film_id in (
			select b.film_id 
			from rental a
			inner join inventory b 
			on a.inventory_id = b.inventory_id 
			where a.return_date between '2005-05-29 00:00:00.000000'
								and  '2005-05-29 23:59:59.999999'
								)
order by c.title 
;

select a.customer_id , a.rental_id , a.return_date 
from rental a
where customer_id in (1,2)
order by return_date desc 
;

--서브쿼리 (EXISTS연산자)
--AMOUNT가 9.00을 초과하고(AND) PAYMENT_DATE가 2007년 2월15일부터 2007년 2월19일 사이에 있는
--결제내역이 존재하는 고객의 이름을 출력하세요
select A.customer_id , A.first_name , A.last_name 
from customer A
where exists (
			select 1 --TRUE(SELECT에서 1은 TRUE 이다)
			from payment X
			where X.customer_id = A.customer_id 
			and X.amount >9.00
			and X.payment_date between '2007-02-15 00:00:00.000000' and '2007-02-19 23:59:59.999999'
)
order by A.first_name 
;


--서브쿼리 (EXISTS연산자)
--AMOUNT가 9.00을 초과하고(AND) PAYMENT_DATE가 2007년 2월15일부터 2007년 2월19일 사이에 있는
--결제내역이 존재하지 않는 고객의 이름을 출력하세요
select A.customer_id , A.first_name , A.last_name 
from customer A
where not exists (
			select 1 --TRUE(SELECT에서 1은 TRUE / 0은 FALSE)
			from payment X
			where X.customer_id = A.customer_id 
			and X.amount >9.00
			and X.payment_date between  '2007-02-15 00:00:00.000000' and '2007-02-19 23:59:59.999999'
)
order by A.first_name 
;

--고객중에서 11달러 초과한 지불내열이 있는 고객을 추출하세요
select a.first_name , a.last_name , a.customer_id
from customer a
where exists (
			select  1
			from payment b
			where a.customer_id = b.customer_id 
			and b.amount > 11
);

--NOT EXISTS
--고객중에서 11달러 초과한 지불내열이 없는 고객을 추출하세요
select a.first_name , a.last_name , a.customer_id
from customer a
where not exists (
			select  1
			from payment b
			where a.customer_id = b.customer_id 
			and b.amount > 11
)
order by first_name , last_name ;


--재고가 없는 영화를 추출하시오 (EXCEPT)
select  A.film_id , A.title 
from film A
except 
select B.film_id , A.title  
from inventory B join film A
on A.film_id = B.film_id 
order by title 
;

--except 연산을 사용하지 않고 같은 결과를 도출하시오
select a.film_id , a.title 
from film a
where not except (
			select 1
			from inventory b, film c
			where b.film_id = c.film_id 
			and b.film_id = c.film_id 
);















