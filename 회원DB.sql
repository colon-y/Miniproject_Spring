create table member
(
	m_idx       int,
	m_name      varchar2(100) not null,
	m_id        varchar2(100) not null,
	m_pwd       varchar2(100) not null,
    m_nickname	varchar2(100) not null,
    m_grade     varchar2(100) default '일반',
	m_ip        varchar2(100) not null,
	m_regdate   date,
	m_addr      varchar2(500) not null,
	m_zipcode   varchar2(100) not null,
	m_delete	varchar2(5) default 'show'
);

alter table member
	add constraint pk_member_m_idx primary key(m_idx);
	
create sequence seq_member_m_idx;

alter table member
	add constraint unique_member_m_id unique(m_id);
	
alter table member
	add constraint unique_member_m_nickname unique(m_nickname);
	
alter table MEMBER add constraint ck_member_m_grade check(m_grade in('일반', '관리자') );
	

insert into member values(seq_member_m_idx.nextVal, '홍길동', 'hong', '1234', '길동이', '일반', '192.168.0.134', sysdate, '서울시 마포구', '32131' , 'show');

insert into member values(seq_member_m_idx.nextVal, '관리자', 'admin', '1234', '관리자', '관리자', '192.168.0.9', sysdate, '서울시 마포구', '0548' , 'show' );




















select * from member

alter table member
	add m_addr varchar2(500)

update member set m_addr = 'addr';

alter table member
	modify m_addr not null
	
alter table member
	add m_zipcode varchar2(100)
	
update member set m_zipcode = '00000';

alter table member
	modify m_zipcode not null

drop table member cascade constraints
drop sequence seq_member_m_idx

