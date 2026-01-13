-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

-- DROP TABLE product_collection;

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

CREATE TABLE product_collection (
  prod_id      NUMBER(10),
  json_data    JSON
  CONSTRAINT pro_ensure_json CHECK (json_data IS JSON)
);

ALTER TABLE product_collection ADD CONSTRAINT prco_pk PRIMARY KEY (prod_id);

