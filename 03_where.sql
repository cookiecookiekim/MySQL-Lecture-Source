use menudb;
-- where 절이란? 
-- 특정 조건에 일치하는 행(레코드)만 선택을 하는데 사용되며 다양한 조건으로 설정할 수 있다.

-- tbl_menu 테이블에서 이름,가격,판매상태를 조회해줘
-- 근데 판매상태가 Y인 항목들만 조회해줘.

select
	menu_code,
    menu_price,
    orderable_status
from
	tbl_menu
where
	orderable_status = 'Y';
    
-- 문제1 : tbl_menu 테이블에서 이름, 가격, 판매상태를 조회할 거야
-- 근데 메뉴 가격이 13000인 메뉴만 조회를 해줘

select
	menu_name,
    menu_price,
    orderable_status
from
	tbl_menu
where
	menu_price = 13000;

-- 문제 2 : tbl_menu 테이블에서 코드, 이름, 판매 상태 조회
-- 단, 판매 상태가 Y가 아닌 항목들만 조회해줘.

select
	menu_code,
    menu_name,
    orderable_status
from
	tbl_menu
where -- 부정의 의미 : != , <>
	orderable_status != 'Y'; -- <>도 부정의 의미이다. 편한 거 쓰면 된다.
    
-- 문제 3 : tbl_menu 테이블에서 전체 조회할건데
-- 가격이 20000초과인 항목들만 조회해줘

select
	*
from
	tbl_menu
where
	menu_price > 20000;
    
-- 문제 4 : tbl_menu 테이블에서 모든 컬럼 조회할건데
-- 가격이 10000 이상 20000 미만인 메뉴를 조회해줘.

select
	*
from
	tbl_menu
where
	menu_price >= 10000 and menu_price < 20000; -- && 도 가능하다.

-- and / or 연산자는 where절과 함께 사용하며 자바와 똑같다.

-- 문제 5 : tbl_menu 테이블에서 모든 컬럼 조회할건데
-- 단, 판매 상태가 Y이거나 카테고리 코드가 10인 메뉴 조회해줘.
-- 그리고 카테고리 코드로 오름차순 정렬
select
	*
from
	tbl_menu
where
	orderable_status = 'Y' || category_code = 10 -- or 사용해도 됨
order by
	category_code; -- asc가 기본값이다.

-- 문제 6 : tbl_menu 테이블에서 모든 컬럼 조회할건데
-- 단, 판매 상태가 Y이면서 카테고리 코드가 10인 메뉴 조회해줘.
-- 그리고 카테고리 코드로 오름차순 정렬
select
	*
from
	tbl_menu
where
	orderable_status = 'Y' and category_code = 10
-- and 사용 시 둘 중 하나라도 true가 아니면 false
-- or 둘 중 하나라도 true면 true
order by
	category_code;
    
-- between : ~사이 (between A and B)
-- 문제 7 : tbl_menu 테이블에서 모든 컬럼 조회할건데
-- 단, 메뉴 가격이 10000과 20000원 사이인 메뉴만 조회해줘.
select
	*
from
	tbl_menu
where
	menu_price between 10000 and 20000;
    
-- 문제 8 : tbl_menu 테이블에서 모든 컬럼 조회할건데
-- 단, 메뉴 가격이 10000과 20000원 사이가 아닌 메뉴만 조회해줘.
select
	*
from
	tbl_menu
where
	menu_price not between 10000 and 20000; -- 느낌표는 붙일 수 없다. 부정은 not
    
-- like 연산자
-- 문제 8 : tbl_menu 테이블에서 메뉴 이름과 가격 조회
-- 단, 메뉴이름이 '마늘'을 포함하고 있는 메뉴만 조회
select
	menu_name,
    menu_price
from
	tbl_menu
where
-- like 단독 사용 시 반드시 일치하는 행만 return해줌
-- % ← 포함하는 것도 return
-- % 위치에 따라 단어로 시작하거나, 끝나거나, 포함하는 식을 만들 수 있음.
	menu_name like '생마늘%'; -- like 사용 시 반드시 일치하는 행만 return해줌

-- 문제 9 : tbl_menu 테이블에서 전체 컬럼 조회
-- 단, 가격이 5000원 넘으면서 카테고리 코드가 10이면서 '갈치' 단어를 포함하는 메뉴 조회
select
	*
from
	tbl_menu
where
	menu_price > 5000 && category_code = 10 && menu_name like '%갈치%';
    
-- in 연산자 활용
-- 문제 10 : tbl_menu 테이블에서 이름, 카테고리 조회
-- 단, 카테고리 코드가 4,5,6인 항목만 조회 (or 연산자 사용 금지)
select
	menu_name,
    category_code
from
	tbl_menu
where
-- in을 사용 안 하면 category_code = 4 or category_code = 5 or category_code = 6 코드가 길어진다.
	category_code in (4,5,6);

-- is null 활용
-- 문제 11 : tbl_category 테이블에 모든 데이터 조회
-- 단, null 값을 포함한 것은 제외
select
	*
from
	tbl_category
where
	ref_category_code is not null; -- is null은 null 포함한 항목들 부정은 not 추가
    