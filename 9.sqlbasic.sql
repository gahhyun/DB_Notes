drop table if exists tb_accnt;
create table tb_accnt
(
	accnt_no int,
	acct_nm varchar(100) not null,
	ballance_amt numeric(15,2) not null,
	primary key(accnt_no)
);

select *
from tb_accnt;

commit;

insert into tb_accnt values (1, '일반계좌', 15000.45);
commit;

select *
from tb_accnt 
where accnt_no = 1
;

insert into tb_accnt values (2, '비밀계좌', 25000.45);
select * from tb_accnt 
where accnt_no = 2
;
rollback;

--------------------------------------------
--여러개의 sql문 전부 commit
drop table if exists tb_accnt;
create table tb_accnt
(
	accnt_no int,
	accnt_nm varchar(100) not null,
	ballance_amt numeric(15,2) not null,
	primary key(accnt_no)
);

insert into tb_accnt values (1, '일반계좌', 15000.45);
insert into tb_accnt values (2, '비밀계좌', 25000.45);

update tb_accnt set accnt_nm = '1번계좌' where  accnt_no = 1;
update tb_accnt set accnt_nm = '2번계좌' where  accnt_no = 2;

delete from tb_accnt where accnt_no = 2;
commit;

select * from tb_accnt;


--INSERT 문
drop table if exists TB_FILM_GRADE;
create table TB_FILM_GRADE
(
	FILM_GRADE_NO INT primary key,
	TITLE_NM VARCHAR not null,
	ERLEASE_TEAR INT,
	GRADE_RNK INT
);

insert into TB_FILM_GRADE values (1, '스즈메의 문단속', 2023, 1);
insert into TB_FILM_GRADE values (2, '대와비', 2023, 2);
insert into TB_FILM_GRADE values (3, '귀멸의 칼날', 2023, 3);

select * from tb_film_grade ;
commit;

insert into TB_film_grade values(4,'올 제인', 2023, 4)
returning *;

insert into tb_film_grade values(5,'6번 칸', 2023, 5)
returning TITLE_NM;

commit;


--update 문
drop table if exists TB_LINK;
create table TB_LINK
(
	LINK_NO INT primary key,
	URL VARCHAR(255) not null,
	LINK_NM VARCHAR(255) not null,
	DESCRPTN VARCHAR(255) not null,
	LAST_UPDATE_DE DATE
);
 commit;

insert into TB_LINK values
(1,'https://www.earth.com/', '지구사이트', '홈페이지',CURRENT_DATE);

commit;

select *
from TB_LINK;

insert into TB_LINK values
(2,'https://www.google.com/', '구글', '검색사이트',CURRENT_DATE)
returning *;

commit;

select * from TB_LINK;

insert into TB_LINK values
(3,'https://www.daum.net/', '다음', '포털사이트',CURRENT_DATE)
returning LINK_NO;

commit;

select * from TB_LINK;

update tb_link
set LINK_NM = '어스닷컴'
where LINK_NO =1;

commit;
select * from TB_LINK;

--update 하면서 UPDATE 한 행에서 LINK_NO 밒 LINK_NM 컬럼을 출력하세요
--다음 닷컴
update tb_link
set LINK_NM = '다음닷컴'
where LINK_NO =3
returning LINK_NO, LINK_NM;

commit;
select * from TB_LINK;

--update JOIN 문
drop table if exists TB_PRDT_CL;
drop table if exists TB_PRDT;
create table TB_PRDT_CL 
(
	PRDT_CL_NO INT primary key,
	PRDT_CL_NM VARCHAR(50),
	DISCOUNT_RATE NUMERIC(3,2)
);

insert into TB_PRDT_CL values (1, 'SMART PHONE', 0.20);
insert into TB_PRDT_CL values (2, 'SMART WATCH', 0.25);

create table TB_PRDT
(
	PRDT_NO INT primary key,
	PRDT_NM VARCHAR(50),
	PRC NUMERIC(15),
	SALE_PRC NUMERIC(15),
	PRDT_CL_NO INT,
	foreign key (PRDT_CL_NO) references TB_PRDT_CL(PRDT_CL_NO)
);

