-- Script 05_typo.sql
-- For presentation daulity view
-- Andrea Kennel
-- 21.04.2024

-- ---------------------------------------------------------------------------------------
-- JSON mit falschen Daten
-- ---------------------------------------------------------------------------------------
INSERT INTO product_collection (json_data)
VALUES ('
{
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
    }');

COMMIT;

SELECT * FROM product_collection;

SELECT pc.json_data.type, count(*)
FROM product_collection pc
GROUP BY pc.json_data.type;

