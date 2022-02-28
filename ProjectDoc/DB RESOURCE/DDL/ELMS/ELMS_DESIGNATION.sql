  CREATE TABLE ELMS_DESIGNATION
(
  DESIGNATION_CODE     NUMBER(2) NOT NULL,
  DESIGNATION_DESC     VARCHAR2(30),
  PAYSCALE_CODE        NUMBER(2),
  DESIGNATION_CATEGORY NUMBER(1)
);
ALTER TABLE ELMS_DESIGNATION
  ADD PRIMARY KEY (DESIGNATION_CODE);