insert into TB_PRDT values (1, 'I PHONE 14 PRO',1550000, null,1 );
insert into TB_PRDT values (2, 'I PHONE 14',1250000, null,1 );
insert into TB_PRDT values (3, 'APPLE WATCH ULTRA',1149000, null,2 );
insert into TB_PRDT values (4, 'APPLE WATCH SERIES 8',599000, null,2 );

commit;

select * from TB_PRDT_CL;
select * from TB_PRDT;

--판매가격 = 가격 - (가격*할인률) 공식으로 판매가격(SALE_PRC)을 구하시오
--JOIN 과 UPDATE를 한 SQL문에서 동시에 처리해야 함

update tb_prdt a
set sale_prc = a.prc -(a.prc * b.discount_rate)
from tb_prdt_cl b
where a.prdt_cl_no = b.prdt_cl_no ;

commit;

select * from tb_prdt;

select a.* , b.*
from tb_prdt a , tb_prdt_cl b 
where a.prdt_cl_no = b.prdt_cl_no ;


--delete 문
drop table if exists TB_LINK;
create table TB_LINK
(
	LINK_NO INT primary key,
	URL VARCHAR(255) not null,
	LINK_NM VARCHAR(255) not null,
	DESCRPTN VARCHAR(255) not null,
	LAST_UPDATE_DE DATE
);

insert into TB_LINK values
(1,'https://www.earth.com/', '지구사이트', '홈페이지',CURRENT_DATE);
insert into TB_LINK values
(2,'https://www.google.com/', '구글', '검색사이트',CURRENT_DATE);
insert into TB_LINK values
(3,'https://www.daum.net/', '다음', '포털사이트',CURRENT_DATE);

commit;

select * from TB_LINK;

delete 
from tb_link A
where A.LINK_NM = '구글'
returning *		--특정 행을 delete한 다음에 delete된 행의 내용출력함
;
--rollback;

commit;

--UPSERT
drop table if exists TB_CUST;
create table tb_cust 
(
	CUST_NO INT ,
	CUST_NM VARCHAR(50)  unique ,
	EAMIL_ADRES VARCHAR(200) not null,
	VALID_YN CHAR(1) not null,
	constraint PK_TB_CUST primary key (CUST_NO)
);
commit;

insert into TB_CUST values (1, '이순신', 'Admiral@gmail.com', 'Y');
insert into TB_CUST values (2, '이방원', 'bwlee@gmail.com', 'Y');
commit;

select * from TB_CUST;

--ON CONFLICT ~ DO NOTHING
insert into TB_CUST (CUST_NO, CUST_NM, eamil_adres, valid_yn)
values (3, '이순신', 'SHLEE@GMAIL.COM', 'Y')
on conflict do nothing 
;
commit;
select *from TB_CUST;

--ON CONFLICT ~ DO UPDATE SET
--cust_no에 1은 이미 존재하는 행임, 중복되는 행을 인지한
insert into TB_CUST (CUST_NO, CUST_NM, eamil_adres, valid_yn)
values (1, '이순신', 'SHLEE@GMAIL.COM', 'N')
ON CONFLICT (CUST_NO) DO UPDATE set eamil_adres = excluded.eamil_adres, valid_yn = excluded.valid_yn;
commit;
select * from tb_cust;



--GROUP BY
/*
 * customer_id 컬럼의 값을 기준으로 GROUP BY함
 * 해당 컬럼값 기준으로 중복이 제거된 행이 출력됨
 */
select A.customer_id 
from payment A
group by A.customer_id 
order by A.customer_id 
;

-- customer_id 컬럼별 AMOUNT의 합계가 큰순으로 10건을 출력해주세여
select a.customer_id , sum(a.amount) as AMOUNT_SUM
from payment A
group by a.customer_id 
order by AMOUNT_SUM desc
limit 10
;

