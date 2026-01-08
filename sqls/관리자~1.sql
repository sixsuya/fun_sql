select * from all_users;

select *
from tab;

alter session set "_ORACLE_SCRIPT"=true;

create user scott
identified by tiger
default tablespace users
temporary tablespace temp;

grant connect, resource, unlimited tablespace
to scott;

create user hr
identified by hr
default tablespace users
temporary tablespace temp;

grant connect, resource, unlimited tablespace to hr;