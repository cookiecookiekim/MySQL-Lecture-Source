use employee;
    
-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)

select
	e.EMP_ID
    ,e.EMP_NAME
    ,j.JOB_NAME
    ,d.DEPT_TITLE
    ,l.LOCAL_NAME
    ,e.SALARY
from
	employee e
    join JOB j on j.JOB_CODE = e.JOB_CODE
    join DEPARTMENT d on d.DEPT_ID = e.DEPT_CODE
    join LOCATION l on l.LOCAL_CODE = d.LOCATION_ID
where
	j.JOB_NAME = '대리' && l.LOCAL_NAME like 'ASIA%';
	
-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)
select -- 정답!
	 e.EMP_NAME
    ,e.EMP_NO
    ,d.DEPT_TITLE
    ,j.JOB_NAME
from
	employee e
    join department d on e.DEPT_CODE = d.DEPT_ID
    join job j on e.JOB_CODE = j.JOB_CODE
where
	EMP_NAME like '전%' && EMP_NO like '7%' && EMP_NO like '_______2%';

-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)
select -- 정답!
	 e.EMP_ID
    ,e.EMP_NAME
    ,j.JOB_NAME
from
	employee e
    join job j on e.JOB_CODE = j.JOB_CODE
where
	e.EMP_NAME like '%형%';

-- 4. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)
select -- 정답!
	e.EMP_NAME
	,j.JOB_NAME
    ,e.DEPT_CODE
    ,d.DEPT_TITLE
from
	employee e
    join department d on e.DEPT_CODE = d.DEPT_ID
    join job j on e.JOB_CODE = j.JOB_CODE
where
	d.DEPT_TITLE like '%해외영업%';

-- 5. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)

select -- 정답!
	 e.EMP_NAME
	,e.BONUS
    ,d.DEPT_TITLE
    ,l.LOCAL_NAME
from
	 employee e
     join department d on e.DEPT_CODE = d.DEPT_ID
     join location l on d.LOCATION_ID = l.LOCAL_CODE
where
	e.BONUS is not null;

-- 6. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)
select -- 정답!
	e.EMP_NAME
    ,j.JOB_NAME
    ,d.DEPT_TITLE
    ,l.LOCAL_NAME
from
	employee e
    join job j on e.JOB_CODE = j.JOB_CODE
    join department d on d.DEPT_ID = e.DEPT_CODE
    join location l on d.LOCATION_ID = l.LOCAL_CODE
where
	e.DEPT_CODE = 'D2';

-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오. (ifnull) 0 이면 null로 대체
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)

select -- 다시!
	e.EMP_NAME
    ,j.JOB_NAME
    ,e.SALARY
    ,e.SALARY * 12 + (e.SALARY * IFNULL (e.BONUS,0)) as '보너스 포함 연봉'
from
	employee e
    join job j on e.JOB_CODE = j.JOB_CODE
    join sal_grade s on e.SAL_LEVEL = s.SAL_LEVEL
where
	s.MIN_SAL < e.SALARY;


-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
select -- 정답!
	e.EMP_NAME
    ,d.DEPT_TITLE
    ,l.LOCAL_NAME
    ,n.NATIONAL_NAME
from
	employee e
    join department d on d.DEPT_ID = e.DEPT_CODE
    join LOCATION l on d.LOCATION_ID = l.LOCAL_CODE
    join NATION n on l.NATIONAL_CODE = n.NATIONAL_CODE
where
	NATIONAL_NAME = '한국' || NATIONAL_NAME = '일본';
    
