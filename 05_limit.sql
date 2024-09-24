-- limit는 영문 번역 그대로 제한(한계)하는 것에 사용된다.
-- 예를 들어 select(조회) 결과에 반환할 행 개수 제환

select
	*
from
	tbl_menu; -- 상위 5개만 보고싶다면? limit
    
select
	*
from
	tbl_menu
order by
	menu_price desc
limit -- 반환 받을 행의 수 지정
	5; -- 5개의 행만 출력한다.
    
-- where → order by → limit
-- ---------------------------------------------
-- 위에 작성한 식은 반환 받을 행의 수

-- 앞으로 필기 시 [] ← 내부에 작성하는 것은 생략 가능
-- limit[offset, ] row_count
-- offset : 시작할 행의 번호 (인덱스 체계)
-- row_count : 이후 행부터 반환받을 행의 개수

select
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price desc
-- 근데 여기서 2번째 행부터 5번째 행까지만 결과를 보고싶다.
limit
	1, 4;
