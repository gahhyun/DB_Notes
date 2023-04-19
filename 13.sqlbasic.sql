--원도우 함수 : 결과집합 내에 행들간의 다양한 연산을 수행할 수 있음

drop table if exists tb_prdt;
drop table if exists tb_prdt_grp;

create table tb_prdt_grp
(
	prdt_grp_no int primary key,
	prdt_grp_nm varchar(100) not null
);

create table tb_prdt
(
	prdt_no int primary key,
	prdt_nm varchar(255) not null,
	prdt_prc numeric(15,2),
	prdt_grp_no int not null,
	foreign key (prdt_grp_no) references tb_prdt_grp(prdt_grp_no)
);
insert into tb_prdt_grp values (1, 'SmartPhone');
insert into tb_prdt_grp values (2, 'Laptop');
insert into tb_prdt_grp values (3, 'Tablet');

insert into tb_prdt values (1, 'iphone 14 pro', 1750000,1);
insert into tb_prdt values (2, 'galaxy 23', 1720400,1);
insert into tb_prdt values (3, 'xiaomi 13 pro', 1754100,1);
insert into tb_prdt values (4, 'pixel 7 pro', 1179069,1);
insert into tb_prdt values (5, 'macbook pro 14', 2790000,2);
insert into tb_prdt values (6, 'lg그램 style 35.5', 2490000,2);
insert into tb_prdt values (8, '갤럭시 북 2 15', 2490000,2);
insert into tb_prdt values (9, '레노버 silm 3', 1167670,2);
insert into tb_prdt values (10, 'ipad pro', 2490000,3);
insert into tb_prdt values (11, '갤럭시 탭 s8', 1608600,3);
insert into tb_prdt values (12, '레노버 y700', 1750000,3);

--집계함수 count()
--: 테이블의 전체 건수를 구함
select count(*) as cnt
from tb_prdt a 
;

--윈도우함수 count()
--:테이블 내용도 출력하서면서 전체 건수도 같이 구함
select a.*, count(*) over () as cnt
from tb_prdt a
order by a.prdt_no 
;

--집계함수 count() + group by 절
select a.prdt_grp_no  , count(*) as cnt
from tb_prdt a
group by a.prdt_grp_no 
order by a.prdt_grp_no 
;

--윈도우함수 count() + partition by 절
--: prdt_grp_no별 제품의 개수도 같이 구함
select a.*, count(*) over(partition by a.prdt_grp_no) as cnt
from tb_prdt a
order by a.prdt_no 
;

--집계함수 avg()
--테이블에서 prdt_prc 컬럼값의 평균을 구함
select round(avg(prdt_prc)) as avg_prdt_prc
from tb_prdt a
;

--윈도우 avg()
--테이블 내용도 출력하면서 prdt_prc 컬럼값의 평균도 같이 구함
select a.*, round(avg(a.prdt_prc) over(),2) as avg_prc   --2는 소수점 자리를 나타냄
from tb_prdt a
order by a.prdt_no 
;

--윈도우함수 avg() + group by 절
select a.prdt_grp_no , round(avg(a.prdt_prc),2) as avg_prc
from tb_prdt a
group by a.prdt_grp_no  
order by a.prdt_grp_no 
;

--윈도우함수 avg() + partition by 절
--테이블의 내용 출력하면서 prdt_grp_no컬럼별 prdt_prc의 평균도 같이 구함
select a.*, round(avg(a.prdt_prc) over(partition by a.prdt_grp_no ),2) as avg_prc  
from tb_prdt a
order by a.prdt_no 
;


--PRDT_PRC가 비싼 순으로 정렬
select A.prdt_no , A.prdt_nm , A.prdt_prc , B.prdt_grp_no , B.prdt_grp_nm 
from tb_prdt A, tb_prdt_grp B
where A.prdt_grp_no = B.prdt_grp_no 
order by A.prdt_prc  desc 
;

--RANK() ,DENSE_RANK(), ROW_NUMBER()를 이용하여 특정값 기준으로 행간에서의 등수를 구함
select A.prdt_no , A.prdt_nm , A.prdt_prc , B.prdt_grp_no , B.prdt_grp_nm 
		, RANK() OVER(order by A.prdt_prc DESC) as RANK_PRC
		, dense_rank() OVER(order by A.prdt_prc desc) as DENSE_RANK_PRC
		, ROW_NUMBER() OVER(order by A.prdt_prc desc) as ROW_NUMBER_PRC
from tb_prdt A, tb_prdt_grp B
where A.prdt_grp_no = B.prdt_grp_no 
order by A.prdt_prc  desc 
;














