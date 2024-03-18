# 코드카타 21번
# 동물보호소에 들어온 동물중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 문
# 정렬은 ID 오름차순

SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NULL
ORDER BY ANIMAL_ID;


#코드카타 22번
# 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇명인지 출력하는 SQL문

SELECT COUNT(*)
FROM USER_INFO
WHERE JOINED LIKE '2021-%' AND AGE BETWEEN 20 AND 29 ;



#코드카타 23번
# 중성화된 동물을 O ,안된 동물은 X로 표시하는 SQL문

<초안>
SELECT ANIMAL_ID, NAME, 
    CASE WHEN IF SEX_UPON_INTAKE LIKE IN ('Neutered%','Spayed%') THEN 'O'
    ELSE 'X' END 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

<2번째 답안>
SELECT ANIMAL_ID, NAME,
    CASE WHEN SEX_UPON_INTAKE LIKE 'Neutered%' OR 'Spayed%' THEN 'O' 
    ELSE 'X' END '중성화'
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

<정답으로 처리된 답안>
SELECT ANIMAL_ID, NAME,
    CASE WHEN SEX_UPON_INTAKE LIKE 'Neutered%' THEN 'O' 
    WHEN SEX_UPON_INTAKE LIKE 'Spayed%' THEN 'O' 
    ELSE 'X' END '중성화'
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

#문제 링크 https://school.programmers.co.kr/learn/courses/30/lessons/59409#qna
#1,2 번은 왜 안되는 건지 모르겠음





#코드카타 24번
#상품 카테고리 코드별 상품개수를 출력
#결과는 상품카테고리 코드를 기준으로 오름차순

SELECT SUBSTR(PRODUCT_CODE,1,2), COUNT(*)
FROM PRODUCT 
GROUP BY SUBSTR(PRODUCT_CODE,1,2)
ORDER BY PRODUCT_CODE;

<다른 정답 1.>
select LEFT(PRODUCT_CODE,2) as PRODUCT_ID,
	COUNT(PRODUCT_CODE) as PRODUCTS
from PRODUCT
group by LEFT(PRODUCT_CODE, 2)
order by PRODUCT_CODE;

<다른 정답 2.>
select LEFT(PRODUCT_CODE,2) as CATEGORY,
	COUNT(PRODUCT_CODE) as PRODUCTS
from PRODUCT
group by 1 
order by 1 



# 코드카타 25번
# 고양이와 개가 각각 몇마리인지 조회, 고양이를 먼저 출력

SELECT ANIMAL_TYPE, COUNT(*)
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE;


# 코드카타 26번
# 각 시간대 별로 입양이 몇건이나 발생했는지 조회하는 SQL문 작성, 결과는 시간대 순으로 정렬

SELECT SUBSTR(DATETIME,12,2) HOUR, COUNT(*)
FROM ANIMAL_OUTS
GROUP BY HOUR
HAVING HOUR BETWEEN 9 AND 19
ORDER BY hour;



#코드카타 27번
#2022년 5월에 예약한 환자 수를 진료과 코드별로 조회

SELECT MCDP_CD '진료과코드' , COUNT(APNT_NO) AS '5월예약건수'
FROM APPOINTMENT 
WHERE APNT_YMD BETWEEN '2022-05-01' AND '2022-05-31'
GROUP BY MCDP_CD
ORDER BY 2,1;

<다른답안1>
SELECT MCDP_CD "진료과 코드",
COUNT(*) "5월예약건수"
FROM APPOINTMENT
WHERE YEAR(APNT_YMD) = 2022 and MONTH(APNT_YMD) = 5
GROUP BY 1
ORDER BY 2, 1;



#코드카타 28번
# 12세 이하인 여자환자의 환자이름, 번호, 성별코드, 나이, 전화번호 조회

SELECT PT_NAME, PT_NO, GEND_CD, AGE, IFNULL(TLNO, 'NONE') TLNO
FROM PATIENT
WHERE AGE<=12 AND GEND_CD='W'
ORDER BY AGE DESC, PT_NAME;


#코드카타 29번
# 상반기에 판매된 아이스크림의 맛을 총주문량 기준으로 내림차순, 총 주문량이 같으면 출하번호 기준으로 오름차순 정렬
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID;



#코드카타 30번
#통풍시트, 열선시트 가죽시트 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류별로 몇대인지 출력

<초안>
SELECT CAR_TYPE , COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%통풍시트%' OR '%열선시트%' OR '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;


<2차 답안>
SELECT CAR_TYPE , COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE

# LIEK문에서 조건을 여러개 제시할 때 괄호로 묶거나 하는건 안되나?
