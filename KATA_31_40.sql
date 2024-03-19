#코드카타 31번
# 아직 입양을 못 간 동물중, 가장 오래 보호소에 있었던 동물 3마리

SELECT ins.name, ins.datetime
from animal_ins as ins left join animal_outs as outs on ins.animal_id = outs.animal_id
where outs.animal_id is null
order by ins.datetime
limit 3;

1.보호소 테이블과 입양테이블 조인시 where 절에서 입양테이블 key is null값을 조건으로 걸어
보호소에 남은 동물들만 출력.
2. 출력할 컬럼 선택
3. 보호소 입소 시간으로 정렬
4. 출력할 행 개수 선택

<다른 답안>
select name, datetime
from animal_ins
where animal_id not in (select animal_id from animal_outs)
order by datetime
limit 3


# 코드카타 32번
# 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리, 총 판매량 리스트 출력

SELECT book.category, sum(bs.sales) total_sales
from book join book_sales as bs on book.book_id = bs.book_id
where bs.sales_date like '2022-01%'
group by book.category
order by book.category;

1.도서정보와 판매 테이블 조인(도서정보테이블은 반드시 판매테이블의 하나와 매핑된다)
2.팬매날짜 2022-01 조건설정
3. 카테고리별로 그룹화
4. 판매량 합
5. 정렬

<다른 답안> - 서브쿼리 사용
select category, sum(total_sales) total_sales
from (
	select * sum(sales) total_sales
	from book_sales
	where year(sales_date) = 2022 and month(sales_date)=1
	group by book_id
	)sub
	natural join book
	group by category
	order by category
	
	
#코드카타 33번 
#상품별 오프라인 매출구하기
	
<초안>
select substr(product.product_code,1,2) product_code, 
	sum(offline_sale.sales_amount)*product.price sales
from product join 
	(SELECT product_id , sum(sales_amount) sales_amount
	from offline_sale
	group by product_id) as offline_sale 
	on product.product_id = offline_sale.product_id
group by substr(product.product_code,1,2)
order by 2 desc, 1 

<정답>
select product.product_code, sum(offline_sale.sales_amount)*product.price sales
from product join 
(SELECT product_id , sum(sales_amount) sales_amount
from offline_sale
group by product_id) as offline_sale on product.product_id = offline_sale.product_id
group by product.product_code
order by 2 desc, 1

초안에서 상품코드에서 앞자리 두개를 추출해서 그룹화 했으므로 카테고리별로 그룹화 했었음 -> 오답이유


<다른 정답>
select product.product_code, sum(product.price * offline_sale.sales_amount) as sales
from product join offline_sale on product.product_id= offline_sale.product_id
group by product.product_code
order by sales desc, product_code 




#코드카타 34번
# 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회
# 보호 시작일이 빠른 순으로 조회

SELECT ins.animal_id, ins.name
from animal_outs as outs join animal_ins as ins on outs.animal_id = ins.animal_id
where ins.datetime>outs.datetime
order by ins.datetime ;


#코드카타 35번
# 입양간 동물 중 보호기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회
# 결과는 보호기간이 긴 순으로 조회

select animal_id, name
from(
SELECT ins.animal_id, ins.name , datediff(outs.datetime, ins.datetime) diff
from animal_ins as ins join animal_outs as outs on ins.animal_id = outs.animal_id
where outs.datetime> ins.datetime) A
order by diff desc
limit 2

<order by 에 날짜 계산식을 사용해서 바로 적용가능함 >
SELECT ins.animal_id, ins.name 
from animal_ins as ins join animal_outs as outs on ins.animal_id = outs.animal_id
where outs.datetime> ins.datetime
order by datediff(outs.datetime, ins.datetime) desc
limit 2



# 코드카타 36번
# 보호소에서 중성화 수술을 거친 동물의 정보, 아이디 순으로 조회

SELECT outs.animal_id, ins.animal_type, outs.name
from animal_ins as ins join animal_outs as outs on ins.animal_id = outs.animal_id
where  ins.sex_upon_intake like 'Intact%' and outs.sex_upon_outcome regexp 'Spayed|Neutered'
order by outs.animal_id 

1.보호소 테이블, 입양테이블 이너조인(=> 입양간 동물들만 출력됨)
2.조건절에서 입소당시 중성화 여부 and 입양시 중성화 여부 *regexp 표현쓸 때 주의



#코드카타 37번
#경제 카테고리에 소하는 도서들의 도서id 저자명, 출판일 리스트 출력
# 출판일 기준으로 오름차순

SELECT book.book_id, author.author_name, date_format(book.published_date, '%Y-%m-%d') published_date
from book join author on book.author_id = author.author_id
where book.category ='경제'
order by book.published_date ;


#코드카타 38번
# 5월 1일을 기준으로 주문id, 제품id 출고일자, 출고여부를 조회 
# 5/1일까지 출고완료, 이후날자는 출고대기, 미정이면 출고미정출력

SELECT order_id, product_id, date_format( out_date, '%Y-%m-%d') out_date,
    case when out_date <= '2022-05-01' then '출고완료'
    when out_date is null then '출고미정'
    else '출고대기' end '출고여부'
from food_order 
order by order_id;


#코듣카타 39번
# 상반기 동안 각 아이스크림 성분 타입과 성분타입에 대한 아이스크림의 총 주문량

SELECT I.INGREDIENT_TYPE, sum(F.total_order) total_order
from first_half as F join icecream_info as I on F.flavor = I.flavor
group by I.INGREDIENT_TYPE
order by 2;


# 코드카타 40번
# 동물 보호소에 들어온 이름이 lucy, elia,pickle,rogan,sabrina, mitty인 동물의 아이디와 이름 성멸 중성화여부 출력

SELECT animal_id, name, sex_upon_intake
from animal_ins
where name in ( 'Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
order by animal_id ;