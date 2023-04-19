--TB_USER라는 테이블을 생성
create table TB_USER
(
	user_id char(10) primary key		--user_id가 기본키(PK), CHAR은 고정문자열
	, user_nm varchar(50) not null		--값이 꼭 존재해야 함, VARCHAR은 가변문자열
	, password varchar(50) not null		--값이 꼭 존재해야 함
	, email_address varchar(255) unique not null
		--해당 테이블에 유일한 값이여야 함. 또한 값이 꼭 존재해야 함
	, create_on timestamp not null		--값이 꼭 존재해야 함
	, last_login timestamp 				--null허용. 값이 존재하지 않아도 됨
);


--TB_ROLE라는 테이블을 생성
/*
 * 특정 사용자(user)는 여러개의 역학(role)을 가질 수 있음
 * 특정 역할(role)은 여러명의 사용자(user)에 의해 수행될 수 있음
 */
create table TB_ROLE
(
	role_id char(10) primary key		--role_id가 기본키(pk)
	, role_nm varchar(255) not null		--값이 꼭 존재해야 한다
);

--tb_user_roleE라는 테이블을 생성
create table tb_user_role
(
	user_id char(10) not null		--값이 꼭 존재해야 한다
	, role_id char(10) not null		--값이 꼭 존재해야 한다
	,primary key(user_id,role_id)	--user_id + role_id 가 기본키 (pk)
	,foreign key(user_id) references tb_user(user_id)   --user_id 컬럼은 외래키로써 tb_user테이블에 user_id컬럼을 참조함
	,foreign key(role_id) references tb_role(role_id)	--role_id 컬럼은 외래키로써 tb_role테이블에 role_id컬럼을 참조함
);

drop table if exists TB_LINK;
create table TB_LINK
(
	LINK_ID SERIAL PRIMARY key	--LINK_ID 컬럼이 PK이고 SERIAL데이터 타입을 지정함, 순차적으로 1,2,3,4... 로 저장되게 됨
	, TITLE VARCHAR(512) not null   --값이 NULL이면 안된다 즉 값이 무조건 있어야 한다
	, URL VARCHAR(1024) not null	--값이 NULL이면 안된다 즉 값이 무조건 있어야 한다
	
);
--생성된 테이블에 수정, 삭제 할 때는 ALTER TABLE를 사용해야 한다
--컬럼추가(ADD)
alter table TB_LINK add column ACTIVE_YN CHAR(1);
select * from tb_link ;

--컬럼삭제(DROP)
alter  table TB_LINK drop ACTIVE_YN;
select * from TB_LINK;


--TITLE컬럼 이름을 LINK_TITLE로 변경(TO)
alter table TB_LINK rename column TITLE to LINK_TITLE;

--TARGET 이라는 컬럼을 추가
alter table TB_LINK add column TARGET VARCHAR(10);
select * from TB_LINK;

--TARGET 이라는 컬럼의 디폴트값 '_BLANK'로 지정
alter table tb_link alter column TARGET set default '_BLANK'

insert into tb_link (link_title,URL)
	VALUES('애플','https://www.figma.com/');
select *from TB_LINK;

--TARGET 컬럼에 저장되는 값 '_SELF', '_BLANK', '_PARENY', '_TOP'으로만 함
alter table TB_LINK add check (TARGET in('_SELF', '_BLANK', '_PARENY', '_TOP'));

--새 자료가 "tb_link" 릴레이션의 "tb_link_target_check" 체크 제약 조건을 위반했습니다
--2번으로 인식됨
insert into tb_link (LINK_TITLE, URL, TARGET)
	values ('피그마', 'https://www.youtube.com/', '체크 제약조건');


insert into tb_link (LINK_TITLE, URL, TARGET)
	values ('피그마', 'https://www.ezenac.co.kr/','_SELF');
select * from tb_link ;

insert into TB_LINK (LINK_TITLE, URL)
	values ('깃허브', 'https://github.com/' );
select * from tb_link ;


--URL 컬럼에 대한 UNIQUE 제약조건 추가
alter table tb_link add constraint unique_url unique(url); 

--URL 컬럼에 값이 이미 존재
insert into tb_link (LINK_TITLE,URL)
	values ('애플','https://github.com/' );
select *from tb_link ;

--=======================================================

create table tb_asset
(
	asset_no serial primary key
	, asset_nm text not null
	, asset_id varchar not null
	, description text
	, loc text
	, acquired_de date not null
);

insert into tb_asset (asset_nm, asset_id, acquired_de)
values ('server', '10001', 'server room', '2023-03-06');
insert into tb_asset (asset_nm, asset_id, acquired_de)
values ('ups', '10002', 'server room', '2023-03-05');

select * from tb_asset ;

--asset_nm 컬럼의 데이터 타입을 text => varchar로 변경
alter table tb_asset alter column asset_nm type varchar;

--컬럼의 데이터 타입 변경 => 2개의 컬럼 동시 변경
alter table tb_asset alter column loc type varchar, alter column description type varchar;


--SQL Error [42804]: 오류: "asset_id" 칼럼의 자료형을 integer 형으로 형변환할 수 없음
--Hint: "USING asset_id::integer" 구문을 추가해야 할 것 같습니다.
alter table tb_asset alter column asset_id type int;

--컬럼의 데이터 타입 변경(USING 절 추가)
alter table tb_asset alter column asset_id type int using asset_id::integer;


--================================================================================
create table tb_invoice
(
	invoice_no serial primary key
	, issue_de timestamp 
	, prdt_nm varchar(150)
);

insert into tb_invoice (issue_de, prdt_nm)
values(CURRENT_TIMESTAMP , '아메리카노');
insert into tb_invoice (issue_de, prdt_nm)
values(CURRENT_TIMESTAMP , '카페라떼');
insert into tb_invoice (issue_de, prdt_nm)
values(CURRENT_TIMESTAMP , '모카라떼');

--테이블 내용 전체 비우기
truncate table tb_invoice ;

--invoice_no컬럼의 값이 4,5으로 들어감
insert into tb_invoice (issue_de, prdt_nm)
values(CURRENT_TIMESTAMP , '아메리카노');
insert into tb_invoice (issue_de, prdt_nm)
values(CURRENT_TIMESTAMP , '카페라떼');

--truncate table시 restart identity 옵션을 줌
-- => serial 값이 초기화 됨
truncate table tb_invoice restart identity;

--테이블 제거
drop table tb_invoice ;

--if exists문 사용하여, 존재하지 않으면 제거하지 않아서 sql에러 미발생
drop table if exists tb_invoice;


--======================================================
create table tb_contact
(
	contact_no serial primary key
	, first_nm varchar(50) not null
	, last_nm varchar(50) not null
	,email_adres varchar(200) not null unique
);

insert into tb_contact (first_nm, last_nm, email_adres)
values('순신', '이', 'sslee@gmail.com');
insert into tb_contact (first_nm, last_nm, email_adres)
values('방원', '이', 'bwlee@gmail.com');

select * from tb_contact ;

/*
 * 테이블 구조 및 데이터 복제 => 제약조건은 복제 반영 안됨
 * 	-테이블, 컬럼명, 컬럼데이터타입, 컬럼값만 복제
 */
create table tb_contact_bak as table tb_contact ;

--제약조건 추가
alter table tb_contact_bak add primary key(contact_no);
alter table tb_contact_bak add unique(email_adres);
alter table tb_contact_bak alter column first_nm set not null;
alter table tb_contact_bak alter column last_nm set not null;
alter table tb_contact_bak alter column email_adres set not null;


drop table tb_user_role ;
drop table tb_user;







































