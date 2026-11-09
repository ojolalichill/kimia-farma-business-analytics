SELECT
  provinsi,
  ROUND(SUM(nett_profit), 2) AS total_nett_profit,
  ROUND(SUM(nett_sales), 2) AS total_nett_sales,
  COUNT(DISTINCT transaction_id) AS total_transaksi
FROM
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis`
GROUP BY
  provinsi
ORDER BY
  total_nett_profit DESC;
