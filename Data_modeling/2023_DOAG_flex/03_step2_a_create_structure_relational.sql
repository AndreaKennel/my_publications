-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 04.10.23

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

