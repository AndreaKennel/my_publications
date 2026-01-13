-- Script insert_data_step2
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

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

