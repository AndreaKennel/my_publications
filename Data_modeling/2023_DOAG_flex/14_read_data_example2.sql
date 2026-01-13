-- Script read_data_example1
-- For presentation flex structures
-- Andrea Kennel
-- 05.10.2023

Haben wir Geräte mit einer Port-Group vom Typ SFP?

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------
SELECT pro.prod_id, pro.type product_type, pro.name, pog.amount, pog.type 
FROM product pro INNER JOIN 
     port_group pog ON (pro.prod_id = pog.prod_id)
WHERE pog.type = 'SFP';

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------
SELECT pc.prod_id, pc.json_data.type product_type, pc.json_data.name,
       jt.*
FROM product_collection pc,
     JSON_TABLE(
         pc.json_data
         COLUMNS (
             NESTED port_group[*]
             COLUMNS (
                 amount NUMBER(3) PATH '$.amount',
                 type VARCHAR2(50) PATH '$.type'
             )
         )
     ) jt
WHERE jt.type = 'SFP';

-- ---------------------------------------------------------------------------------------
-- Table with JSON
-- ---------------------------------------------------------------------------------------
SELECT pf.prod_id, pf.type product_type, pf.name,
       jt.*
FROM product_flex pf,
     JSON_TABLE(
         pf.more_info
         COLUMNS (
             NESTED port_group[*]
             COLUMNS (
                 amount NUMBER(3) PATH '$.amount',
                 type VARCHAR2(50) PATH '$.type'
             )
         )
     ) jt
WHERE jt.type = 'SFP';


-- ---------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------
                  
Alle Details für network switch “Fritz A16”

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------
SELECT p.prod_id, p.type product_type, p.name, p.price
FROM product p INNER JOIN ...

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------
SELECT pc.*
FROM product_collection pc
WHERE pc.json_data.type = 'network switch' 
  AND pc.json_data.name = 'Fritz A16';

-- ---------------------------------------------------------------------------------------
-- Table with JSON
-- ---------------------------------------------------------------------------------------
SELECT pf.*
FROM product_flex pf
WHERE pf.type = 'network switch'
  AND pf.name = 'Fritz A16';
  

-- ---------------------------------------------------------------------------------------
-- JSON mit falschen Daten
-- ---------------------------------------------------------------------------------------
INSERT INTO product_collection (prod_id, json_data)
VALUES (111, json('{
        "typo": "network switch",
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

COMMIT;

SELECT pc.*
FROM product_collection pc
WHERE pc.json_data.type = 'network switch' 
  AND pc.json_data.name = 'Fritz A16';

SELECT pc.*
FROM product_collection pc
WHERE pc.json_data.name = 'Fritz A16';

