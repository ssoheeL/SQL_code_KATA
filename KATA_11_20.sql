# 코드카타 11번
# 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성
# 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘

SELECT ANIMAL_ID , NAME , DATETIME
FROM ANIMAL_INS
ORDER BY NAME,DATETIME desc


# 코드카타 12 번
# 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문
# 결과는 이름순으로 조회


SELECT ANIMAL_ID , NAME
FROM ANIMAL_INS
WHERE NAME LIKE '%EL%' AND ANIMAL_TYPE='Dog'
ORDER BY NAME;


#코드카타 13번
# 나이정ㅗ가 없는 회원이 몇명인지 출력

SELECT COUNT(*) USERS 
FROM USER_INFO
WHERE AGE IS null;


#코드카타 14번
#판매 상품 중 가장 높은 판매가를 출력하는 문

select MAX(PRICE) MAX_PRICE
from PRODUCT;



#코드카타 15번
#동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문
#이름이 없는 동물의 이름은 "No name"으로 표시

<초안>
SELECT ANIMAL_TYPE, 
    CASE WHEN NAME IS NULL THEN 'No Name'// 틀린이유 조건은 "No name"
    ELSE NAME END NAME, 
    SEX_UPON_INTAKE
FROM ANIMAL_INS;

<다른 답안>
//null 값은 IFNULL 사용시 편하게 처리 가능하다
SELECT ANIMAL_TYPE, IFNULL(NAME, 'No name') NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;


#코드카타 16번
# 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회
#냉동시설 여부가 NULL일 경우 'N'으로 출력
#결과는 창고 ID기준 오름차순 정렬

SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, IFNULL(FREEZER_YN,'N') FRESSZER_YN
FROM FOOD_WAREHOUSE
WHERE ADDRESS LIKE '경기도%'
ORDER BY WAREHOUSE_ID 


#코드카타 17번
# 강원도에 위치한 식품공장의 공장 ID, 공장이름, 주소 조회, 결과는 공장ID 오름차순

SELECT FACTORY_ID, FACTORY_NAME, ADDRESS
FROM FOOD_FACTORY
WHERE ADDRESS LIKE '강원도%'
ORDER BY FACTORY_ID;



#코드카타 18번
# 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜를 조회하는 SQL문을 작성해주세요. 이때 결과는 아이디 순

sql에서 날짜형식으로 변환할 때 DATE_FORMAT()함수 사용
SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, '%Y-%m-%d')
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;


#코드카타 19번 
#진료과가 흉부외과이거나 일반외과인 의사의 이름, 의사 ID, 진료과, 고용일자 조회
#결과는 고용일자기준 내림차순, 고용일자가 같을 경우 이름 기준 오름차순 정렬

SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d') HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD IN ('CS', 'GS')
ORDER BY HIRE_YMD DESC, DR_NAME ;


#코드카타 20번
#테이블에서 가격이 제일 비싼 식품의 ID, 이름, 코드, 식품분류, 가격을 조회
# WHERE 절에서 서브쿼리사용해서 조건 설정
SELECT *
FROM FOOD_PRODUCT
WHERE PRICE = (SELECT MAX(PRICE) FROM FOOD_PRODUCT)


<다른사람 쿼리>
#PRICE 내림차순으로 정렬 후 가장 상단의 값 출력
SELECT *
from FOOD_PRODUCT
ORDER BY PRICE DESC
LIMIT 1


두 쿼리의 차이
- max 값이 같은 제품이 여러개인 경우 max()는 해당하는 모든 제품들을 다 보여주고,
- limit을 이용하면 가장 큰 하나 밖에 안보여줍니다.
