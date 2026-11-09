SELECT
  branch_id,
  branch_name,
  kota,
  provinsi,
  ROUND(AVG(rating_cabang), 2) AS rata_rating_cabang,
  ROUND(AVG(rating_transaksi), 2) AS rata_rating_transaksi,
  COUNT(DISTINCT transaction_id) AS total_transaksi
FROM
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis`
GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi
ORDER BY
  rata_rating_cabang DESC,
  rata_rating_transaksi ASC
LIMIT 5;
