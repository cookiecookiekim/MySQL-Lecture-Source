-- root 계정에서 실행
-- employee 계정 생성
create database employee;
-- 권한 부여
grant all privileges on employee.* to ohgiraffers@'%';
-- 권한 부여 확인
show grants for ohgiraffers@'%';