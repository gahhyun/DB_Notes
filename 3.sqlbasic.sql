--테이블 생성 + 기본키 지정
create table tb_user 
(
	user_no int
	, user_nm varchar(50) not null
	, birth_de date not null
	, addrs varchar(200) 
	, primary key(user_no)  --테이블을 생성하면서 기본키로 지정
);							--user_no 컬럼으로 이루어진 인덱스도 자동으로 생성됨

--테이블 생성 + 기본키 지정 + 제약조건명 정의
drop table if exists tb_user;

create table tb_user
(
	user_no int
	, user_nm varchar(50) not null
	, birth_de date not null
	, addrs varchar(200) 
	, constraint pk_tb_user primary key(user_no)	--기본키 제약조건의 제약조건명 이름을 지어줌
);

--테이블 생성 -> 기본키 지정
drop table if exists tb_user;
create table tb_user
(
	user_no int;
	, user_nm varchar(50) not null
	, birth_de date not null
	, addrs varchar(200)
);
alter table tb_user ass primary key(user_no);

--테이블 생성 -> 데이터 입력 -> SERIAL 형식의 기본키 추가
create table tb_vendor
(
	vendor_nm varchar(255)
);

insert into tb_vendor (vendor_nm) values ('삼성전자');
insert into tb_vendor (vendor_nm) values ('TSMC');
insert into tb_vendor (vendor_nm) values ('하이닉스');
insert into tb_vendor (vendor_nm) values ('마이크론');
insert into tb_vendor (vendor_nm) values ('웰컴');
insert into tb_vendor (vendor_nm) values ('브로드컴');

select * from tb_vendor  tv;

--serial 형식으로 기본키로 지정
--기존에 있는 행(데이터)들에게 자동으로 ,순차적으로 번호를 부여하게 됨
alter table tb_vendor add column vendor_id serial primary key;

--기본키 제약조건을 제거했지만  컬럼 및 데이터값은 그대로 존재함
alter table tb_vendor drop constraint tb_vendor_pkey;

------------------------------------------------------------------
--부모/자식 테이블 생성 및 외래키 생성 옵션 - NO ACTION
create table TB_CUST
(
	CUST_NO INT
	, CUST_NM VARCHAR(255) not null
	, primary KEY(CUST_NO)
);

drop table if exists TB_CONTACT;
create table TB_CONTACT(
CONTACT_NO INT
, CONTACT_TYP_CD CHAR(6) not null --'CTC001':전화번호, 'CTC002':주소 //코드화
, CONTACT_INTO VARCHAR(100)
, CUST_NO INT  --부모테이블의 기본키(참조)
, primary key(CONTACT_NO)
, constraint FK_CUST_NO_TB_CUST foreign key (CUST_NO) references TB_CUST(CUST_NO) on delete no action 
														--자식을 가지고 있는 부모테이블의 행을 삭제하려고 하면 삭제 못하게 하는 것
);
--부모테이블에 데이터 입력
insert into tb_cust (CUST_NO, CUST_NM)
values (1,'이순신');
insert into tb_cust (CUST_NO, CUST_NM)
values (2,'이방원');
select *from tb_cust tc ;

--자식테이블에 데이터 입력
insert  into tb_contact (CONTACT_NO, CONTACT_TYP_CD, CONTACT_INTO, CUST_NO)
values (1, 'CTC001','010-1234-0154',1);
insert  into tb_contact (CONTACT_NO, CONTACT_TYP_CD, CONTACT_INTO, CUST_NO)
values (2, 'CTC002','DDS@GMAIL.COM',1);

--SQL Error [23503]: 오류: "tb_contact" 테이블에서 자료 추가, 갱신 작업이 "fk_cust_no_tb_cust" 참조키(foreign key) 제약 조건을 위배했습니다
--Detail: (cust_no)=(3) 키가 "tb_cust" 테이블에 없습니다.
--insert  into tb_contact (CONTACT_NO, CONTACT_TYP_CD, CONTACT_INTO, CUST_NO)
--values (3, 'CTC002','DDS@GMAIL.COM',3);

insert  into tb_contact (CONTACT_NO, CONTACT_TYP_CD, CONTACT_INTO, CUST_NO)
values (3, 'CTC001','010-1258-0154',2);
insert  into tb_contact (CONTACT_NO, CONTACT_TYP_CD, CONTACT_INTO, CUST_NO)
values (4, 'CTC002','jghg@GMAIL.COM',2);

