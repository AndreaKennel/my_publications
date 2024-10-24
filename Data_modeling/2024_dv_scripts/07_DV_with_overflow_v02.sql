-- Script 08_Json_with_overflow.sql
-- For presentation duality view
-- Andrea Kennel
-- 09.10.2024

-- ---------------------------------------------------------------------------------------
-- TABLES WITH JSON for overflow
-- ---------------------------------------------------------------------------------------

ALTER TABLE product 
ADD (more_info        JSON(OBJECT));

ALTER TABLE port_group 
ADD (more_info        JSON(OBJECT));

-- 
-- DUALITY VIEW
-- 

CREATE OR replace json relational DUALITY VIEW product_dv AS
product @insert @update @delete
{
	_id			    : prod_id
    type 			: type
    name   			: name
    description		: description
    manufacturer	: manufacturer
    price			: price
    protocols		: protocols
    table_size		: table_size
    more_info  		@flex
	port_group @insert @update @delete
	{
		_id	    : pogr_id
		amount  : amount
		type 	: type
		speeds 	: speeds
		more_info  @flex
	}
};

-- ---------------------------------------------------------------------------------------
-- INSERT
-- ---------------------------------------------------------------------------------------

INSERT INTO product_dv d (data)
VALUES ('
{
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
    }');

INSERT INTO product_dv d (data)
VALUES ('
{
        "type": "router/firewall",
        "name": "Hans A48",
        "description": "48 port HA firewall with advanced filtering, VPN, reverse proxy and docker support",
        "manufacturer": "ABC",
        "price": 500,
        "port_group": [
            {   "amount": 16,
                "type": "RJ45",
                "speeds": "10/100/1000",
                "poe": {"modes": ["active", "passive"],
                    "volt": [24, 48]}
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

--
-- SELECT 
--

SELECT *
FROM product_dv;

SELECT *
FROM product;

SELECT *
FROM port_group;