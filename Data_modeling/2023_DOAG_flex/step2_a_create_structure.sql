-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 08.08.2023

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

-- no change

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

-- change structure and keep existing data
-- new table poe with FK to Port_group; poe = Power over Ethernet
-- rename routing to feature rename the pk and add columns

-- DROP TABLE poe;

CREATE TABLE poe (
  poe_id       NUMBER(10),
  pogr_id      NUMBER(10),
  modes        VARCHAR2(20),
  volt         NUMBER (6,2)
);

ALTER TABLE poe ADD CONSTRAINT poe_pk PRIMARY KEY (poe_id);
ALTER TABLE poe ADD CONSTRAINT poe_pogr_fk FOREIGN KEY (pogr_id) REFERENCES port_group (pogr_id);

RENAME routing TO feature;
ALTER TABLE feature RENAME COLUMN  rout_id TO feat_id;
ALTER TABLE feature ADD name VARCHAR2(200);
ALTER TABLE feature ADD amount NUMBER(10);
ALTER TABLE feature ADD type VARCHAR2(200);
ALTER TABLE feature ADD vlan_support VARCHAR2(200);
-- all existing get name 'routing'
UPDATE feature
SET name = 'routing';

-- ---------------------------------------------------------------------------------------
-- TABLES WITH EAV
-- ---------------------------------------------------------------------------------------

-- DROP TABLE feature_attribute_value;
-- DROP TABLE attribute;
-- DROP TABLE feature_eav;

CREATE TABLE feature_eav (
  feat_id      NUMBER(10),
  prod_id      NUMBER(10),
  name         VARCHAR2(200)
);

CREATE TABLE attribute (
  attr_id      NUMBER(10),
  name         VARCHAR2(30)
);

CREATE TABLE feature_attribute_value (
  valu_id      NUMBER(10),
  feat_id      NUMBER(10),
  attr_id      NUMBER(10),
  value        VARCHAR2(2000)
);

ALTER TABLE feature_eav ADD CONSTRAINT feae_pk PRIMARY KEY (feat_id);
ALTER TABLE feature_eav ADD CONSTRAINT feae_prod_fk FOREIGN KEY (prod_id) REFERENCES product (prod_id);
ALTER TABLE attribute ADD CONSTRAINT attr_pk PRIMARY KEY (attr_id);
ALTER TABLE feature_attribute_value ADD CONSTRAINT feav_pk PRIMARY KEY (valu_id);
ALTER TABLE feature_attribute_value ADD CONSTRAINT feav_feat_fk FOREIGN KEY (feat_id) REFERENCES feature_eav (feat_id);
ALTER TABLE feature_attribute_value ADD CONSTRAINT feav_attr_fk FOREIGN KEY (attr_id) REFERENCES attribute (attr_id);

-- ---------------------------------------------------------------------------------------
-- TABLES WITH JSON
-- ---------------------------------------------------------------------------------------

CREATE TABLE product_flex (
  prod_id      NUMBER(10),
  type         VARCHAR2(50),
  name         VARCHAR2(50),
  description  VARCHAR2(200),
  manufacturer VARCHAR2(50),
  price        NUMBER (8,2),
  more_info    JSON
);

ALTER TABLE product_flex ADD CONSTRAINT prfl_pk PRIMARY KEY (prod_id);

