-- Script 04_step4_json_mehr_date.sql
-- For presentation duality views
-- Andrea Kennel
-- 01.10.2024

-- ---------------------------------------------------------------------------------------
-- INSERT weitere Daten
-- ---------------------------------------------------------------------------------------

INSERT INTO product_collection (json_data)
VALUES ('
{
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
    }');

COMMIT;

SELECT * FROM product_collection;

SELECT pc.json_data.type, count(*)
FROM product_collection pc
GROUP BY pc.json_data.type;


