-- 24-09-26 (목) 1~2교시 데이터 직접 삽입하기 이전 시간에 배운 건 DML(수정 삽입 삭제)
-- DDL(Data Defination Language) 데이터를 정의하는 언어
-- 데이터베이스의 스키마를 정의하거나 수정하는 데 사용되는 SQL의 부분.

-- CREATE : 테이블을 생성(창조)하기 위한 구문 
-- IF NOT EXISTS : '만약 존재하지 않는다면' 이라는 뜻
-- → 만약 존재한다면 안 만들고, 존재하지 않는다면 만들겠다 로 해석
-- 위 구문 적용 시, 기존에 존재하는 테이블이 있더라고 에러가 발생하지 않음.

-- 테이블의 컬럼 설정 표현식
-- column_name data_type(length) [] → 컬럼명지정 타입지정(길이) [써도되고 안 써도 되고]
													  -- [NOT NULL] [DEFAULT VALUE] [AUTO_INCREMENT] column_constarint;

-- tbl 테이블 생성

create table if not exists tb1 ( -- 만약 tb1이 존재하지 않는다면 tb1이라는 테이블을 만들겠다
	pk int primary key           -- primary key → [제약 조건]
    ,fk int
    ,coll varchar(255)            -- 여기서 문자열은 varchar라고 한다.
    ,check(coll in ('Y','N'))     -- in → 내부에 'Y','N'이 들어있는지. check → Y와 N 빼고는 허용하지 않는다.
) engine = innodb;

-- engine = innobd; : 해당하는 테이블을 innodb라는 스토리지 엔진으로 만든다는 의미를 가짐.
-- MySQL에서 가장 많이 사용하는 엔진으로써 데이터의 무결성, 안정성, 동시에 제어를 하는 것에 적합.

describe tb1;

-- 만든 테이블에 값 insert 테스트
-- insert into tb1 values (null, 10, 'Y'); pk 컬럼은 null을 허용하지 않음
-- insert into tb1 values (1, null, 'G'); -- Y나 N이 들어가야 하지만 G 가 들어가서 에러

insert into tb1 values (1, 10, 'Y'); -- 이제 정상적인 값 삽입
select * from tb1; -- 잘 들어간 거 확인

create table if not exists tb2 ( 
	pk int auto_increment primary key -- auto_increment 속성 추가해봄
    ,fk int
    ,coll varchar(255)
    ,check(coll in ('Y','N'))
) engine = innodb;

-- 잘못 생성한 테이블 삭제하는 구문 drop
drop table tb2; -- tb2 테이블이 삭제되었음.

describe tb2; -- auto_increment 속성 추가한 다음에 확인해 보니 Extra에 auto_increment가 추가됨

-- auto_increment
-- insert 시에 pk라고 하는 컬럼에 자동으로 번호를 발생시킨다.
-- 또한 중복되지 않는 값을 발생시킨다.

insert into tb2 values (null, 10, 'Y'); -- 아까 pk 컬럼에 null 넣었을 땐 오류 발생했으나 auto_increment 구문이 자동 추가해줘서 오류 안 난다.
insert into tb2 values (null, 20, 'Y');

select * from tb2; -- pk에 순차적으로 1, 2 자동 생성

-- alter : 테이블에 추가 / 변경 / 수정 / 삭제하는 모든 것은 alter 명령어로 적용 가능.
-- alter 는 insert나 update 처럼 값을 수정, 추가하는 게 아니라 테이블(컬럼, 데이터 타입) 등을 수정하는 예약어이다.

-- 열 추가 → 컬럼 추가
alter table tb2
add col2 int not null; -- add + 컬럼명 + 데이터 타입 + null값 허용 유무;

describe tb2; -- col2 추가

-- 이제 열을 삭제(컬럼 삭제)해보자.

alter table tb2
drop column col2; -- 컬럼 2 삭제

-- 열 이름 변경 및 데이터 타입 변경
-- alter table 변경할 테이블 change 기존 컬럼명 바꿀 컬럼명 컬럼정의 (데이터타입, 제약조건)
-- tb2의 fk 컬럼을 change_fk로 변경, 예약 조건을 not null로 바꿔라

alter table tb2
change column fk change_fk int not null; -- column을 먼저 작성해주고, 바꿀 컬럼명 , 바꿀컬럼명 이름, 데이터타입, null 유무

-- 열의 제약 조건 추가 및 삭제
-- alter table 테이블명 drop 제약조건
alter table tb2
drop primary key; -- 2. auto_increment 정의부터 삭제하고 진행해야 한다.

-- auto_increment가 속해있는 컬럼은 primary key 제거가 되지 않는다.
-- 따라서 auto_increment 속성을 modify로 제거한다.
-- modify는 컬럼의 정의를 바꾸는 것이다.
alter table tb2
modify pk int; -- 1. Extra에 auto_increment 정의가 삭제됨
-- 순서 :  auto_increment 정의 삭제 → primary key 삭제

-- tb3 생성
create table if not exists tb3 ( 
	 pk int auto_increment primary key
    ,fk int
    ,coll varchar(255)
    ,check(coll in ('Y','N'))
) engine = innodb; -- tb3 생성 확인

-- tb3 삭제
drop table if exists tb3; -- if exists를 추가하여 추후 에러를 방지 (안전한 식)
-- 이미 삭제되고 if exists가 없다면 전체 실행 시, 에러 발생하여 식이 멈춤.

-- tb4, tb5 생성
create table if not exists tb4 ( 
	 pk int auto_increment primary key
    ,fk int
    ,coll varchar(255)
    ,check(coll in ('Y','N'))
) engine = innodb;

create table if not exists tb5 ( 
	 pk int auto_increment primary key
    ,fk int
    ,coll varchar(255)
    ,check(coll in ('Y','N'))
) engine = innodb;

-- tb4, tb5 동시 테이블 삭제 방법
drop table if exists tb4, tb5; -- 나열 연산자

-- truncate란? delete처럼 행마다 삭제하는 게 아니라, 통으로 삭제하는 구문이다.
-- truncate (통으로 날림) ↔ delete (행마다 삭제)
-- delete 구문 작성 시 where 조건절로 '행' 삭제
-- 조건 없이 delete하면 전체 행 삭제

-- → delete는 우리가 제어판에서 하나씩 삭제한다고 치면 truncate는 pc 초기화의 느낌

-- tb6 생성
create table if not exists tb6 ( 
	 pk int auto_increment primary key
    ,fk int
    ,coll varchar(255)
    ,check(coll in ('Y','N'))
) engine = innodb;

-- 초기화 확인용 더미네이터
insert into tb6 values (null, 10, 'Y');
insert into tb6 values (null, 20, 'Y');
insert into tb6 values (null, 30, 'Y');
insert into tb6 values (null, 40, 'Y');

select * from tb6; -- 데이터가 잘 들어갔는지 확인

truncate table tb6; -- 테이블 초기화 (데이터 다 날라감)

select * from tb6; -- 초기화 확인, 그렇가면 ddl이 아니라 dml 아닌가?
-- table drop하고 create하기 때문에 테이블 구조 자체를 변경한 것.
-- truncate 시, 데이터 초기화 후 재생성(값이 아니라 구조)
-- data에 영향을 미친 게 아니라 database에 영향을 미친 것.




