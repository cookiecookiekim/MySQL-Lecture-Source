-- ★★★★★★★★★★★★★★★★★★★★★★★★★★★ 엄 ~ 청 중요한 챕터 join ★★★★★★★★★★★★★★★★★★★★★★★★★★★
-- 두 개 이상의 테이블을 관련있는 컬럼을 통해 결합(관계를 맺는)하는데 사용된다.
-- 두 개 이상의 테이블은 결합을 하기 위해서는 반드시! 연관있는 컬럼이 존재해야 하며,
-- 연관 있는 컬럼을 통해서 join이 된 테이블들의 컬럼을 모두 사용할 수 있다.

-- ------------------------------------------------------
-- join 시작 전 별칭 정리
-- ------------------------------------------------------
-- as(alias) 별칭
-- sql문(쿼리문)의 컬럼 또는 테이블에 별칭을 달 수 있다.
-- 만약 별칭에 특수기호나, 띄어쓰기가 없다면 as와 ' '는 생략 가능

select
	menu.menu_code as '코드', -- 코드라는 별칭 생성
    menu.menu_name '이름', -- 이름이라는 별칭 생성
    menu.menu_price 가격 -- 가격이라는 별칭 생성
from
	tbl_menu menu; -- 테이블에 menu라는 별칭 작성
    
-- join의 종류

-- inner join
-- 두 테이블의 교집합을 반환하는 join의 유형
-- inner join에서 inner는 생략이 가능하다.

-- on 키워드를 사용한 join 방법
-- 컬럼명이 같거나, 다를 경우 on으로 서로 연관있는 컬럼에 대한 조건 작성 (같거나 다를 경우 다 쓸 수 있으므로 on 사용도 높음)

-- 메뉴의 이름(tbl_menu)과 카테고리(tbl_category)의 이름을 조회
-- 테이블이 다르나 category_code라는 공통된 항목을 가지고 있음. 이용해보자
select
	a.menu_name,
    b.category_name
from
	tbl_menu a -- 기준 잡기인데 공통되는 곳 아무 거나(tbl_category) 입력 가능
	join
    tbl_category b
    on
    a.category_code = b.category_code;
    
-- using을 사용한 join
-- 서로 다른 두 테이블에서 공유하고 있는 컬럼명이 동일한 경우
-- ussing을 사용하여 연관있는 칼럼을 join할 수 있다.

select
	a.menu_name,
    b.category_name
from
	tbl_menu a
	join
    tbl_category b
	using
    (category_code); -- a.category_code = b.category_code; 코드와 같은 의미

-- left join (첫 번째 테이블의 모든 레코드와
-- 두 번째 테이블에서 일치하는 레코드를 반환하는 join 유형)

select
	a.category_name,
    b.menu_name
from
	tbl_category a left join tbl_menu b -- 왼쪽을 기준으로 오른쪽 것을 넣어준다 (join한다)
    on
    a.category_code = b.category_code;
    -- 동일한 컬럼끼리 묶어준다 → on

-- right join 두 번째(오른쪽) 테이블의 모든 레코드와
-- 첫 번째(왼 쪽) 테이블에서 일치하는 레코드를 반환하는 sql join 유형
select
	a.menu_name,
    b.category_name
from
	tbl_menu a right join tbl_category b
    using
    (category_code);
    
-- cross join (잘 안 쓰인다)
-- inner join이 교집합이었다고 하면
-- cross join은 가능한 모든 조합을 반환하는 합집합의 개념이다.
select
	a.menu_name,
    b.category_name
from
	tbl_menu a cross join tbl_category b;

-- self join (같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용되는 join 유형)
select
	a.category_name,
    b.category_name
from
	tbl_category a join tbl_category b
    on
    a.ref_category_code = b.ref_category_code;
    
-- 총 정 리 --
-- 서로 다른 테이블 간의 데이터를 조회하고 싶을 때는 join을 사용한다.
-- join을 수행한ㄴ 단계를 고려할 때는
-- 1. 테이블과 테이블이 연관되어 있는지 확인
-- 2. 연관이 되어 있다고 하면, 어떤 컬럼으로 연결되어 있는지 확인
-- 3. 어떤 테이블을 기준으로 join을 수행할 것인지 (inner , left, right, cross, self)
