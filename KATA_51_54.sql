#코드카타 51번
#입양을 간 기록은 있는데 보호소에 들어온 기록이 없는 동물의 id,이름 출력

-- exists 문을 이용해 풀어본 것--
SELECT animal_id, name
from animal_outs as o
where not exists (select *
                 from animal_ins as i
                 where I.animal_id = O.animal_id)
order by animal_id;

<다른답안> ---left join에서 null값을 이용해 풀어본 것
SELECT o.animal_id, o.name
from animal_outs as o left join animal_ins as I on o.animal_id= i.animal_id
where I.animal_id is null
order by o.animal_id;


#코드카타 52번
# 총 주문량이 3,000 보다 높으면서 아이스크림의 주 성분이 과일인 아이스크림의 맛을 조회
SELECT i.flavor
from FIRST_HALF as H join ICECREAM_INFO as I on H.flavor = I.flavor
where h.total_order >=3000 and i.INGREDIENT_TYPE = 'fruit_based'
order by h.total_order desc;

<다른 답> ---- 조건절에 서브쿼리사용
select flavor
from firs_half
where flavor in (select flavor
				from icecream_info
				where infredient_type = 'fruit_based')
	and total_order>=3000
	
			
	
#코드카타 53번
#동일한 회원이 동일한 상품을 재구매한 데이터를 구하여 재구매한 회원id와 재구매한 상품 id를 출력하는 sql문

	SELECT user_id, product_id
from online_sale
group by user_id, product_id
having count(*)>1
order by user_id, product_id desc;

#코드카타 54번
#가장 최근에 들어온 동물의 시간
SELECT max(datetime)
from animal_ins;

#