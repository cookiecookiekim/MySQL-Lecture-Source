-- 24-09-26 (목) 6교시 index (참고용으로 알아두면 좋다)
-- 빈번한 조회할 때 유용하게 쓰일 수 있다. (데이터를 미리 로딩)
create table phone (
	 phone_code int primary key
    ,phone_name varchar(100)
    ,phone_price decimal(10,2) 
) engine = innodb;

-- decimal : sql에서 숫자 값을 정밀하게 저장하기 위해 사용한다.
-- 소수점을 다룰 때 유용하다.
-- 첫 번째 인자 : 정밀도를 의미, 전체 숫자의 최대 자리수를 뜻한다. (소수점 앞 뒤 포함)
-- 두 번째 인자 : 소수점 아래 올 수 있는 최대 자리수 의미

insert into phone
values
	 (1, '갤럭시S24울트라', 1200000)
	,(2, '갤럭시Z폴드6', 2250000)
	,(3, '갤럭시Z플립6', 1400000);
    
select * from phone;

-- explain (설명)
-- 작성한 쿼리문의 실행 계획을 출력해준다.
explain select * from phone where phone_name = '갤럭시S24울트라';
-- 인덱스가 없는 컬럼을 where 절의 조건으로 실행한 결과

-- index 생성
create index idx_name
on phone(phone_name); -- phone이라는 테이블에 phone_name에 적용하겠다.
-- index 생성을 통해 미리 로딩을 해놨다, 실제 조회시에 빠르게 접근

show index from phone;

select * from phone where phone_name = '갤럭시Z폴드6';
-- 실행 계획 출력을 통해, 인덱스를 통해 데이터를 빠르게 조회했는지 확인
explain select * from phone where phone_name = '갤럭시Z폴드6';

drop index idx_name on phone;
show index from phone;







