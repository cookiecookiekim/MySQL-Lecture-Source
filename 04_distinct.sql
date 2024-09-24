-- disdinct
-- 중복된 값을 제거하는 데 사용된다.
-- 컬럼내에 컬럼 값들의 종류 쉽게 파악 가능

-- 단일 열(컬럼) 중복 제거 예시
select
	distinct category_code -- 중복 요소 다 제거되고 출력
-- distinct로 중복 요소를 삭제한 게 아니라 모아둔 것이다!
from
	tbl_menu
order by
	category_code;

-- 다중 열(컬럼) 중복 제거 예시
-- 다중열의 값들이 모두 동일하면!!! 중복된 것으로 판단한다.
select -- 다중열 예시를 보기 위한 기본 출력구문
	category_code,
    orderable_status
from
	tbl_menu;

select distinct -- distinct를 이용하여 모두 중복된 애들이 제거됐다
	category_code,
    orderable_status
from
	tbl_menu;