use menudb;
-- 24-09-26 (목) 3~4교시 ★★★★★★★★★★ constraints (제약 조건에 대해 깊숙이 알아보는 시간) ★★★★★★★★★★ 외울 필요가 있다.
-- 테이블에 데이터가 입력되거나 변경될 때 규칙을 정의한다.
-- 데이터의 무결성!!

-- not null
-- null 값 즉, 비어있는 값을 허용하지 않는다. 라는 제약 조건

drop table if exists user_notnull;
create table if not exists user_notnull(
	 user_no int not null -- 비어있으면 안 되는 컬럼
    ,user_id varchar(30) not null -- 30은 자리수를 말하는데 30칸 이상 작성해도 알아서 늘려줌.
    ,user_pwd varchar(40) not null
    ,user_name varchar(30) not null
    ,gender varchar(3)
    ,phone varchar(30) not null
    ,email varchar(50)
) engine = innodb;

describe user_notnull;

insert into user_notnull
values
 (1, 'user01', null, '김규남', '남', '010-1234-5678', 'gyunam@naver.com') -- not null 항목에 null 넣어서 에러 발생
,(2, 'user01', 'pass01', '김규순', '여', '010-5123-5238', 'gyu@naver.com');

select * from user_notnull;


-- unique 제약 조건
-- 중복된 값을 허용하지 않는 제약조건

drop table if exists user_unique;
create table if not exists user_unique(
	 user_no int not null unique -- null 허용 안 하면서 유일한 값 (unique 설정 1) → not null + unique = primary
    ,user_id varchar(30) not null
    ,user_pwd varchar(40) not null
    ,user_name varchar(30) not null
    ,gender varchar(3)
    ,phone varchar(30) not null
    ,email varchar(50)
    ,unique(phone) -- 이런 식으로도 unique 설정 가능 (unique 설정 2) 
) engine = innodb;

describe user_unique;

 -- → not null + unique = primary가 되었음
 
 insert into user_unique
 values
  (1, 'user01', 'pass01', '김규남', '남', '010-1234-5678', 'gyunam@naver.com')
 ,(2, 'user02', 'pass02', '김규순', '여', '010-1234-5678', 'gyunam@naver.com');
-- unique 제약 조건 에러 발생 (전화번호 중복)

-- ★★★★★ primary key ★★★★★
-- ★★★★★ 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미 ★★★★★
-- 테이블에 대한 식별자 역할 → 한 행을 식별할 수 있는 값을 의미
-- unique + not null → primary key
-- 한 테이블 당 하나만 설정 가능
-- 한 개 컬럼에 설정할 수 있ㄱ, 여러 개의 컬럼을 묶어서 설정할 수도 있다.
-- 복합 키 (여러 개의 pk)

drop table if exists user_pk;
create table if not exists user_pk(
     -- user_no int primary key
	 user_no int
    ,user_id varchar(30) not null
    ,user_pwd varchar(40) not null
    ,user_name varchar(30) not null
    ,gender varchar(3)
    ,phone varchar(30) not null
    ,email varchar(50)
    ,primary key(user_no) 
) engine = innodb;

describe user_pk;

-- ★★★★★ foreign key (외래키) ★★★★★
-- 참조(연관)된 다른 테이블에서 제공하는 값만 사용할 수 있음.
-- foreign key 제약조건에 의해 테이블 간의 관계가 형성될 수 있음.

-- 부모테이블, 자식테이블
drop table if exists user_grade;
create table if not exists user_grade(
	 grade_code int primary key
    ,grade_name varchar(30) not null
) engine = innodb;

insert into user_grade
values
 (10, '일반회원')
,(20, '우수회원')
,(30, '특별회원');

select * from user_grade;

drop table if exists user_fk1;
create table if not exists user_fk1(
	 user_no int primary key
    ,user_id varchar(30) not null
    ,user_pwd varchar(40) not null
    ,user_name varchar(30) not null
    ,gender varchar(3)
    ,phone varchar(30) not null
    ,email varchar(50)
    ,grade_no int -- user_grade의 grade_code (10,20,30) 항목을 땡겨오고 싶다. → 그러려면 user_grade가 부모테이블이란 걸 명시해야함
    ,foreign key (grade_no) references user_grade (grade_code)
) engine = innodb;

describe user_fk1;

select * from user_fk1;
 insert into user_fk1
 values
  (1, 'user01', 'pass01', '김규남', '남', '010-1234-5678', 'gyunam@naver.com', 10)
 ,(2, 'user02', 'pass02', '김규순', '여', '010-1234-5678', 'gyunam@naver.com', 20);
 
 select * from user_fk1;
insert into user_fk1
 values
 -- error 1062 : 참조하고 있는 테이블(부모 테이블)에는 존재하지 않는 값을 집어 넣을 때 발생하는 에러
 -- → foreign key 제약조건 위반
  (3, 'user02', 'pass02', '김규순', '여', '010-1234-5678', 'gyunam@naver.com', 25);
  
  -- check 제약 조건 
  -- 조건 위반 시 허용하지 않는 제약조건
drop table if exists user_check;
-- 술을 판매하는 사이트를 만든다고 가정해보자
-- 미성년자는 들어오면 안 된다.
create table if not exists user_check(
	 user_no int auto_increment primary key
    ,user_name varchar(30) not null
    ,gender varchar(3) check(gender in ('남' , '여')) -- 성별은 2가지 값만 받을 것. 남 or 여
    ,age int check(age >= 19)
) engine = innodb;
  
  insert into user_check
  values
   (null, '홍길동' , '남' , 25); -- auto_increment이기 때문에 null 가능
  -- (null, '하츄핑', '여', 7); -- 성별이 19 미만이기 때문에 에러 발생

  describe user_check;
  
  -- default
  -- nullable 한 컬럼에 비어있는 값 대신 직접 설정한 기본값 적용
  
drop table if exists tbl_country;
create table if not exists tbl_country(
	 country_code int auto_increment primary key
    ,country_name varchar(255) default '한국' -- 값 입력하지 않을때 한국 자동 삽입
    ,population varchar(255) default '0명' -- 값 입력하지 않을때 0명 자동 삽입
    ,add_time datetime default (current_time()) -- 값 입력하지 않을때 현재시간 자동 삽입
    ,add_day date default (current_date()) -- 값 입력하지 않을 때 현재날짜 자동 삽입
) engine = innodb;
  
  insert into tbl_country
  values
  (null, default, default, default, default);
  
  select * from tbl_country;
  
  -- 공부 꿀 팁 : 작성하는 것 보다 코드를 해석(읽을) 줄 알아야 한다., 에러 메시지 체크하기
  
  
  
  
  
  
  
  