-- 부모 테이블에서 데이터 삭제 시도 - no ACTION
/*
 * 자식 테이블인 tb_contact에 cust_no 컬럼의 값 1인 데이터 행이
 * 존재하기 때문에 
 * 부모 테이블인 tb_cust에서 cust_no가 1인 행은 삭제 불가능.
 */
delete from tb_cust where cust_no = 1;

--------------------------------------여기서부터 공부해야함
-- 외래키 생성 옵션 - set null 
drop table if exists tb_contact;
drop table if exists tb_cust;

create table TB_CUST
(
	CUST_NO	INT
	, CUST_NM VARCHAR(255) not null
	, primary KEY(CUST_NO)
);

create table TB_CONTACT
(
	CONTACT_NO	INT
	, CONTACT_TYP_CD	CHAR(6) not null	-- 'CTC001' : 전화번호, 'CTC002' : 이메일주소
	, CONTACT_INTO	VARCHAR(100)
	, CUST_NO 	INT 
	, primary KEY(CONTACT_NO)
	, constraint FK_CUST_NO_TB_CUST foreign KEY(CUST_NO)
	  references TB_CUST(CUST_NO) on delete set null
);	-- set null 옵션은 자식을 가지고 있는 부모행을 삭제하려고 하면
	-- 자식행의 값을 null로 셋팅함 

-- 부모 테이블에 데이터 입력
insert into tb_cust (cust_no, cust_nm)
	values (1, '이순신');
insert into tb_cust (cust_no, cust_nm)
	values (2, '이방원');
select * from tb_cust tc  ;

-- 자식 테이블에 데이터 입력
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (1, 'CTC001', '010-2341-4541', 1);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (2, 'CTC002', 'AdmiralYi@gmail.com', 1);

insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (3, 'CTC001', '010-7777-5555', 2);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (4, 'CTC002', 'bwlee@gmail.com', 2);

-- 부모 테이블에서 데이터 삭제 시도 - set null 
/*
	부모 테이블인 tb_cust의 cust_no가 1인 행이 삭제됨.
	자식 테이블인 tb_contact에서 cust_no가 1인 행의 cust_no 컬럼의
	컬럼값은 null로 셋팅됨.
 */
delete from tb_cust where cust_no = 1;

-- 외래키 생성 옵션 - cascade
drop table if exists tb_contact;
drop table if exists tb_cust;

create table TB_CUST
(
	CUST_NO	INT
	, CUST_NM VARCHAR(255) not null
	, primary KEY(CUST_NO)
);

create table TB_CONTACT
(
	CONTACT_NO	INT
	, CONTACT_TYP_CD	CHAR(6) not null	-- 'CTC001' : 전화번호, 'CTC002' : 이메일주소
	, CONTACT_INTO	VARCHAR(100)
	, CUST_NO 	INT 
	, primary KEY(CONTACT_NO)
	, constraint FK_CUST_NO_TB_CUST foreign KEY(CUST_NO)
	  references TB_CUST(CUST_NO) on delete cascade
);	-- cascade 옵션은 자식을 가지고 있는 부모행을 삭제하려고 하면
    -- 자식행도 삭제해 버림
	

-- 부모 테이블에 데이터 입력
insert into tb_cust (cust_no, cust_nm)
	values (1, '이순신');
insert into tb_cust (cust_no, cust_nm)
	values (2, '이방원');
select * from tb_cust tc  ;

-- 자식 테이블에 데이터 입력
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (1, 'CTC001', '010-2341-4541', 1);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (2, 'CTC002', 'AdmiralYi@gmail.com', 1);

insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (3, 'CTC001', '010-7777-5555', 2);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (4, 'CTC002', 'bwlee@gmail.com', 2);

-- 부모 테이블에서 데이터 삭제 시도 - cascade
/*
	부모 테이블인 tb_cust의 cust_no가 1인 행이 삭제됨
	자식 테이블인 tb_contact에서 cust_no가 1인 행은 삭제됨 
 */
delete from tb_cust where cust_no = 1;

-----------------------------------------------
-- 기존 테이블에 외래키 제약조건 추가 

drop table if exists tb_contact;
drop table if exists tb_cust;

create table TB_CUST
(
	CUST_NO	INT
	, CUST_NM VARCHAR(255) not null
	, primary KEY(CUST_NO)
);

create table TB_CONTACT
(
	CONTACT_NO	INT
	, CONTACT_TYP_CD	CHAR(6) not null	-- 'CTC001' : 전화번호, 'CTC002' : 이메일주소
	, CONTACT_INTO	VARCHAR(100)
	, CUST_NO 	INT 
	, primary KEY(CONTACT_NO)
);

