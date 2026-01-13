-- Script insert_data_step2
-- For presentation flex structures
-- Andrea Kennel
-- 06.10.2023

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

INSERT INTO product_collection (prod_id, json_data)
VALUES (31, json('{
        "type": "router/firewall",
        "name": "Hans A48",
        "description": "48 port HA firewall with advanced filtering, VPN, reverse proxy and docker support",
        "manufacturer": "ABC",
        "price": 500,
        "port_group": [
            {
                "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000"
            },
            {
                "amount": 16,
                "type": "SFP+",
                "speeds": "1000/40000/100000"
            },
            {
                "amount": 16,
                "type": "SFP",
                "speeds": "1000/10000"
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
                "name": "routing",
                "protocols": "static, RIP, OSPF, BGP, EGP",
                "table_size": 1000
            },
            {
                "name": "firewall",
                "type": "stateful, stateless",
                "amount_of_rules": 1000,
                "amount_of_connections": 100000,
                "amount_of_nat_rules": 1000,
                "feature": [
                    {
                        "name": "URL filtering",
                        "types": "whitelist, blacklist",
                        "amount_of_rules": 1000
                    },
                    {
                        "name": "application filtering",
                        "types": "whitelist",
                        "amount_of_rules": 1000
                    },
                    {
                        "name": "content filtering",
                        "types": "blacklist",
                        "amount_of_rules": 1000
                    },
                    {
                        "name": "anti-virus",
                        "ssl_inspection": true
                    }
                ]
            },
            {
                "name": "VPN",
                "type": "IPsec, SSL, L2TP, PPTP",
                "amount_of_tunnels": 1000,
                "amount_of_users": 1000,
                "feature": [
                    {
                        "name": "IPsec",
                        "type": "IKEv1, IKEv2",
                        "amount_of_tunnels": 1000,
                        "amount_of_users": 1000
                    },
                    {
                        "name": "SSL",
                        "amount_of_tunnels": 1000,
                        "amount_of_users": 1000
                    },
                    {
                        "name": "L2TP",
                        "amount_of_tunnels": 1000,
                        "amount_of_users": 1000
                    },
                    {
                        "name": "PPTP",
                        "amount_of_tunnels": 1000,
                        "amount_of_users": 1000
                    }
                ]
            },
            {
                "name": "network access control",
                "type": "MAC based authentication, 802.1x",
                "vlan_support": true
            }
        ]
    }'));

COMMIT;

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

INSERT INTO product (prod_id, type, name, description, manufacturer, price)
VALUES (31, 'router/firewall', 'Hans A48', '48 port HA firewall with advanced filtering, VPN, reverse proxy and docker support', 'ABC', 500);

INSERT INTO port_group (pogr_id, prod_id, amount, type, speeds)
VALUES (41, 31, 16, 'RJ45', '10/100/1000'),
       (42, 31, 16, 'SFP+', '1000/40000/100000'),
       (43, 31, 16, 'SFP', '1000/10000');

INSERT INTO feature (feat_id, prod_id, name, amount)
VALUES (41, 31, 'VLAN', 4094),
       (42, 31, 'QoS', 8);

INSERT INTO feature (feat_id, prod_id, name, protocols, table_size)
VALUES (43, 31, 'routing', 'static, RIP, OSPF, BGP, EGP', 1000);

INSERT INTO feature (feat_id, prod_id, name, type, amount_of_rules, amount_of_connections, amount_of_nat_rules)
VALUES (44, 31, 'firewall', 'stateful, stateless', 1000, 100000, 1000);

INSERT INTO feature (feat_id, prod_id, name, type, amount_of_tunnels, amount_of_users)
VALUES (45, 31, 'VPN', 'IPsec, SSL, L2TP, PPTP', 1000, 1000);

INSERT INTO feature (feat_id, prod_id, name, type, vlan_support)
VALUES (46, 31, 'network access control', 'MAC based authentication, 802.1x', 'TRUE');

-- subfeatures
INSERT INTO feature (feat_id, parent_feat_id, name, type, amount_of_rules)
VALUES (47, 44, 'URL filtering', 'whitelist, blacklist', 1000),
       (48, 44, 'application filtering', 'whitelist', 1000),
       (49, 44, 'content filtering', 'blacklist', 1000);

INSERT INTO feature (feat_id, parent_feat_id, name, ssl_inspection)
VALUES (50, 44, 'anti-virus', 'TRUE');

INSERT INTO feature (feat_id, parent_feat_id, name, type, amount_of_tunnels, amount_of_users)
VALUES (51, 45, 'IPsec', 'IKEv1, IKEv2', 1000, 1000);

INSERT INTO feature (feat_id, parent_feat_id, name, amount_of_tunnels, amount_of_users)
VALUES (52, 45, 'SSL', 1000, 1000),
       (53, 45, 'L2TP', 1000, 1000),
       (54, 45, 'PPTP', 1000, 1000);

COMMIT;

-- ---------------------------------------------------------------------------------------
-- TABLES WITH EAV
-- ---------------------------------------------------------------------------------------

-- only data for step2, product is already filled

INSERT INTO feature_eav (feat_id, prod_id, name)
VALUES (41, 31, 'VLAN'),
       (42, 31, 'QoS'),
       (43, 31, 'routing'),
       (44, 31, 'firewall'),
       (45, 31, 'VPN'),
       (46, 31, 'network access control');

-- subfeatures
INSERT INTO feature_eav (feat_id, parent_feat_id, name)
VALUES (47, 44, 'URL filtering'),
       (48, 44, 'application filtering'),
       (49, 44, 'content filtering'),
       (50, 44, 'anti-virus'),
       (51, 45, 'IPsec'),
       (52, 45, 'SSL'),
       (53, 45, 'L2TP'),
       (54, 45, 'PPTP');

INSERT INTO attribute (attr_id, name)
VALUES (86, 'amount_of_rules'),
       (87, 'amount_of_connections'),
       (88, 'amount_of_nat_rules'),
       (89, 'ssl_inspection'),
       (90, 'amount_of_tunnels'),
       (91, 'amount_of_users');

INSERT INTO feature_attribute_value (valu_id, feat_id, attr_id, value)
VALUES (31, 41, 81, '4094'),
       (32, 42, 81, '8'),
       (33, 43, 84, 'static, RIP, OSPF, BGP, EGP'),
       (34, 43, 85, '1000'),
       (35, 44, 82, 'stateful, stateless'),
       (36, 44, 86, '1000'),
       (37, 44, 87, '100000'),
       (38, 44, 88, '1000'),
       (39, 45, 82, 'IPsec, SSL, L2TP, PPTP'),
       (40, 45, 90, '1000'),
       (41, 45, 91, '1000'),
       (42, 46, 82, 'MAC based authentication, 802.1x'),
       (43, 46, 83, 'TRUE'),
       (44, 47, 82, 'whitelist, blacklist'),
       (45, 47, 86, '1000'),
       (46, 48, 82, 'whitelist'),
       (47, 48, 86, '1000'),
       (48, 49, 82, 'blacklist'),
       (49, 49, 86, '1000'),
       (50, 50, 89, 'TRUE'),
       (51, 51, 82, 'IKEv1, IKEv2'),
       (52, 51, 90, '1000'),
       (53, 51, 91, '1000'),
       (54, 52, 90, '1000'),
       (55, 52, 91, '1000'),
       (56, 53, 90, '1000'),
       (57, 53, 91, '1000'),
       (58, 54, 90, '1000'),
       (59, 54, 91, '1000');

COMMIT;

