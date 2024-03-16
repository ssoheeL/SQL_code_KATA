# 코트카타 문제 1번
# 이름이 있는 동물의 ID를 조회하는 SQL

SELECT ANIMAL_ID
from ANIMAL_INS
where NAME is not null
order by ANIMAL_ID;


#코드카타 문제 2번 
#동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요.결과는 ANIMAL_ID 역순

SELECT NAME, DATETIME
from ANIMAL_INS
order by ANIMAL_ID desc;


# 코드카타 문제 3번
#동물 보호소에 들어온 동물의 이름은 몇개인가
#이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.

SELECT count(distinct NAME)
from ANIMAL_INS
where NAME is not null;


#코드카타 문제 4번
#동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성

SELECT ANIMAL_ID, NAME
from ANIMAL_INS
order by ANIMAL_ID;



#코드카타 문제 5번 
#동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성

SELECT COUNT(*)
FROM ANIMAL_INS;



#코드카타 문제 6번
#동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 
#결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회

SELECT NAME, COUNT(ANIMAL_ID) COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(ANIMAL_ID)>=2
ORDER BY NAME;

풀이.
ANIMAL_INS 테이블 선택,
where 절에서 NAME 이 NULL값인건 제외
group by 절에서 같은이름으로 그룹화
having 절에서 개수가 2개 이상인것 필터링
select 절에서 출력할 행 선택 및 집계연산
order by 정렬 순서 지정



#코드카타 7번 
#동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순

SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION ='sick'
ORDER BY ANIMAL_ID;



#코드카타 8번
# 동물 보호소에 ㄱ장 먼저 들어온 동물의 이름을 조회하는 문

SELECT NAME
FROM ANIMAL_INS
ORDER BY DATETIME 
LIMIT 1;

#서브쿼리를 활용한 다른 답안 1.
select NAME
from ANIMAL_INS
where DATETIME = (select MIN(DATETIEM) from ANIMAL_INS)

#서브쿼리를 활용한 다른 답안 2.
select NAME
from (
	select NAME
	from ANIMAL_INS
	order by DATETIME 
)
where ROWNUM=1;




# 코드카타 9번
# 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회

SELECT MIN(DATETIME)
FROM ANIMAL_INS;



#코드카타 10번 
#동물 보호소에 들어온 동물 중 젊은 동물의 아이디와 이름을 조회, 결과는 아이디순 

SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION != 'Aged';

*where 문에서 아닌(NOT)조건을 걸 땐 != 연산자 사용 <>도 사용가능


