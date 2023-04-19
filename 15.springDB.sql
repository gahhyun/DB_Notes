select  now();

--사용자 테이블
drop table if exists t_user;
create table t_user
(
	id 	varchar(30)		not null 	primary key
	,pwd 	varchar(50)
	,name   varchar(30)
	,email 	varchar(30)
	,birth 	date
	,sns  	varchar(30)
	,reg_date 	date
);

select *
from t_user 
;

INSERT INTO public.t_user
(id, pwd, "name", email, birth, sns, reg_date)
VALUES('earth', '0629','earth2', 'earth@gmail.com', '2000-04-27', 'youtube', now());

