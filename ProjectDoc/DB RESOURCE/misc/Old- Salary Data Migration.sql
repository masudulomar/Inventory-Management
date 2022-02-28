
delete from innovation.prms_transaction p where p.entity_number=1
and p.branch_code in ('9999E','9999') 
and p.sal_year=2020
and p.month_code=2;

insert  into innovation.prms_transaction
select 1 Entity,
       '9999' barnch,
       t.acc_no,
       t.sal_year,
       t.month_code,
       t.sal_month,
       t.basic_pay,
       t.medical_allowance,
       t.house_rent_allowance,
       t.tel_allowance,
       t.trans_allowance,
       t.edu_allowance,
       t.wash_allowance,
       t.pension_allowance,
       t.entertainment,
       t.domestic_allowance,
       t.other_allowance,
       t.gross_pay_amt,
       t.hbadv_deduc,
       t.mcycle_deduc,
       t.bicycle_deduc,
       t.pfadv_deduc,
       t.pension_deduc,
       t.revenue_deduc,
       t.welfare_deduc,
       t.carfare_deduc,
       t.caruse_deduc,
       t.gas_bill,
       t.water_bill,
       t.electricity_bill,
       t.house_rent_deduc,
       t.news_paper_deduc,
       t.net_ded_amt,
       t.net_pay_amt,
       t.pf_deduction,
       t.hbadv_arrear_deduc,
       t.pfadv_arrear_deduc,
       t.tel_excess_bill,
       t.gen_insurence,
       t.sp_deduc,
       t.sp_description,
       '' remarks,
       t.dearness_allowance,
       t.arrear,
       t.other_deduc,
       t.hbadv_deduc_percent,
       t.tot_sal_allowance,
       t.increment_date,
       t.arrear_basic,
       t.instl_amt_tlo,
       t.instl_amt_tlr,
       t.instl_amt_ins,
       t.instl_amt_inc,
       t.office_code,
       t.comp_deduc,
       'MIG',
       trunc(sysdate),
       t.sp_deduc income_tax,
       0 income_arrear,
       0 hill_allowance,
       0 actual_basic,
       '' r1,
       '' r3
  from sal_transaction t
 where t.office_code in (2,1, 5, 0, 8,26,17,25,22, 19,18, 23,24,12,6,21,10,3, 15,11,9,16,32,4,20)
   AND T.MONTH_CODE = 2
   and sal_year = 2020;
   


 insert  into innovation.prms_transaction
select 1 Entity,
       '9999E' barnch,
       t.acc_no,
       t.sal_year,
       t.month_code,
       t.sal_month,
       t.basic_pay,
       t.medical_allowance,
       t.house_rent_allowance,
       t.tel_allowance,
       t.trans_allowance,
       t.edu_allowance,
       t.wash_allowance,
       t.pension_allowance,
       t.entertainment,
       t.domestic_allowance,
       t.other_allowance,
       t.gross_pay_amt,
       t.hbadv_deduc,
       t.mcycle_deduc,
       t.bicycle_deduc,
       t.pfadv_deduc,
       t.pension_deduc,
       t.revenue_deduc,
       t.welfare_deduc,
       t.carfare_deduc,
       t.caruse_deduc,
       t.gas_bill,
       t.water_bill,
       t.electricity_bill,
       t.house_rent_deduc,
       t.news_paper_deduc,
       t.net_ded_amt,
       t.net_pay_amt,
       t.pf_deduction,
       t.hbadv_arrear_deduc,
       t.pfadv_arrear_deduc,
       t.tel_excess_bill,
       t.gen_insurence,
       t.sp_deduc,
       t.sp_description,
       '' remarks,
       t.dearness_allowance,
       t.arrear,
       t.other_deduc,
       t.hbadv_deduc_percent,
       t.tot_sal_allowance,
       t.increment_date,
       t.arrear_basic,
       t.instl_amt_tlo,
       t.instl_amt_tlr,
       t.instl_amt_ins,
       t.instl_amt_inc,
       t.office_code,
       t.comp_deduc,
       'MIG',
       trunc(sysdate),
       t.sp_deduc income_tax,
       0 income_arrear,
       0 hill_allowance,
       0 actual_basic,
       '' r1,
       '' r3
  from sal_transaction t
 where t.office_code  in (7, 14)
 AND T.MONTH_CODE=2
 and sal_year = 2020; 
 
 
 insert into prms_transaction_hist
      select *
        from prms_transaction p