-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

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

