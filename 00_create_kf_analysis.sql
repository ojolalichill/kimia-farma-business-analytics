CREATE OR REPLACE TABLE
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis` AS

WITH inventory_keys AS (
  SELECT
    branch_id,
    product_id
  FROM
    `rakamin-kf-analytics-514212.kimia_farma.kf_inventory`
  GROUP BY
    branch_id,
    product_id
),

base_data AS (
  SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    t.price AS actual_price,
    t.discount_percentage,
    t.rating AS rating_transaksi

  FROM
    `rakamin-kf-analytics-514212.kimia_farma.kf_final_transaction` AS t

  LEFT JOIN
    `rakamin-kf-analytics-514212.kimia_farma.kf_kantor_cabang` AS b
    ON t.branch_id = b.branch_id

  LEFT JOIN
    `rakamin-kf-analytics-514212.kimia_farma.kf_product` AS p
    ON t.product_id = p.product_id

  LEFT JOIN
    inventory_keys AS i
    ON t.branch_id = i.branch_id
    AND t.product_id = i.product_id
)

SELECT
  transaction_id,
  date,
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang,
  customer_name,
  product_id,
  product_name,
  actual_price,
  discount_percentage,

  CASE
    WHEN actual_price <= 50000 THEN 0.10
    WHEN actual_price <= 100000 THEN 0.15
    WHEN actual_price <= 300000 THEN 0.20
    WHEN actual_price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  actual_price * (1 - discount_percentage) AS nett_sales,

  (actual_price * (1 - discount_percentage)) *
  CASE
    WHEN actual_price <= 50000 THEN 0.10
    WHEN actual_price <= 100000 THEN 0.15
    WHEN actual_price <= 300000 THEN 0.20
    WHEN actual_price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,

  rating_transaksi

FROM
  base_data;
