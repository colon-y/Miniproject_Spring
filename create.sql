CREATE TABLESPACE mini_movie DATAFILE  'E:\oracle\tablespace\mini_movie.dbf' SIZE 100M   AUTOEXTEND ON NEXT 10M ; 
CREATE USER mini_movie IDENTIFIED BY 1111 DEFAULT TABLESPACE mini_movie ;
 
GRANT connect, resource, dba TO mini_movie;
