use chundb;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE;

-- 1. 영어영문학과(학과코드 `002`) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오. ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
select
	 STUDENT_NO AS '학번'
	,STUDENT_NAME AS '이름'
    ,ENTRANCE_DATE AS '입학년도'
from
	 TB_STUDENT
where
	DEPARTMENT_NO = '002'
order by
	ENTRANCE_DATE;
    
-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. 
select
	 PROFESSOR_NAME
    ,PROFESSOR_SSN
from
	TB_PROFESSOR
where
	char_length(PROFESSOR_NAME) != 3;
    
-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. 
-- (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
select -- 이건 못 푸3
	 PROFESSOR_NAME AS '교수이름'
    ,concat(19,LEFT(PROFESSOR_SSN, 2)) AS '나이'
    ,datediff(concat(19,LEFT(PROFESSOR_SSN, 2)),curdate()) AS '나이'
    ,datediff(concat(19,LEFT(PROFESSOR_SSN, 2)),substring(curdate(),4)) AS '나이'
from
	TB_PROFESSOR
where
	PROFESSOR_SSN like '_______1%';

-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는’이름’ 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
select
	substring(PROFESSOR_NAME,2) 이름
from
	TB_PROFESSOR;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 이때, 만 19살이 되는 해에 입학하면 재수를 하지 않은 것으로 간주한다.
select
	 STUDENT_NO
    ,STUDENT_NAME
 --   ,YEAR(now())- (IF(substring(STUDENT_SSN,1,2) BETWEEN 50 AND 99, 1900 + SUBSTRING(STUDENT_SSN,1,2), 2000 + SUBSTRING(STUDENT_SSN,1,2))) 현재나이
 -- 	,YEAR(now())- (IF(substring(STUDENT_SSN,1,2) BETWEEN 50 AND 99, 1900 + SUBSTRING(STUDENT_SSN,1,2), 2000 + SUBSTRING(STUDENT_SSN,1,2)))-19 만나이뺐음
--    ,YEAR(now()) - (YEAR(now())- (IF(substring(STUDENT_SSN,1,2) BETWEEN 50 AND 99, 1900 + SUBSTRING(STUDENT_SSN,1,2), 2000 + SUBSTRING(STUDENT_SSN,1,2)))-19) 19살되는년도
--    ,YEAR(ENTRANCE_DATE)
 --   ,YEAR(ENTRANCE_DATE) > (YEAR(now()) - (YEAR(now())- (IF(substring(STUDENT_SSN,1,2) BETWEEN 50 AND 99, 1900 + SUBSTRING(STUDENT_SSN,1,2), 2000 + SUBSTRING(STUDENT_SSN,1,2)))-19))
from
	TB_STUDENT
where
	YEAR(ENTRANCE_DATE) > (YEAR(now()) - (YEAR(now())- (IF(substring(STUDENT_SSN,1,2) BETWEEN 50 AND 99, 1900 + SUBSTRING(STUDENT_SSN,1,2), 2000 + SUBSTRING(STUDENT_SSN,1,2)))-19));
	
-- 6. 2020년 크리스마스는 무슨 요일이었는가?
select
    CASE WEEKDAY('2020-12-25')
		WHEN '0' THEN '월'
		WHEN '1' THEN '화'
		WHEN '2' THEN '수'
		WHEN '3' THEN '목'
		WHEN '4' THEN '금'
		WHEN '5' THEN '토'
		WHEN '6' THEN '일'
        END AS DAYOFWEEK;

-- 7. (번외?) `*STR_TO_DATE*('99/10/11', '%y/%m/%d')` `*STR_TO_DATE*('49/10/11', '%y/%m/%d')`은 각각 몇 년 몇 월 몇 일을 의미할까? 
--    또 `*STR_TO_DATE*('70/10/11', '%y/%m/%d')` `*STR_TO_DATE*('69/10/11', '%y/%m/%d')` 은 각각 몇 년 몇 월 몇 일을 의미할까
select
	  CONCAT(CONCAT(SUBSTRING(STR_TO_DATE ('99/10/11', '%y/%m/%d'),3,2),'년'),CONCAT(SUBSTRING(STR_TO_DATE ('99/10/11', '%y/%m/%d'),6,2),'월'),CONCAT(SUBSTRING(STR_TO_DATE ('99/10/11', '%y/%m/%d'),9,2),'일')) AS 첫번째
	  ,CONCAT(CONCAT(SUBSTRING(STR_TO_DATE ('49/10/11', '%y/%m/%d'),3,2),'년'),CONCAT(SUBSTRING(STR_TO_DATE ('49/10/11', '%y/%m/%d'),6,2),'월'),CONCAT(SUBSTRING(STR_TO_DATE ('49/10/11', '%y/%m/%d'),9,2),'일')) AS 두번째
	  ,CONCAT(CONCAT(SUBSTRING(STR_TO_DATE ('70/10/11', '%y/%m/%d'),3,2),'년'),CONCAT(SUBSTRING(STR_TO_DATE ('70/10/11', '%y/%m/%d'),6,2),'월'),CONCAT(SUBSTRING(STR_TO_DATE ('70/10/11', '%y/%m/%d'),9,2),'일')) AS 세번째
	  ,CONCAT(CONCAT(SUBSTRING(STR_TO_DATE ('69/10/11', '%y/%m/%d'),3,2),'년'),CONCAT(SUBSTRING(STR_TO_DATE ('69/10/11', '%y/%m/%d'),6,2),'월'),CONCAT(SUBSTRING(STR_TO_DATE ('69/10/11', '%y/%m/%d'),9,2),'일')) AS 네번째;

-- 8. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
select
	round (avg(point),1) as 평점
from
	tb_grade
where
	STUDENT_NO = 'A517178';
    
-- 9. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
select
	department_no 학과번호
    ,count(department_no) as '학생수(명)'
from
	tb_student
group by
	department_no;

-- 10. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오. (블로그!!!!)
select -- null은 집계조차 안 하기 떄문에 전체 검색을 해야 한다...
	count(*)
from
	TB_STUDENT
where
	coach_professor_no is null;

-- 11. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. (블로그!!!!!!!!!!!!!!)
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
select
	left(term_no,4) as 년도
    ,round(avg(POINT),1) as '년도 별 평점'
from
	TB_GRADE
where
	student_no = 'A112113'
group by -- 그룹을 그냥 term_no 잡으면 201801 201802 가 묶이지 않으니, 위에 잡아놓은 left(term_no,4) 로 잡아줘야한다.
	left(term_no,4);

-- 12. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
select -- CASE WHEN THEN ELSE END 복습
	 department_no 학과코드명
    ,SUM(CASE 
		WHEN ABSENCE_YN = 'Y' THEN 1 ELSE 0
        END) AS '휴학생 수'
from
	TB_STUDENT
GROUP BY
	DEPARTMENT_NO;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE;

