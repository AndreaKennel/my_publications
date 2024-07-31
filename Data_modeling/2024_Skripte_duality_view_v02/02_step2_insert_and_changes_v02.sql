-- Script 02_step2_insert_and_changes Step2 for duality views
-- Trying to insert more data and having to change the structure
-- Andrea Kennel
-- 30.03.2024 

-- 31.07.2024: Duality View braucht neu als Schlüssel das Attribut _id

/* 
{
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
            },
            {
                "amount": 2,
                "type": "SFP",
                "speeds": "1000/10000"
            }
        ]
    },
    
{
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
    },
    
{
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
    }

*/

-- ---------------------------------------------------------------------------------------
-- INSERT
-- ---------------------------------------------------------------------------------------

INSERT INTO product_dv d (data)
VALUES ('
{       "type": "network switch",
        "name": "Fritz C12",
        "description": "managed 12 port network switch",
        "manufacturer": "DEF",
        "price": 150,
        "port_group": [
            {   "amount": 12,
                "type": "RJ45",
                "speeds": "10/100/1000/10000"
            },
            {   "amount": 2,
                "type": "SFP",
                "speeds": "1000/10000"
            } ]
    }');

INSERT INTO product_dv d (data)
VALUES ('
{       "type": "router",
        "name": "Hans A8",
        "description": "8 port router",
        "manufacturer": "ABC",
        "price": 1000,
        "port_group": [
            {   "amount": 4,
                "type": "RJ45",
                "speeds": "100/1000/10000"
            },
            {   "amount": 2,
                "type": "SFP+",
                "speeds": "1000/40000/100000"
            },
            {   "amount": 2,
                "type": "SFP",
                "speeds": "1000/10000"
            } ],
        "routing": {
            "protocols": "static, RIP, OSPF, BGP",
            "table_size": 10
        }
    }');

-- ORA-40944: Cannot insert into JSON Relational Duality View 'PRODUCT_DV': The input JSON document is invalid.

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

ALTER TABLE product 
ADD (protocols    VARCHAR2(200),
  table_size   NUMBER(10));
  
-- 
-- DUALITY VIEW
-- 

CREATE OR replace json relational DUALITY VIEW product_dv AS
SELECT json {'_id'	    	: p.prod_id,
             'type' 		: p.type,
             'name'   		: p.name,
             'description'	: p.description,
             'manufacturer'	: p.manufacturer,
             'price'		: p.price,
             'port_group' :
               [ SELECT json {'pogr_id' : pg.pogr_id,
                              'amount'  : pg.amount,
                              'type'   	: pg.type,
                              'speeds'	: pg.speeds}
                 FROM   port_group pg WITH INSERT UPDATE DELETE
                 WHERE  p.prod_id = pg.prod_id ],
             'routing' : ( json {
             'protocols'		: p.protocols,
             'table_size'       : p.table_size})
            }
FROM product p WITH INSERT UPDATE DELETE;

--
-- INSERT
--

INSERT INTO product_dv d (data)
VALUES ('
{
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
    }');

INSERT INTO product_dv d (data)
VALUES ('
{
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
    }');

COMMIT;



SELECT * FROM product;
SELECT * FROM port_group;

