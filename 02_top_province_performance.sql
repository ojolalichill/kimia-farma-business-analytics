SELECT
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  ROUND(SUM(nett_sales), 2) AS total_nett_sales,
  ROUND(SUM(nett_profit), 2) AS total_nett_profit,
  DENSE_RANK() OVER (
    ORDER BY COUNT(DISTINCT transaction_id) DESC
  ) AS ranking_transaksi,
  DENSE_RANK() OVER (
    ORDER BY SUM(nett_sales) DESC
  ) AS ranking_nett_sales
FROM
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis`
GROUP BY
  provinsi
ORDER BY
  ranking_transaksi;
