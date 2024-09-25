-- 24-09-25 (수) 6교시 transaction 굉장히 중요한 키워드
-- ex) 주문부터 ~ 배송까지의 모든 과정을 프로그램 상에서 transaction 이라고 한다.

-- transaction : 데이터베이스에서 ★한 번에 수행되는 작업★의 단위이다.
-- 시작, 진행, 종료 단계를 거치게 되면서 만약 중간에 예기치 못한 값 에러
-- 발생 시 rollback(시작하기 이전 단계로 돌아감)을 진행한다.
-- MySQL은 default 설정이 auto-commit(자동 저장)이기 때문에
-- 우리가 수행한 쿼리문을 돌릴 수 없다. 
-- 따라서 transaction 기능을 사용하기 위해서는 auto-commint 설정을 해제 해줘야 한다.

-- java 복습 boolean 기본값은 false, false가 정수로는 0이다.
-- 그러므로 1은 true

-- autocommint 활성화
set autocommit = 1;

-- 비활성화
set autocommit = 0; -- 방법 1
set autocommit = off; -- 방법 2

-- start transaction 구문을 작성하면 하나의 과정으로 인식하고
-- commint, rollback 과정을 수행할 수 있다.

start transaction; -- 이 이후에 작성되는 쿼리문들은 보호 받는다.
-- ★ 이 이후에 수많은 코드가 작성되고 rollback 구문 만나면 transaction 이전 구문으로 돌아간다. ★

select * from tbl_menu;

-- dml 수정, 삭제, 삽입 진행
insert into tbl_menu values (null, '해장국', 9000, 2, 'Y');
update tbl_menu set menu_name = '해장끝' where menu_code = 28;

-- 작성한 dml 구문이 에러나 이상한 값이 없다면 직접 commit을 해줘야 반영이 된다.
commit;

rollback;
