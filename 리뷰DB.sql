create table review(
	r_idx       int,
	r_subject   varchar2(1000) not null,
	r_content   varchar2(2000) not null,
	r_regdate   date,
	r_score       int,
	r_count     int,
	m_idx       int,
	c_idx       int	
);

create sequence seq_review_r_idx;

alter table review add constraint pk_review_r_idx primary key(r_idx);
	
alter table review add constraint fk_review_m_idx foreign key(m_idx) references member(m_idx);

alter table review add constraint fk_review_c_idx foreign key(c_idx) references cinema(c_idx);
	
	
	
	
	
----	
	
insert into review values(seq_review_r_idx.nextVal, '이 영화를 추천합니다',
                    '추천합니다',
                    sysdate,
                    4,
                    1,
                    1,
                    1);
                    
                    
                    
	
select * from review


drop view review_view

drop table review cascade constraints 
drop sequence seq_review_r_idx
	