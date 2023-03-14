select 1 + 1 as 일더하기일;

create table TB_EMP 
(
	EMP_NO CHAR(10)			-- 고정 길이 10자리의 문자열
	,EMP_NM VARCHAR(50)		-- 최대50자리의 가변 길이 문자열
	,SELF_INTRO text		-- 길이 제한이 없는 가변 길이 문자열 
);

drop table tb_emp ;


/*
 * * SERIAL 데이터타입
 * 	: 자동으로 순차적으로 1,2,3,4....식으로 데이터가 저장됨
 *  
 */
create table TB_EMP
(
	EMP_NO SERIAL primary key
	, AGE smallint
	, GRADE_POINT NUMERIC(3,2)	-- 0.00 ~ 9.99까지의 값을 가짐  
	, SAL NUMERIC(9) -- 999999999원을 넘지 않으며 정수형으로 이루어짐
	, TOT_ASSET	INT  -- INT형 
);

insert into tb_emp (AGE, grade_point, sal, tot_asset)
values (35, 4.25, 587000000, 1250000000);

select * from tb_emp;

insert into tb_emp (AGE, grade_point, SAL, tot_asset)
values (36, 4.26, 587000001, 1250000001);

drop table tb_emp ;



-- 데이터 타입 - 날짜형 
create table TB_TMP 
(
	BIRTH_DE DATE
	,JOIN_DT TIMESTAMPTZ
	,JOIN_DT_WITHOUT_TIMEZONE TIMESTAMP
	,TASK_BEGIN_TM TIME 
);

insert into tb_tmp 
values ('2023-03-02', '2023-03-03 125610.123456',
		'2023-03-03 125610.123456' 
		at time zone 'America/New_York', '13:00:03');
select * from tb_tmp;
drop table tb_tmp ;


show timezone
-- :: 타입 변환
-- value::쇼ㅔㄷ

select  current_date as "current_date"  --현재날짜 가져오기
	, current_time as "current_time"	--현재시간 가져오기
	, now() as "now()"					--현재일시(마이크로세컨드단위까지) 가져오기
	, now()::date as "now()::date"		--현재날짜 가져오기
	, now()::time as "now()::time"		--현재시간 가져오기
	



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	











