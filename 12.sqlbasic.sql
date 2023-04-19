--인라인 뷰 서브쿼리
/*
 * amount가 9.00를 초과하고 payment_date가 2007년 2월 15일 부터 19일 사이에 있는 결제내역을 조회
 * customer_id, first_name, last_name, amount, payment_date 
 */
select a.customer_id,a.first_name, a.last_name, b.amount, b.payment_date
from (
	select customer_id , amount, payment_date
	from payment x
	where x.amount >9.00 
	and x.payment_date between'2007-02-15 00:00:00.000000' and '2007-02-19 23:59:59.999999'
	)b ,customer a
where a.customer_id = b.customer_id
order by a.customer_id
;

--rental_rate가 평균보다 큰 집합을 추출
--film_id, title, rental_rate
select x.film_id , x.title, x.rental_rate 
from (--from절에 내에 있는 인라인 뷰
	  select avg(rental_rate) as avg_rental_rate  --집계함수 avg는 select에서 
	  from film 
)b , film x
where x.rental_rate > b.avg_rental_rate --평균은 2.8이다 
order by x.rental_rate  
;		

--스칼라 서브쿼리(select절에 서브쿼리가 있음)
/*
 * amount가 9.00를 초과하고 payment_date가 2007년 2월 15일 부터 19일 사이에 있는 결제내역을 조회
 * customer_id, first_name, last_name, amount, payment_date  
 * staff의 이름, 렌탈기간을 추출
 */
select a.customer_id,a.first_name, a.last_name, b.amount, b.payment_date, b.staff_id
	   , (select l.first_name ||' '|| l.last_name from staff L where L.staff_id= b.staff_id ) as staff_name
	   , (select R.rental_date||'~'||r.return_date from rental R where R.rental_id = b.rental_id) as rental_date
from (
	select customer_id , amount, payment_date, staff_id,rental_id 
	from payment x 
	where x.amount >9.00 
	and x.payment_date between'2007-02-15 00:00:00.000000' and '2007-02-19 23:59:59.999999'
	)b ,customer a
where a.customer_id = b.customer_id
order by a.customer_id
;

--스칼라 서브쿼리 활용
--rantal_rate 평균보다 큰 집합을 추출
--film_id, title, rental_rate 
select a.film_id, a.title, a.rental_rate
from ( --인라인뷰 안의 스칼라 서브쿼리
		select A.film_id, a.title, a.rental_rate,
				(select avg(L.rental_rate)  from film L ) as avg_rantal_rate
		from film A
	)a
where a.rental_rate > A.avg_rantal_rate
;






