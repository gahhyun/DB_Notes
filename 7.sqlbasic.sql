--고객 중 결재 내역이 있는 고객의 고객정보 및 결재내역을 출력하세여
--ANST 표준방식의 INNER JOIN
select A.customer_id , A.first_name , A.last_name 
		,B.amount, B.payment_date  
from customer A join payment B 
on A.customer_id = B.customer_id 
order by B.payment_date 
;

select A.customer_id , A.first_name , A.last_name 
		,B.amount, B.payment_date  
from customer A, payment B 
where A.customer_id = B.customer_id 
order by B.payment_date  
;

--고객중 customer_id가 2인 고객의 고객정보와 결제내역을 출력하세요
select A.customer_id , A.first_name , A.last_name 
		, B.amount ,B.payment_date 
from customer A join payment B 
ON A.customer_id = B.customer_id
where A.customer_id =2      --조건절을 추가
order by B.payment_date 
;

select A.customer_id , A.first_name , A.last_name 
		,B.amount, B.payment_date  
from customer A, payment B 
where A.customer_id = B.customer_id and A.customer_id =2
order by B.payment_date  
;


--고객중 customer_id가 2인 고객의 고객정보와 결제내역을 출력하먄서
--해당 결제를 수행한 스탭의 정보까지 같이 출력해 주시오
--3개 테이블 조인 

select a.customer_id , a.first_name as customer_first_name, a.last_name as customer_last_name ,
		b.amount, b.payment_date , c.staff_id , c.first_name, c.last_name
from customer A
join payment b
on a.customer_id = b.customer_id 
join staff C
on b.staff_id = c.staff_id 
where a.customer_id = 2
order by b.payment_date 
;


select a.customer_id , a.first_name as customer_first_name, a.last_name as customer_last_name ,
		b.amount, b.payment_date , c.staff_id , 
		c.first_name, c.last_name
from customer A, payment b, staff C 
where a.customer_id = 2
and a.customer_id = b.customer_id
and b.staff_id = c.staff_id 
order by b.payment_date 
;











































