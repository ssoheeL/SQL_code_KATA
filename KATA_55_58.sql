#코드카타 55번
#중고거래 게시물을 3건 이상 등록한 사용자의 사용자 id, 닉네임, 전체주소, 전화번호 조희

select user_id, nickname, concat(city,' ',street_address1,' ',street_address2) address,
concat(substring(tlno,1,3),'-',substring(tlno,4,4),'-',substring(tlno,8,4)) tlno
from USED_GOODS_USER as users
where user_id in (select writer_id
             from USED_GOODS_BOARD as board
            where board.writer_id = users.user_id
            group by writer_id
              having count(*)>=3)
order by user_id desc

1.user_goods_user 테이블 선택
2-1.where 절에서 조건에 맞는 user_id 셀렉
2-2 board 테이블에서 작성자별로 그룹바이 후 게시글 개수 count
2-3 게시글이 3개가 넘는 작성자아이디만 출력
3. 원하는 값 출력
4. 정렬


#코드카타 56번
#네비게이션 옵션이 포함된 자동차 리스트 출력

SELECT car_id, car_type, daily_fee, options
from car_rental_company_car
where options like '%네비게이션%'
order by car_id desc;



# 코드카타 57번
# 2022년 10월 5일에 등록된 중고거래 게시물을 작성하는 쿼리문

SELECT board_id, writer_id, title, price,
    case when status = 'SALE' then '판매중'
    when status = 'RESERVED' then '예약중'
    when status = 'DONE' then '거래완료' end status
from USED_GOODS_BOARD
where created_date like '2022-10-05%'
order by board_id desc;


#코드카타 58번
#2022-04-13일 취소되지 않은 흉부외과 진료 예약 내역을 조회

-- 코드를 입력하세요
with temp as(
SELECT *
from appointment
where apnt_ymd like '2022-04-13%' and apnt_cncl_yn = 'N' and mcdp_cd = 'cs')

select temp.APNT_NO, patient.PT_NAME, patient.PT_NO, temp.MCDP_CD,doctor.DR_NAME, temp.apnt_ymd
from doctor 
inner join temp 
inner join patient
where doctor.dr_id = temp.mddr_id
and temp.PT_NO = patient.pt_no
order by temp.apnt_ymd ;