--FIRST_NAME 및 LAST_NAME도 같이 출력해주세요
--GROUP BY절에 있어야 select절에 넣을 수 있다
select a.customer_id , sum(a.amount) as AMOUNT_SUM ,B.first_name  ,B.last_name 
from payment A join customer B
--JOIN하면 ON(WHERE)으로 공통된 컬럼을 작성해 줘야 한다
on A.customer_id = B.customer_id 
group by a.customer_id ,B.first_name , B.last_name 
order by AMOUNT_SUM desc
limit 10
;

--카운트 구하기
select A.staff_id , COUNT(payment_id) as COUNT
from payment A
group by staff_id 
;

--CUSTOMER_ID가 FIRST_NAME 및 LAST_NAME을 결정지을 수 있는 관계이기 때문에
--MAX() 사용가능함
select a.customer_id , sum(a.amount) as AMOUNT_SUM ,MAX(B.first_name) ,MAX(B.last_name)
from payment A join customer B
--JOIN하면 ON(WHERE)으로 공통된 컬럼을 작성해 줘야 한다
on A.customer_id = B.customer_id 
group by a.customer_id ,B.first_name , B.last_name 
order by AMOUNT_SUM desc
limit 10
;

select first_name
from customer
order by first_name desc
;

select min(first_name)
from customer
;


--GROUP BY + HAVING
select customer_id , SUM(amount) as AMOUNT
from payment A
group by customer_id 
having SUM(amount) > 200			--SUM(AMOUNT)가 200을 초과하는 행을 출력
;

select store_id , COUNT(customer_id) as COUNT  --store_id기준 customer_id의 
from customer A
group by store_id 
having count(customer_id)>300 
;


--FIRST_NAME 및 LAST_NAME도 같이 출력해주세요
--AMOUNT의 합계가 200이상인 결과집합을 추출하세여
select a.customer_id , sum(a.amount) as AMOUNT_SUM ,B.first_name  ,B.last_name 
from payment A join customer B
on A.customer_id = B.customer_id 
group by a.customer_id ,B.first_name , B.last_name 
having SUM(A.amount) >= 200
order by AMOUNT_SUM desc
limit 10
;


--고객 기준으로 결제횟수가 40번 이상인 고객을 추출하세여 (COUNT())
select a.customer_id ,B.first_name  ,B.last_name,
		COUNT(A.payment_id)as COUNT
from payment A join customer B
on A.customer_id = B.customer_id 
group by a.customer_id ,B.first_name , B.last_name 
having  count(A.payment_id) >= 40 and sum(amount)>=200		--and, or 로 작성해야 한다
order by count  desc
limit 10
;



--INTERSECT
drop table if exists TB_FILM_GRADE;
create table TB_FILM_GRADE
(
	FILM_GRADE_NO INT primary key,
	TITLE_NM VARCHAR not null,
	RERLEASE_YEAR INT,
	GRADE_RNK INT
);

insert into TB_FILM_GRADE values (1, '스즈메의 문단속', 2023, 1);
insert into TB_FILM_GRADE values (2, '대와비', 2023, 2);
insert into TB_FILM_GRADE values (3, '귀멸의 칼날', 2023, 3);
insert into TB_FILM_GRADE values (4, '국제시장', 2014,4 );

select * from tb_film_grade ;

drop table if exists TB_FILM_ATTEDANCE;
create table TB_FILM_ATTEDANCE
(
	FILM_GRADE_NO VARCHAR not null,
	TITLE_NM VARCHAR not null ,
	RERLEASE_YEAR INT ,
	ATTEDANCE_RANK INT
);

insert into TB_FILM_ATTEDANCE values (1, '명량', 2014,1 );
insert into TB_FILM_ATTEDANCE values (2, '극한직업', 2019,2);
insert into TB_FILM_ATTEDANCE values (3, '신과함께', 2017,3 );
insert into TB_FILM_ATTEDANCE values (4, '국제시장', 2014,4 );

select * from TB_FILM_ATTEDANCE;

--INTERSECT 연산

select A.title_nm as "타이틀명" , A.rerlease_year as "출시년도"
from tb_film_grade A
intersect
select A.title_nm , A.rerlease_year 
from tb_film_attedance A
order by 타이틀명 desc 
;









