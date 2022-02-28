-- Create table
create table PRMS_TRANSACTION_MANUAL
(
  entity_number        NUMBER(4) not null,
  branch_code          VARCHAR2(6) not null,
  emp_id               VARCHAR2(20) not null,
  sal_year             NUMBER(4) not null,
  month_code           NUMBER(2) not null,
  sal_month            VARCHAR2(10),
  basic_pay            NUMBER(12,2),
  medical_allowance    NUMBER(12,2),
  house_rent_allowance NUMBER(12,2),
  tel_allowance        NUMBER(12,2),
  trans_allowance      NUMBER(12,2),
  edu_allowance        NUMBER(12,2),
  wash_allowance       NUMBER(12,2),
  pension_allowance    NUMBER(12,2),
  entertainment        NUMBER(12,2),
  domestic_allowance   NUMBER(12,2),
  other_allowance      NUMBER(12,2),
  gross_pay_amt        NUMBER(12,2),
  hbadv_deduc          NUMBER(12,2),
  mcycle_deduc         NUMBER(12,2),
  bicycle_deduc        NUMBER(12,2),
  pfadv_deduc          NUMBER(12,2),
  pension_deduc        NUMBER(12,2),
  revenue_deduc        NUMBER(10,2),
  welfare_deduc        NUMBER(12,2),
  carfare_deduc        NUMBER(12,2),
  caruse_deduc         NUMBER(12,2),
  gas_bill             NUMBER(12,2),
  water_bill           NUMBER(12,2),
  electricity_bill     NUMBER(12,2),
  house_rent_deduc     NUMBER(12,2),
  news_paper_deduc     NUMBER(10,2),
  net_ded_amt          NUMBER(12,2),
  net_pay_amt          NUMBER(12,2),
  pf_deduction         NUMBER(12,2),
  hbadv_arrear_deduc   NUMBER(12,2),
  pfadv_arrear_deduc   NUMBER(12,2),
  tel_excess_bill      NUMBER(12,2),
  gen_insurence        NUMBER(12,2),
  sp_deduc             NUMBER(12,2),
  sp_description       VARCHAR2(45),
  tremarks             VARCHAR2(35),
  dearness_allowance   NUMBER(12,2),
  arrear               NUMBER(12,2),
  other_deduc          NUMBER(12,2),
  hbadv_deduc_percent  NUMBER(10,2),
  tot_sal_allowance    NUMBER(12,2),
  increment_date       DATE,
  arrear_basic         NUMBER(12,2),
  instl_amt_tlo        NUMBER(12,2),
  instl_amt_tlr        NUMBER(12,2),
  instl_amt_ins        NUMBER(12,2),
  instl_amt_inc        NUMBER(12,2),
  office_code          NUMBER(4),
  comp_deduc           NUMBER(12,2),
  generated_by         VARCHAR2(15),
  generated_on         DATE,
  income_tax           NUMBER(12,2),
  income_tax_arr       NUMBER(12,2),
  hill_allwnc          NUMBER(12,2),
  actual_basic         NUMBER(12,2),
  deduction_remarks    VARCHAR2(400),
  allowance_remarks    VARCHAR2(400),
  desig_code           NUMBER(2),
  incremented_basic    NUMBER(9,2),
  manual_sal           VARCHAR2(2)
)
tablespace INNOVATION
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table PRMS_TRANSACTION_MANUAL
  add primary key (ENTITY_NUMBER, BRANCH_CODE, EMP_ID, SAL_YEAR, MONTH_CODE)
  using index 
  tablespace INNOVATION
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
