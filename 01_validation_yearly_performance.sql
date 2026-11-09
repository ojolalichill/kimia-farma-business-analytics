SELECT
  COUNT(*) AS total_transaksi,
  COUNT(DISTINCT transaction_id) AS transaksi_unik,
  COUNT(DISTINCT branch_id) AS jumlah_cabang,
  MIN(date) AS tanggal_awal,
  MAX(date) AS tanggal_akhir,
  ROUND(SUM(nett_sales), 2) AS total_nett_sales,
  ROUND(SUM(nett_profit), 2) AS total_nett_profit,
  ROUND(AVG(rating_cabang), 2) AS rata_rating_cabang,
  ROUND(AVG(rating_transaksi), 2) AS rata_rating_transaksi
FROM
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis`;

SELECT
  EXTRACT(YEAR FROM date) AS tahun,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  ROUND(SUM(nett_sales), 2) AS total_nett_sales,
  ROUND(SUM(nett_profit), 2) AS total_nett_profit,
  ROUND(AVG(rating_transaksi), 2) AS rata_rating_transaksi
FROM
  `rakamin-kf-analytics-514212.kimia_farma.kf_analysis`
GROUP BY
  tahun
ORDER BY
  tahun;
