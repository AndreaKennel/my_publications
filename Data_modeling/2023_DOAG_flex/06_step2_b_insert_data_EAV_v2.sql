-- Script insert_data_step2
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

-- ---------------------------------------------------------------------------------------
-- TABLES WITH EAV
-- ---------------------------------------------------------------------------------------

-- data for step2, product is already filled

INSERT INTO feature_eav (feat_id, prod_id, name)
VALUES (21, 21, 'VLAN'),
       (22, 21, 'QoS'),
       (23, 21, 'network access control'),
       (24, 21, 'routing');

INSERT INTO attribute (attr_id, name)
VALUES (81, 'amount'),
       (82, 'type'),
       (83, 'vlan_support'),
       (84, 'protocols'),
       (85, 'table_size');

INSERT INTO feature_attribute_value (valu_id, feat_id, attr_id, value)
VALUES (21, 21, 81, '4094'),
       (22, 22, 81, '8'),
       (23, 23, 82, 'MAC based authentication'),
       (24, 23, 83, 'TRUE'),
       (25, 24, 84, 'static, RIP, OSPF, BGP'),
       (26, 24, 85, '10');

COMMIT;

-- data for step1, product is already filled
INSERT INTO feature_eav (feat_id, prod_id, name)
VALUES (1, 4, 'routing'),
       (2, 5, 'routing');

INSERT INTO feature_attribute_value (valu_id, feat_id, attr_id, value)
VALUES (1, 1, 84, 'static, RIP, OSPF, BGP'),
       (2, 1, 85, '10'),
       (3, 2, 84, 'static, OSPF'),
       (4, 2, 85, '5');

COMMIT;

