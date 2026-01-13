-- Script insert_data_step1
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------

INSERT INTO product_collection (prod_id, json_data)
VALUES (1, json('{
        "type": "network switch",
        "name": "Fritz A16",
        "description": "unmanaged 16 port network switch",
        "manufacturer": "ABC",
        "price": 100,
        "port_group": [
            {
                "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000"
            }
        ]
    }'));
    
INSERT INTO product_collection (prod_id, json_data)
VALUES (2, json('{
        "type": "network switch",
        "name": "Fritz B24",
        "description": "unmanaged 24 port 10gbit/s network switch",
        "manufacturer": "ABC",
        "price": 250,
        "port_group": [
            {
                "amount": 24,
                "type": "RJ45",
                "speeds": "10/100/1000/2500/5000/10000"
            }
        ]
    }'));
    
INSERT INTO product_collection (prod_id, json_data)
VALUES (3, json('{
        "type": "network switch",
        "name": "Fritz C12",
        "description": "managed 12 port network switch",
        "manufacturer": "DEF",
        "price": 150,
        "port_group": [
            {
                "amount": 12,
                "type": "RJ45",
                "speeds": "10/100/1000/10000"
            }
        ]
    }'));
    
INSERT INTO product_collection (prod_id, json_data)
VALUES (4, json('{
        "type": "router",
        "name": "Hans A8",
        "description": "8 port router",
        "manufacturer": "ABC",
        "price": 1000,
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
    
INSERT INTO product_collection (prod_id, json_data)
VALUES (5, json('{
        "type": "router",
        "name": "Hans B4",
        "description": "4 port router",
        "manufacturer": "XYZ",
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

COMMIT;
