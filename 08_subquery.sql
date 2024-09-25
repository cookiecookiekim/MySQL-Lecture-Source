-- 24-09-25 2교시 서브 쿼리문
-- select , from 까지를 메인 쿼리문
-- 또하나의 쿼리문을 작성하는 게 서브 쿼리문이다.

-- 문제 1 :메뉴 테이블에서 민트미역국과 같은 카테고리 코드를 가지고 있는 메뉴 조회
select
	category_code
from
	tbl_menu
where
	menu_name = '민트미역국'; -- 민트미역국이 몇번 카테고리에 있는지 확인 (4)

select
	*
from
	tbl_menu
where
	category_code = 4; -- 4번 조회하여 답 확인..
    
-- 반칙을 쓰지 않는 한 1개의 쿼리문으로 절대 할 수 없다.

-- subquery란?
-- main쿼리에서 수행되는(다른 쿼리문에서 실행되는) 쿼리문

select
	*
from
	tbl_menu
where
	category_code = (
						select
							category_code
						from
							tbl_menu
						where
							menu_name = '민트미역국'); -- 이렇게 서브 쿼리문을 넣으면 한 번에 결과를 얻을 수 있다.
                            
-- 가장 많은 메뉴가 포함된 카테고리 조회
select
	count(*) as 'count'
from
	tbl_menu
group by
	category_code;

-- max() 함수 : 최대값, min() 함수 : 최소값
-- from절에 사용하는 서브 쿼리는 파생테이블(derived table)이라고 불리우며 
-- 파생 테이블은 반드시 별칭을 가지고 있어야 한다.
select
	max(count)
from
	(select
		count(*) as 'count'
	from
		tbl_menu
	group by
		category_code) as countmenu;
        
-- 상관 서브쿼리 --
-- 메인 쿼리문이 서브쿼리의 결과에 영향을 주는 경우를 상관 서브 쿼리라고 한다.
-- 카테고리 별 평균 가격보다 높은 가격의 메뉴 조회하기

select
	a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
from
	tbl_menu a
where
	menu_price > (
					select
						avg(menu_price)
                    from
						tbl_menu
                    where
						category_code = a.category_code
				);
-- 서브쿼리문은 언제 쓸까~? 앞으로 하나의 쿼리문으로 안 될 때 접근하면 된다.
-- CTE (Common Table Expression)

-- 파생 테이블과 비슷한 개념이며, 코드의 가독성과 재사용성을 위해 파생 테이블 대신 사용하게 된다.)
-- → from 절에서만 사용된다. (join일 시 join 구문에서도 사용 가능)

with menucte as ( -- 가상의 절(테이블)을 사용한다.(1회성, 식이 끝나면 없어짐) → cte
	select
		menu_name,
        category_name
	from
		tbl_menu a
        join -- 두가지 테이블을 엮을건데
        tbl_category b
        on a.category_code = b.category_code -- 어떤 컬럼으로 엮을건지.
)
select
	*
from
	menucte
order by -- 정렬을 할 거다
	menu_name; -- 메뉴 이름을 기준을고

