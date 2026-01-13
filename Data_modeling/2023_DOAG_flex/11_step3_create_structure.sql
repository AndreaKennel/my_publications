-- Script create_structure_step3
-- For presentation flex structures
-- Andrea Kennel
-- 10.08.2023

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

-- no change

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

-- features erweitern mit weiteren Attributen

ALTER TABLE feature ADD amount_of_rules NUMBER(10);
ALTER TABLE feature ADD amount_of_connections NUMBER(10);
ALTER TABLE feature ADD amount_of_nat_rules NUMBER(10);
ALTER TABLE feature ADD ssl_inspection VARCHAR2(10);
ALTER TABLE feature ADD amount_of_tunnels NUMBER(10);
ALTER TABLE feature ADD amount_of_users NUMBER(10);
ALTER TABLE feature ADD parent_feat_id NUMBER(10);

ALTER TABLE feature ADD CONSTRAINT feat_feat_fk FOREIGN KEY (parent_feat_id) REFERENCES feature (feat_id);

-- ---------------------------------------------------------------------------------------
-- TABLES WITH EAV
-- ---------------------------------------------------------------------------------------

ALTER TABLE feature_eav ADD parent_feat_id NUMBER(10);
ALTER TABLE feature_eav ADD CONSTRAINT feae_feae_fk FOREIGN KEY (parent_feat_id) REFERENCES feature_eav (feat_id);

-- ---------------------------------------------------------------------------------------
-- TABLES WITH JSON
-- ---------------------------------------------------------------------------------------

-- no change

