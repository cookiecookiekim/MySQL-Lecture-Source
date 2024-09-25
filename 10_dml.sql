use menudb;
-- 24-09-25 (수) 3교시
-- DML (Data Manipulation Language)
-- Manipulation : 조작 (DataBase 들을 수정한다.)
-- → 테이블의 값을 삽입, 수정, 삭제하는 SQL의 한 부분을 의미

-- 삽입 (INSERT)
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.

insert into tbl_menu values (null, '바나나해장국', 8500, 4, 'Y'); -- tbl_menu라는 테이블에 값(행)을 넣을 거다.
-- insert into tbl_menu values (null, '바나나해장국', null, 4, 'Y'); 에러 발생

-- 설명
describe tbl_menu;
-- dbl 동작 확인용 select 구문
select * from tbl_menu; -- 잘 들어갔는지 확인 (메뉴 코드를 null로 했으나 22로 자동 입력 되었음)

-- 컬럼을 명시하면, insert 시 데이터 입력 순서를 바꿔도 상관 없음.
insert into tbl_menu
(orderable_status, menu_name, menu_code, menu_price, category_code) -- 순서를 바꿀 수 있다.
values ('Y', '파인애플탕', null, 5500, 4); -- 이 순서대로만 넣으면 된다. (23번에 파인애플탕 추가 완료)

insert into tbl_menu
(orderable_status, menu_name, menu_price, category_code)
values ('Y', '초콜릿밥', 1000, 4); -- menu_code 자리가 비었는데도 정상적으로 삽입된다.
								-- insert시 auto_increment가 있는 컬럼이나 null값을 허용하는 컬럼은
                                -- 데이터를 넣지 않아도 된다.
                                
-- 여러 개의 행 동시 추가 (multi row)
insert into
	tbl_menu
values
	 (null, '참치맛아이스크림', 1600, 12, 'Y')
    ,(null, '해장국맛아이스크림', 1900, 12, 'Y')
    ,(null, '멸치맛아이스크림', 1200, 12, 'Y'); -- 나열 연산자를 이용하여 여러개의 행을 동시에 추가 가능

-- UPDATE
-- 테이블에 기록된 컬럼들의 값을 수정하는 구문
-- 테이블의 행 개수에는 영향을 미치지 않는다.
select
	menu_code,
    category_code
from
	tbl_menu
where
	menu_name = '파인애플탕';
    
-- delete update → 조건
    
update tbl_menu
set
	category_code = 7 -- 여기서 조건 설정 전에 동작해버리면 다 바뀌므로 조심.. 
where
	menu_code = 23;
    
-- suvquery를 사용해서 update
-- 주의점. update나 delete시에 자기 자신의 테이블의 데이터를 사용하게되면 1093 error 발생

-- 문제.
-- 메뉴의 이름이 파인애플탕인 메뉴의 카테고리 코드를 6으로 수정하세요.
-- where menu_name = '파인애플탕' x
-- where menu_code를 통해 파인애플탕 추론하기

update tbl_menu
set
	category_code = 6
where
	menu_code = (
					select
						menu_code
					from
						tbl_menu
					where
						menu_name = '파인애플탕'
				); -- 23코드 확인
                
-- 1093 error 문제 해결 ↓↓↓↓↓

update tbl_menu
set
	category_code = 6
where
	menu_code = (
					select
						cte.menu_code -- menu_code도 위 테이블 소속이므로 가상의 cte. 를 삽입한다.
					from
						(
                        select
							menu_code
						from
							tbl_menu
						where
							menu_name = '파인애플탕'
						) cte -- 가상의 테이블은 별칭을 지어줘야 한다.
				);
                
-- delete
-- 테이블의 행을 삭제하는 구문이다.
-- 테이블의 행의 개수가 줄어든다.

-- limit
delete from tbl_menu -- 매뉴 테이블에서 삭제할 거다.
order by menu_price -- 메뉴 프라이스 기준으로 (아무것도 쓰지 않으면 asc오름차순 디폴트)
limit 2; -- 오름 차순으로 2개 삭제할 거다.

select * from tbl_menu;

-- where 사용으로 단일 행 삭제
delete from tbl_menu
where
	menu_code = 26;
    
delete from tbl_menu; -- 전체 테이블 자체가 삭제된 게 아니라, 값만 삭제된 거다.

-- replace
-- insert 시 primary key 또는 unique key가 충돌이 발생한다면
-- replace를 통해 중복된 데이터를 덮어쓸 수 있다.

insert into tbl_menu values(15, '소주', '6000', 10, 'Y'); -- 15 → primary key (중복될 수 없다)
-- insert into tbl_menu values(15, '소주', '6000', 10, 'Y'); -- 추가해 봤더니 error가 뜬다. 15라는 키가 이미 있기 때문에
replace into tbl_menu values(15, '소주', '6000', 10, 'Y'); -- 덮어 쓰기 때문에 error가 뜨지 않는다.
replace into tbl_menu values(15, '소주', '7000', 10, 'Y'); -- replace 사용 시 보다 안전하게 동작 가능.
select * from tbl_menu;
                
                