-- 24-09-25, 3교시 연산(operators)

-- set 연산자는 두 개 이상의 select문 결과 집합을 결합하는데 사용.
-- 주의해야할 점은 결합하는 결과 집합의 컬럼이 일치해야 한다.

-- union
-- 두 개 이상의 select문의 결과를 결합하여 중복된 레코드는 제거한 후 반환

-- 1번째 쿼리문
select
	*
from
	tbl_menu
where
	category_code = 10

union -- 1번째 쿼리문 + 2번째 쿼리문 (중복 제거)

-- 2번째 쿼리문
select
	*
from
	tbl_menu
where
	menu_price < 9000;
    
-- union all
-- 두 개 이상의 select문의 결과를 결합하여 중복된 레코드는 제거하지 않고 반환하는 sql 연산자

select
	*
from
	tbl_menu
where
	category_code = 10

union all-- 1번째 쿼리문 + 2번째 쿼리문 (중복 포함되어 출력)

-- 2번째 쿼리문
select
	*
from
	tbl_menu
where
	menu_price < 9000;

-- intersect
-- 두 쿼리문의 결과 중 공통되는 레코드만 반환하는 연산자
-- 하지만 MySQL에서는 제공하지 않는다.
-- MySQL에서는 inner join 또는 in 연산자를 통해서 intersect를 대체할 수 있음.

select
	*
from
	tbl_menu a
	inner join
    (
		select
			*
		from
			tbl_menu
		where
			menu_price < 9000
    ) b -- 이거 자체가 테이블이므로 마지막에 별첨 b 
    on (a.menu_code = b.menu_code) -- 교집합 설정
where
	a.category_code = 10;
    
-- in 연산자를 사용한 intersect
select
	*
from
	tbl_menu
where
	category_code = 10
    and
    menu_code in (
					select
						menu_code
					from
						tbl_menu
					where
						menu_price < 9000
				);
-- MINUS
-- 첫 번쨰 select문의 결과에서 두 번째 select문의 결과가 포함 된
-- 레코드를 제외한 레코드를 반환하는 연산자 = 차집합
-- 하지만 MySQL에서는 MINU를 지원하지 않는다.
-- 그래도 우리는 left join을 이용해서 구현 가능
select
	*
from
	tbl_menu a
	left join ( -- 오로지 왼쪽 조건을 위한 join이다.
			select
				*
			from
				tbl_menu
			where
				menu_price < 9000
			) b
			on (a.menu_code = b.menu_code)
where
	a.category_code = 10 -- 카테고리 코드 10은 만족한다
    and
    b.menu_code is null; -- 9000원 미만은 만족하지 않는다. (카테고리 코드가 10이면서, 가격이 9000 초과 출력)
	

