-- Script create_structure_step1
-- For presentation flex structures
-- Andrea Kennel
-- 06.10.2023

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

-- ---------------------------------------------------------------------------------------
-- INSERT DATA STEP 1 and 2
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

-- ---------------------------------------------------------------------------------------
-- INSERT DATA STEP 3
-- ---------------------------------------------------------------------------------------

INSERT INTO product_flex (prod_id, type, name, description, manufacturer, price, more_info)
VALUES (31, 'router/firewall', 'Hans A48', '48 port HA firewall with advanced filtering, VPN, reverse proxy and docker support', 'ABC', 500,
 json('{
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
