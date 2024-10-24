-- Script 01_step1_structure_insert
-- For presentation duality views
-- Andrea Kennel
-- 08.10.2024 

-- DROP VIEW product_dv;
-- DROP TABLE port_group;
-- DROP TABLE product;

/* 
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
    },

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
    }    

*/

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------

CREATE TABLE product (
  prod_id          NUMBER(10) GENERATED BY DEFAULT ON NULL AS 
                              IDENTITY (START WITH 10 INCREMENT BY 1),
  type             VARCHAR2(50),
  name             VARCHAR2(50),
  description      VARCHAR2(200),
  manufacturer     VARCHAR2(50),
  price            NUMBER (8,2)
);

CREATE TABLE port_group (
  pogr_id      NUMBER(10) GENERATED BY DEFAULT ON NULL AS 
                          IDENTITY (START WITH 10 INCREMENT BY 1),
  prod_id      NUMBER(10),
  amount       NUMBER(3),
  type         VARCHAR2(50),
  speeds       VARCHAR2(200)
);

ALTER TABLE product ADD CONSTRAINT prod_pk PRIMARY KEY (prod_id);
ALTER TABLE port_group ADD CONSTRAINT pogr_pk PRIMARY KEY (pogr_id);
ALTER TABLE port_group ADD CONSTRAINT pogr_prod_fk FOREIGN KEY (prod_id) 
  REFERENCES product (prod_id);

-- 
-- INSERT one device
--
INSERT INTO product (prod_id, type, name, description, manufacturer, price)
VALUES (1, 'network switch', 'Fritz A16', 'unmanaged 16 port network switch', 'ABC', 100);

INSERT INTO port_group (pogr_id, prod_id, amount, type, speeds)
VALUES (1, 1, 16, 'RJ45', '10/100/1000');

COMMIT;

--
-- SELECT JSON
--
SELECT json {'type' 		: p.type,
             'name'   		: p.name,
             'description'	: p.description,
             'manufacturer'	: p.manufacturer,
             'price'		: p.price,
             'port_group' :
               [ SELECT json {'amount' :  pg.amount,
                              'type'   	: pg.type,
                              'speeds'	: pg.speeds}
                 FROM   port_group pg 
                 WHERE  p.prod_id = pg.prod_id ]}
FROM product p;

-- 
-- DUALITY VIEW
-- 

CREATE OR replace json relational DUALITY VIEW product_dv AS
SELECT json {'type' 		: p.type,
             'name'   		: p.name,
             'description'	: p.description,
             'manufacturer'	: p.manufacturer,
             'price'		: p.price,
             'port_group' :
               [ SELECT json {'amount' :  pg.amount,
                              'type'   	: pg.type,
                              'speeds'	: pg.speeds}
                 FROM   port_group pg WITH INSERT UPDATE DELETE
                 WHERE  p.prod_id = pg.prod_id ]}
FROM product p WITH INSERT UPDATE DELETE;

-- ORA-40607: Cannot create JSON Relational Duality View 'PRODUCT_DV': All primary or unique key columns of table 'PRODUCT' must be selected.

-- 
-- DUALITY VIEW
-- 

CREATE OR replace json relational DUALITY VIEW product_dv AS
SELECT json {'_id'   		: p.prod_id,
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
                 WHERE  p.prod_id = pg.prod_id ]}
FROM product p WITH INSERT UPDATE DELETE;

-- 
-- INSERT in View
-- 

INSERT INTO product_dv d (data)
VALUES ('
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
    }');

COMMIT;

SELECT json_serialize(d.data pretty) FROM product_dv d;

SELECT * FROM product;
SELECT * FROM port_group;

