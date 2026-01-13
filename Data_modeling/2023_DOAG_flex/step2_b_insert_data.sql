-- Script insert_data_step2
-- For presentation flex structures
-- Andrea Kennel
-- 08.08.2023

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

INSERT INTO product_collection (prod_id, json_data)
VALUES (21, json('{
        "type": "network switch/layer3 switch",
        "name": "Fritz C16",
        "description": "16 port PoE layer 3 network switch",
        "manufacturer": "ABC",
        "price": 500,
        "port_group": [
            {
                "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000",
                "poe": {
                    "modes": [
                        "active",
                        "passive"
                    ],
                    "volt": [
                        24,
                        48
                    ]
                }
            }
        ],
        "feature": [
            {
                "name": "VLAN",
                "amount": 4094
            },
            {
                "name": "QoS",
                "amount": 8
            },
            {
                "name": "network access control",
                "type": "MAC based authentication",
                "vlan_support": true
            },
            {
                "name": "routing",
                "protocols": "static, RIP, OSPF, BGP",
                "table_size": 10
            }
        ]
    }'));

COMMIT;

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

-- ---------------------------------------------------------------------------------------
-- TABLES WITH EAV
-- ---------------------------------------------------------------------------------------

-- only data for step2, product is already filled

INSERT INTO feature_eav (feat_id, prod_id, name)
VALUES (21, 21, 'VLAN'),
       (22, 21, 'QoS'),
       (23, 21, 'network access control'),
       (24, 21, 'routing');

INSERT INTO attribute (attr_id, nam)
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

-- ---------------------------------------------------------------------------------------
-- TABLES WITH JSON
-- ---------------------------------------------------------------------------------------

INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (1, 'network switch', 'Fritz A16', 'unmanaged 16 port network switch', 'ABC', 100,
 json('{
        "port_group": [
            {
                "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000"
            }
        ]
    }'));
    
INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (2, 'network switch', 'Fritz B24', 'unmanaged 24 port 10gbit/s network switch', 'ABC', 250,
 json('{
        "port_group": [
            {
                "amount": 24,
                "type": "RJ45",
                "speeds": "10/100/1000/2500/5000/10000"
            }
        ]
    }'));
    
INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (3, 'network switch', 'Fritz C12', 'managed 12 port network switch', 'DEF', 150,
 json('{
        "port_group": [
            {
                "amount": 12,
                "type": "RJ45",
                "speeds": "10/100/1000/10000"
            }
        ]
    }'));
    
INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (4, 'router', 'Hans A8', '8 port router', 'ABC', 1000,
 json('{
        "port_group": [
            {
                "amount": 4,
                "type": "RJ45",
                "speeds": "100/1000/10000"
            },
            {
                "amount": 2,
                "type": "SFP+",
                "speeds": "1000/40000/100000"
            },
            {
                "amount": 2,
                "type": "SFP",
                "speeds": "1000/10000"
            }
        ],
        "routing": {
            "protocols": "static, RIP, OSPF, BGP",
            "table_size": 10
        }
    }'));
    
INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (5, 'router', 'Hans B4', '4 port router', 'XYZ', 800,
 json('{
        "price": 800,
        "port_group": [
            {
                "amount": 4,
                "type": "RJ45",
                "speeds": "100/1000"
            },
            {
                "amount": 2,
                "type": "SFP",
                "speeds": "1000/10000"
            }
        ],
        "routing": {
            "protocols": "static OSPF",
            "table_size": 5
        }
    }'));

INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (21, 'network switch/layer3 switch', 'Fritz C16', '16 port PoE layer 3 network switch', 'ABC', 500,
'{
        "port_group": [
            {
                "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000",
                "poe": {
                    "modes": [
                        "active",
                        "passive"
                    ],
                    "volt": [
                        24,
                        48
                    ]
                }
            }
        ],
        "feature": [
            {
                "name": "VLAN",
                "amount": 4094
            },
            {
                "name": "QoS",
                "amount": 8
            },
            {
                "name": "network access control",
                "type": "MAC based authentication",
                "vlan_support": true
            },
            {
                "name": "routing",
                "protocols": "static, RIP, OSPF, BGP",
                "table_size": 10
            }
        ]
    }');

COMMIT;
