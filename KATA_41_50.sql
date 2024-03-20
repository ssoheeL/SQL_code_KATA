#코드카타 41번
#테이블에서 2021년에 출판된 카테고리가 인문에 속하는 도서리스트 출력

SELECT book_id, date_format( published_date, '%Y-%m-%d') published_date
from book
where published_date like '2021%' and category ='인문'
order by published_date;



#코드카타 42번 
#자동차 종류가 SUV인 자동차들의 평균 일일 대여 요금 출력

SELECT round(avg(daily_fee),0) average_fee
from car_rental_company_car
where car_type ='SUV';


#코드카타 43번
# 완료된 중고 거래의 총 금액이 70만원 이상인 사람의 id,닉네임, 총거래 금액 조회

SELECT users.user_id, users.nickname,sum(board.price) total_price
from used_goods_board as board join used_goods_user as users on board.writer_id = users.user_id
where board.status = 'DONE'
group by users.user_id
having sum(board.price) >=700000
order by total_price;



#코드카타 44번
#만원 단위의 가격대 별로 상품개수를 출력하는 쿼리문

select (price div 10000)*10000 as price_group , count(price div 10000) products
from product
group by price div 10000
order by price_group;


<다른 답>
SELECT FLOOR(PRICE / 10000) * 10000 AS `PRICE_GROUP`, 
    COUNT(*) AS PRODUCTS
    FROM PRODUCT
GROUP BY `PRICE_GROUP`
ORDER BY `PRICE_GROUP`;


#코드카타 45번
#생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일 조회

SELECT member_id, member_name, gender, date_format(date_of_birth, '%Y-%m-%d') date_of_birth
from MEMBER_PROFILE
where tlno is not null and date_of_birth like '%-03-%' and gender ='W'
order by member_id;


#코드카타 46번
#자동차 종류가 세단인 자동차들 중 10월에 대여를 시작한 기록이 이쓴ㄴ 자동차 ID 리스트 출력

exists 철자 주의
select distinct car_id
from CAR_RENTAL_COMPANY_CAR as R
where EXISTS (SELECT * 
             from CAR_RENTAL_COMPANY_RENTAL_HISTORY as H
             where R.car_id = H.car_id and H.start_date like '%-10-%') 
             and car_type ='세단'
order by car_id desc;



#코드카타 47번
# 모든 레코드 출력

SELECT *
from animal_ins;


#코드카타 48번
#음식종류별로 즐겨찾기수가 가장 많은 식당의 음식종류 id, 식당이름, 즐겨찾기 수를 조회하는 SQL 문을 작성

select A.food_type, A.rest_id, A.rest_name,A.favorites
from
(SELECT rest_id, rest_name, food_type, favorites,
    rank() over(partition by food_type order by favorites desc) as 'rank'
from rest_info) A
where A.rank='1'
order by A.food_type desc;

<다른 답안>

SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM REST_INFO A
WHERE (FOOD_TYPE,FAVORITES) 
IN 
(
    SELECT FOOD_TYPE, MAX(FAVORITES) 
    FROM REST_INFO B
    WHERE A.FOOD_TYPE = B.FOOD_TYPE 
)
ORDER BY FOOD_TYPE DESC;


#코드카타 49번
#식품 분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회
#분류가 과자, 국, 김치, 식용유 인경우만 출력하고 결과는 식품가격을 기준으로 내림차순

SELECT category, price max_price, product_name
from food_product A
where (category, price) in (select category , max(price)
                           from food_product 
                           group by category)
    and CATEGORY in ('과자','국','김치','식용유')
order by price desc;




#코드카타 50번
#생산일자가 2022년 05월 식품들의 식품 id, 식품이름, 총매출 조회
#총매출 기준으로 내림차순 , 같다면 식품 id기준으로 오름차순


SELECT product.product_id, product.product_name, sum(orders.amount * product.price) total_price
from food_product as product join food_order as orders on product.product_id = orders.product_id
where orders.produce_date like '2022-05-%'
group by product.product_id
order by total_price desc, 1

1.product 테이블과 order 테이블 join
2. 조건절에서 생산일자 5월달만 선택
3. group by로 상품아이디별로 그룹화
4. 상품아이디별 총 금액 구함
5. 정렬


<다른 답안>---with 사용
with temp as (
	select product_id, sum(amount) as amount
	from food_order
	where year(produce_date) = 2022 and month(produce_date) = 05
	group by product_id
	)
	
select T.product_id, p.product_name, t.amount*p.price
from temp t inner join food_product p on t.product_id = p.product_id
orde by 3 desc,1
