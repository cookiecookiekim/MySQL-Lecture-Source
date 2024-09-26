use menudb;
-- 24-09-26 (목) 5교시 view (14, 15번 챕터 → 개선방안) (참고용으로 알아두면 좋다)
-- view : select 쿼리문을 저장한 객체로 가상 테이블이라고 불리운다. 
-- 실질적인 데이터를 물리적으로 저장하고 있지 않고, 쿼리만 저장을 했지만
-- 테이블을 쓰는 것과 동일하게 사용할 수 있다.

select * from tbl_menu;

-- view 생성 표현식
-- create view 사용할 이름 as 쿼리문;
create view hansik as -- hansik 가상의 테이블 이름 설정
select
	*
from
	tbl_menu
where
	category_code = 4;

-- 만들어진 view 조회
select * from hansik;
-- 데이터베이스가 할 일을 줄여줬다.
-- 전체를 조회(21번)해야 하지만 hansik이라는 가상의 테이블로 설정하여 
-- 4번만 조회를 하면 되므로. 

-- 한식이라고 하는 view는 원본인 tbl_menu 에서 만든 가상의 테이블
insert into tbl_menu values (null, '해장국', 5500, 4,'Y'); -- 원본에 값을 바꿔보자

-- 베이스 테이블의 정보가 변경되면, view도 같이 반영된다.
select * from hansik; -- 위에 값이 추가됨.

-- view에서의 dml 수행
-- 주의점 : base 테이블에서는 autoincrement가 설정돼 있지만
-- view에서는 설정하지 않았기 때문에 제약조건 위반여부 고려
insert into hansik values (99, '뼈다구해장국',8000 , 4 , 'Y');
select * from hansik; -- view 먼저 반영 여부 확인 : 확인.
select * from tbl_menu; -- view에서 실행한 구문이 원본에도 영향 미쳤는지 여부 확인 : 확인. 

update hansik
set
	 menu_name = '우거지해장국'
    ,menu_price = 9000
where
	menu_code = 99;
    
select * from tbl_menu; -- hansik으로 업데이트 추가 가능
select * from hansik;
-- view 사용 시 dml 주의점
-- 1. view 사용 시 원본에 포함되지 않는 컬럼을 사용하려는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중 베이스가 되는 테이블 컬럼이 not null 제약조건 지정된 경우
-- 3. 산술 표현식이 정의된 경우
-- 4. join을 이용해 여러 테이블을 연결한 경우
-- 5. 그룹함수나 group by 절을 포함한 경우
-- 6. distinct를 포함한 경우

-- 생성한 view 삭제 ( 테이블 삭제와 같다.)
drop view hansik;

-- or replace 옵션
-- 테이블을 drop하지 않고 기존의 view를 새로운 view로 대체

create or replace view hansik as
select
	 a.menu_name as 메뉴명
    ,b.category_name as 카테고리명
from
	tbl_menu a
    join
    tbl_category b on a.category_code = b.category_code
where b.category_name = '한식';

select * from hansik;


