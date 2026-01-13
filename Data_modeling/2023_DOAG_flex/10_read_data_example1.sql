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
       pc.json_data.port_group[*].amount, 
       pc.json_data.port_group[*].type
FROM product_collection pc;

SELECT pc.prod_id, pc.json_data.type product_type, pc.json_data.name, 
       pc.json_data.port_group[*].amount, 
       pc.json_data.port_group[*].type
FROM product_collection pc
WHERE json_exists(pc.json_data,
                  '$.port_group?(@.type == $v1)'
                    PASSING 'SFP' AS "v1");

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
     ) jt;

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
-- ---------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------
                  
Haben wir Geräte mit Feature, das amount = 8 hat?

-- ---------------------------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------------------------
SELECT pro.prod_id, pro.type product_type, pro.name, 
       fe.name feature_name, fe.amount
FROM product pro INNER JOIN 
     feature fe ON (pro.prod_id = fe.prod_id)
WHERE fe.amount = 8;

-- ---------------------------------------------------------------------------------------
-- JSON
-- ---------------------------------------------------------------------------------------
SELECT pc.prod_id, pc.json_data.type product_type, 
       pc.json_data.name, 
       pc.json_data.feature[*].name, 
       pc.json_data.feature[*].amount
FROM product_collection pc
WHERE json_exists(pc.json_data,
                  '$.feature?(@.amount == $v1)'
                    PASSING 8 AS "v1");

SELECT pc.prod_id, pc.json_data.type product_type, pc.json_data.name,
       jt.*
FROM product_collection pc,
     JSON_TABLE(
         pc.json_data
         COLUMNS (
             NESTED feature[*]
             COLUMNS (
                 feature_name VARCHAR2(50) PATH '$.name',
                 amount NUMBER(10) PATH '$.amount'
             )
         )
     ) jt
WHERE  jt.amount = 8;

-- ---------------------------------------------------------------------------------------
-- EAV
-- ---------------------------------------------------------------------------------------
SELECT pro.prod_id, pro.type product_type, pro.name,
       fe.name feature_name, feat.value amount
FROM product pro INNER JOIN 
     feature_eav fe ON (pro.prod_id = fe.prod_id) INNER JOIN
     feature_attribute_value feat ON (fe.feat_id = feat.feat_id) INNER JOIN
     attribute at ON (feat.attr_id = at.attr_id)
WHERE at.name = 'amount'
  AND feat.value = '8';
  
