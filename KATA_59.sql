# 코드카타 59번
# 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 
#대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 
#자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 
#이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬


<초안>
#틀린이유 - 이렇게 having절에서 max(start_date)를 조건으로 주게되면
#'2022-10-16'일 이후에도 예약이 되어잇는 가장 최근의 예약건이 선택된다. 
#대여 중으로 표시해야될 기록이 대여가능으로 표시되기 있기때문에 오답.
# car_id별 최근 대여기록을 구하는게 아니기 때문에 이 방법은 옳지 않다.
SELECT car_id,
    case 
        when '2022-10-16' between start_date and end_date then '대여중'
        else '대여 가능'
        end AVAILABILITY
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
group by car_id
having max(start_date)
order by car_id desc



<정답>- 이유 : -- 
SELECT car_id,
    case 
        when car_id in (select car_id
                       from CAR_RENTAL_COMPANY_RENTAL_HISTORY
                       where '2022-10-16' between start_date and end_date
                       )
                       then '대여중'
        else '대여 가능'
        end AVAILABILITY
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
group by car_id
order by car_id desc;

1. 테이블 선택
2. 자동차 id별 그룹바이
3. select 문의 서브쿼리에서 '2022-10-16'에 대여중인 car_id를 골라서 해당되는 아이디는 대여중 아니면 대여가능으로 표시
4. order by 정렬
