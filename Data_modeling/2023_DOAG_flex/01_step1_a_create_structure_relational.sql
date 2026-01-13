-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 04.10.2023

-- DROP TABLE port_group;
-- DROP TABLE routing;
-- DROP TABLE product;

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

CREATE TABLE product (
  prod_id      NUMBER(10),
  type         VARCHAR2(50),
  name         VARCHAR2(50),
  description  VARCHAR2(200),
  manufacturer VARCHAR2(50),
  price        NUMBER (8,2)
);

CREATE TABLE port_group (
  pogr_id      NUMBER(10),
  prod_id      NUMBER(10),
  amount       NUMBER(3),
  type         VARCHAR2(50),
  speeds       VARCHAR2(200)
);

CREATE TABLE routing (
  rout_id      NUMBER(10),
  prod_id      NUMBER(10),
  protocols    VARCHAR2(200),
  table_size   NUMBER(10)
);

ALTER TABLE product ADD CONSTRAINT prod_pk PRIMARY KEY (prod_id);
ALTER TABLE port_group ADD CONSTRAINT pogr_pk PRIMARY KEY (pogr_id);
ALTER TABLE port_group ADD CONSTRAINT pogr_prod_fk FOREIGN KEY (prod_id) REFERENCES product (prod_id);
ALTER TABLE routing ADD CONSTRAINT rout_pk PRIMARY KEY (rout_id);
ALTER TABLE routing ADD CONSTRAINT rout_prod_fk FOREIGN KEY (prod_id) REFERENCES product (prod_id);


