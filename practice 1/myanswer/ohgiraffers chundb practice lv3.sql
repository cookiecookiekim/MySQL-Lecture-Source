use chundb;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE;
-- level 3

-- 1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
select
	STUDENT_NAME AS '학생 이름'
    ,STUDENT_ADDRESS AS '주소지'
from
	TB_STUDENT
order by
	STUDENT_NAME;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
select
	 STUDENT_NAME
    ,STUDENT_SSN
from
	TB_STUDENT
where
	ABSENCE_YN = 'Y'
order by
	concat(case
		when substring(student_ssn, 8 , 1) in (1,2) then concat('19' , substring(student_ssn, 1 , 2))
        when substring(student_ssn, 8 , 1) in (3,4) then concat('20' , substring(student_ssn, 1 , 2)) 
        end,substring(student_ssn,3,4)) desc;

-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
select -- 맞긴한거같은데 난 87ROWS 정답은 88ROWS란다..
	STUDENT_NAME AS '학생이름'
    ,STUDENT_NO AS '학번'
    ,STUDENT_ADDRESS AS '거주지 주소'
from
	TB_STUDENT
where
	(STUDENT_ADDRESS LIKE '경기%' || STUDENT_ADDRESS LIKE '강원%') && ENTRANCE_DATE LIKE '202%'
order by
	STUDENT_NAME;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
select
	 PROFESSOR_NAME
    ,PROFESSOR_SSN
from
	TB_PROFESSOR
where
	DEPARTMENT_NO = '005'
order by
	PROFESSOR_SSN;

-- 5. 2022 년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
select -- 모야 되게 간단하네... 답만 맞으면 된건가!
	 STUDENT_NO
    ,POINT
from
	TB_GRADE
where
	CLASS_NO = 'C3118100' && TERM_NO = '202202'
order by
	point desc;

-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
select -- 정답!
	 s.STUDENT_NO
    ,s.STUDENT_NAME
    ,d.DEPARTMENT_NAME
from
	TB_STUDENT s
    join
    TB_DEPARTMENT d on s.DEPARTMENT_NO = d.DEPARTMENT_NO
order by
	STUDENT_NAME asc;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
select -- 정 답!!!!
	 CLASS_NAME
    ,DEPARTMENT_NAME
from
	 TB_CLASS c
     join
     TB_DEPARTMENT d on c.DEPARTMENT_NO = d.DEPARTMENT_NO
order by
	DEPARTMENT_NAME;
    
-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select
	  a.CLASS_NAME
     ,r.PROFESSOR_NAME
from
    TB_CLASS a
    join
    TB_CLASS_PROFESSOR p on a.CLASS_NO = p.CLASS_NO
    join
    TB_PROFESSOR r on r.PROFESSOR_NO = p.PROFESSOR_NO;
    
-- 9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select
	 CLASS_NAME
	 ,PROFESSOR_NAME
from
	TB_CLASS c
    join
    TB_DEPARTMENT d on c.DEPARTMENT_NO = d.DEPARTMENT_NO
    join
    TB_CLASS_PROFESSOR p on c.CLASS_NO = p.CLASS_NO
    join
    TB_PROFESSOR e on e.PROFESSOR_NO = p.PROFESSOR_NO
where
	CATEGORY = '인문사회';
    
-- 10. ‘음악학과’ 학생들의 평점을 구하려고 한다.
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
select -- 쉬운 거 같은데 애먹었3!!! group by에 내림차순 바로 못 하나~?
	  s.STUDENT_NO
     ,s.STUDENT_NAME
     ,round(avg(g.point),1)
from
    TB_GRADE g
    join
    TB_STUDENT s on s.student_no = g.student_no
    join
    TB_DEPARTMENT d on s.DEPARTMENT_NO = d.DEPARTMENT_NO
where
	d.DEPARTMENT_NAME = '음악학과'
group by
	STUDENT_NO
order by
    STUDENT_NO desc;
    
-- 11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오. 
-- 단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.
select -- 답이 이상하다! 난 경제학과 손건영의 지도교수가 두명으로 나온다(노인순, 노현주)
	 d.DEPARTMENT_NAME as '학과이름'
    ,s.STUDENT_NAME as '학생이름'
    ,p.PROFESSOR_NAME as '지도교수이름'
from
	TB_STUDENT s
    join
    TB_DEPARTMENT d on s.DEPARTMENT_NO = d.DEPARTMENT_NO
    join
    TB_PROFESSOR p on d.DEPARTMENT_NO = p.DEPARTMENT_NO
WHERE
	STUDENT_NO = 'A313047';

-- 12. 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
select -- 정답!!
	 s.STUDENT_NAME
    ,g.TERM_NO
from
	TB_STUDENT s
    join
    TB_GRADE g on s.STUDENT_NO = g.STUDENT_NO
    join
    TB_CLASS c on g.CLASS_NO = c.CLASS_NO
where
	c.CLASS_NAME = '인간관계론' && g.TERM_NO LIKE '2022__';

-- 13. 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
select -- 정답은 44rows인데 나는 49rows이다.. 뭐가 잘못됐나~~ 답이 잘못됐으면.. ^ㅠ^
	 c.CLASS_NAME
    ,d.DEPARTMENT_NAME
from
	TB_DEPARTMENT d
    join
    TB_STUDENT s on d.DEPARTMENT_NO = s.DEPARTMENT_NO
    join
    TB_CLASS c on d.DEPARTMENT_NO = c.DEPARTMENT_NO
where
	COACH_PROFESSOR_NO is null && CATEGORY = '예체능';
    
-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
-- 학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우 "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오. 
-- 단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다.
select -- from 말고도 where나 셀렉트에 별칭 꼭 넣어주기!! (근데 답은 14rows인데 저는 13 나옵니다..)
	   s.STUDENT_NAME AS '학생이름'
      ,if(s.COACH_PROFESSOR_NO is not null, p.PROFESSOR_NAME, '지도교수 미지정') AS '지도교수'
from
	TB_PROFESSOR p
    join
    TB_STUDENT s on p.PROFESSOR_NO = s.COACH_PROFESSOR_NO
    join
	TB_DEPARTMENT d on p.DEPARTMENT_NO = d.DEPARTMENT_NO
where
	s.DEPARTMENT_NO = 020
order by
	ENTRANCE_DATE;

-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
select -- 저는 39rows가 나옵니다.. 답은 19 rows 입니다....
	 s.STUDENT_NO as '학번'
    ,s.STUDENT_NAME as '이름'
    ,d.DEPARTMENT_NAME as '학과이름'
    ,round(avg(g.POINT),1) as '평점'
from
	TB_STUDENT s
    join
    TB_GRADE g on s.STUDENT_NO = g.STUDENT_NO
    join
    TB_DEPARTMENT d on s.DEPARTMENT_NO = d.DEPARTMENT_NO
where
	s.ABSENCE_YN = 'N'
group by
	s.STUDENT_NO, s.STUDENT_NAME, d.DEPARTMENT_NAME
having
	round(avg(g.POINT),1) >= 4
order by
	s.STUDENT_NO;

-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
select -- 정답!!
	 c.CLASS_NO   
    ,c.CLASS_NAME
	,avg(POINT)
from
	TB_CLASS c
    join
    TB_GRADE g on c.CLASS_NO = g.CLASS_NO
    join
    TB_DEPARTMENT d on c.DEPARTMENT_NO = d.DEPARTMENT_NO
where
	d.DEPARTMENT_NAME = '환경조경학과' && CLASS_TYPE like '전공%'
group by
	c.CLASS_NO , c.CLASS_NAME;

-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.




select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE;
