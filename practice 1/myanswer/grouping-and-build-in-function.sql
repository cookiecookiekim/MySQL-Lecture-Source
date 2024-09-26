use employee;
-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.
select
	 EMP_NAME as '사원명'
    ,left (EMP_NO,2) as '생년'
    ,substring(EMP_NO , 3 , 2) as '월일'
    ,substring(EMP_NO , 5 , 2) as '생일'
from
	employee;
  
-- 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회
select
	EMP_NAME as '사원명'
	,left (HIRE_DATE, 4) as '입사년도'
    ,substring(HIRE_DATE,6, 2) as '입사월'
    ,substring(HIRE_DATE,9,2) as '입사날짜'
from
	 employee;

-- WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회
select
	*
from
	employee
where
	EMP_NO like '_______2%';

-- 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력
select
	 EMP_NAME
    ,concat(left(EMP_NO,7),'*******') 주민등록번호
from
	employee;

-- EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회
select
	 EMP_NAME 사원명
	,EMAIL
    ,left(EMAIL,locate('@',EMAIL)-1) 이메일
from
	employee;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회
select
	 EMP_NAME 직원명
    ,HIRE_DATE 입사일
    ,date_add(HIRE_DATE, INTERVAL 6 MONTH) as '입사 후 6개월'
from
	employee;

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
select
	 EMP_NAME
    ,HIRE_DATE
    ,ENT_DATE
    ,ENT_YN
from
	employee
where
	HIRE_DATE < date_add(now(), interval -20 year); -- 비교 조건 기억하기.

-- EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요
select
	 EMP_NAME
    ,DATEDIFF(LAST_DAY(HIRE_DATE),HIRE_DATE) as '입사한 월 근무일수'
from
	employee;

-- EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회
select
	 EMP_NAME
    ,HIRE_DATE
    ,datediff(now(),HIRE_DATE) / 365 근무년수
from
	employee;
    
-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)
select
	*
from
	employee
where
	mod(EMP_ID, 2) = 1;
