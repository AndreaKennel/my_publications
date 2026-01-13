-- Script insert_data_step1
-- For presentation flex structures
-- Andrea Kennel
-- 04.10.2023

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

INSERT INTO product (prod_id, type, name, description, manufacturer, price)
VALUES (1, 'network switch', 'Fritz A16', 'unmanaged 16 port network switch', 'ABC', 100),
       (2, 'network switch', 'Fritz B24', 'unmanaged 24 port 10gbit/s network switch', 'ABC', 250),
       (3, 'network switch', 'Fritz C12', 'managed 12 port network switch', 'DEF', 150),
       (4, 'router', 'Hans A8', '8 port router', 'ABC', 1000),
       (5, 'router', 'Hans B4', '4 port router', 'XYZ', 800);

INSERT INTO port_group (pogr_id, prod_id, amount, type, speeds)
VALUES (1, 1, 16, 'RJ45', '10/100/1000'),
       (2, 2, 24, 'RJ45', '10/100/1000/2500/5000/10000'),
       (3, 3, 12, 'RJ45', '10/100/1000/10000'),
       (4, 4, 4, 'RJ45', '100/1000/10000'),
       (5, 4, 2, 'SFP+', '1000/40000/100000'),
       (6, 4, 2, 'SFP', '1000/10000'),
       (7, 5, 4, 'RJ45', '100/1000'),
       (8, 5, 2, 'SFP', '1000/10000');

INSERT INTO routing (rout_id, prod_id, protocols, table_size)
VALUES (1, 4, 'static, RIP, OSPF, BGP', 10),
       (2, 5, 'static, OSPF', 5);

COMMIT;

