create sequence seq_cinema_c_idx;

create table cinema(
	c_idx      int,
	c_category varchar2(100)  not null,
	c_subject  varchar2(100)  not null,
	c_info     varchar2(2000) not null,
	c_filename varchar2(1000),
	c_regdate  date

);

alter table cinema add constraint pk_cinema_c_idx primary key(c_idx);
	
insert into cinema values (seq_cinema_c_idx.nextVal,
                           '액션',
                           '탑건: 매버릭',
                           '톰 크루즈가 돌아왔다. 탑건 매버릭',
                           '',
                           sysdate) ;
                           
                           
	
select * from cinema

drop table cinema cascade constraints
drop sequence seq_cinema_c_idx
