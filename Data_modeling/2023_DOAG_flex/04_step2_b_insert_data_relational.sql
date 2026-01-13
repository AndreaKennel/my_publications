-- Script insert_data_step2
-- For presentation flex structures
-- Andrea Kennel
-- 04.10.2023

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

INSERT INTO product (prod_id, type, name, description, manufacturer, price)
VALUES (21, 'network switch/layer3 switch', 'Fritz C16', '16 port PoE layer 3 network switch', 'ABC', 500);

INSERT INTO port_group (pogr_id, prod_id, amount, type, speeds)
VALUES (21, 21, 16, 'RJ45', '10/100/1000');

INSERT INTO poe (poe_id, pogr_id, modes, volt)
VALUES (21, 21, 'active', 24),
       (22, 21, 'passive', 48);
       
INSERT INTO feature (feat_id, prod_id, name, amount)
VALUES (21, 21, 'VLAN', 4094),
       (22, 21, 'QoS', 8);

INSERT INTO feature (feat_id, prod_id, name, type, vlan_support)
VALUES (23, 21, 'network access control', 'MAC based authentication', 'TRUE');

INSERT INTO feature (feat_id, prod_id, name, protocols, table_size)
VALUES (24, 21, 'routing', 'static, RIP, OSPF, BGP', 10);

COMMIT;

SELECT *
FROM feature;