-- 부모 테이블에 데이터 입력
insert into tb_cust (cust_no, cust_nm)
	values (1, '이순신');
insert into tb_cust (cust_no, cust_nm)
	values (2, '이방원');
select * from tb_cust tc  ;

-- 자식 테이블에 데이터 입력
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (1, 'CTC001', '010-2341-4541', 1);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (2, 'CTC002', 'AdmiralYi@gmail.com', 1);

insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (3, 'CTC001', '010-7777-5555', 2);
insert into tb_contact (contact_no, contact_typ_cd, contact_into, cust_no)
values (4, 'CTC002', 'bwlee@gmail.com', 2);

-- alter table
alter table tb_contact 
	add constraint FK_tb_contact_1 foreign KEY(CUST_NO) references TB_CUST(CUST_NO)
	on delete no action;	--no action 옵션으로 외래키 생성 

alter table tb_contact 
	add constraint FK_tb_contact_1 foreign KEY(CUST_NO) references TB_CUST(CUST_NO)
	on delete set NULL;		--set NULL 옵션으로 외래키 생성

alter table tb_contact 
	add constraint FK_tb_contact_1 foreign KEY(CUST_NO) references TB_CUST(CUST_NO)
	on delete CASCADE;		--CASCADE 옵션으로 외래키 생성

---------------------------------------------------
--테이블 생성 (체크 조건 없음)
drop table if exists tb_emp;
create  table tb_emp;
(
	emp_no serial primary key 
	, first_nm varchar(50)
	, last_nm varchar(50)
	, birth_de date 
	, join_de date 
	, sal_amt numeric
);

insert  into tb_emp (first_name, last_nm, birth_de,join_amt,sal_amt  )
values ('순신', '이','1994-03-07', '1889-01-02', -10000)
truncate table tb_emp ;

alter table tb_emp add constraint tb_emp_sal_amt_check check(sal_amt>0);

--테이블 생성 (체크 조건)
drop table if exists tb_emp;
create  table tb_emp;
(
	emp_no serial primary key 
	, first_nm varchar(50)
	, last_nm varchar(50)
	, birth_de date check(birth_de>'1900-01-01')
	, join_de date check(join_de>birth_de)
	, sal_amt numeric check(sal_amt>0)
);

insert  into tb_emp (first_name, last_nm, birth_de,join_amt,sal_amt  )
values ('순신', '이','1994-03-07', '2003-01-02', 500000)

----------------------------------------------------------------
--테이블 생성(유니크 제약조건)
drop table if exists tb_person;
create  table tb_person
(
	person_no serial primary key
	, first_nm varchar(50)
	, last_nm varchar(50)
	, email_adres varchar(150) /*unique*/
		--email_aders의 값은 각각의 행이 모두 유일한 값이여야 함
);
insert  into tb_person (first_nm,last_nm,email_adres )
values ('순신', '이','ejdjd@gmail.com');
--유니크 인덱스 생성
create  unique index idx_tb_person_01
	on tb_person(first_nm,last_nm,email_adres );

--유니크 제약조건을 걸어줌
alter table tb_person 
	add constraint constraint_tb_person_01 unique
	using index idx_tb_person_01
;

insert  into tb_person (first_nm,last_nm,email_adres )
values ('순신', '리','ejdjd@gmail.com');

--테이블 생성 (유니크 제약조건, 컬럼조합)
drop table if exists tb_person;
create  table tb_person
(
	person_no serial primary key
	, first_nm varchar(50)
	, last_nm varchar(50)
	, email_adres varchar(150)
	, unique(first_nm,last_nm,email_adres )
	--first_nm/last_nm/email_adres의 값의 조합은
	--각각의 행이 모두 유일한 값이여야 함
);

--------------------------------------------------

drop table if exists TB_PERSON;
create table TB_PERSON
(
	PERSON_NO SERIAL primary key
	, FIRST_NM VARCHAR(50) null
	, LAST_NM VARCHAR(50) null
	, EMAIL_ADRES VARCHAR(150) not NULL
);

insert into TB_PERSON (FIRST_NM, LAST_NM, EMAIL_ADRES)
values ('순신', '이','NULL' );

alter table TB_PERSON alter column FIRST_NM set not null;
alter table TB_PERSON alter column LAST_NM set not null;

insert into TB_PERSON (FIRST_NM, LAST_NM, EMAIL_ADRES)
values ('방원', '이','BWLEE@gmail.com' );

select *
from TB_PERSON TP
where EMAIL_ADRES is null;















