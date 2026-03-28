SELECT product_id, COUNT(*)
FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.product`
GROUP BY product_id
HAVING COUNT(*) > 1;

WITH null_check_pi AS (
    SELECT
        COUNT(*) AS total_rows,
        SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
        SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name,
        SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS null_product_category,
        SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price
    FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.product`
)

SELECT *
FROM null_check_pi;

SELECT Inventory_ID, COUNT(*)
FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.inventory`
GROUP BY Inventory_ID
HAVING COUNT(*) > 1;

WITH null_check_ii AS (
    SELECT
        COUNT(*) AS total_rows,
        SUM(CASE WHEN Inventory_ID IS NULL THEN 1 ELSE 0 END) AS null_inventory_id,
        SUM(CASE WHEN branch_id IS NULL THEN 1 ELSE 0 END) AS null_branch_id,
        SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
        SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name,
        SUM(CASE WHEN opname_stock IS NULL THEN 1 ELSE 0 END) AS null_opname_stock
    FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.inventory`
)

SELECT *
FROM null_check_ii;

SELECT branch_id, COUNT(*)
FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.kantor_cabang`
GROUP by branch_id
HAVING COUNT (*)>1;

WITH null_check_kb as (
    SELECT 
        COUNT(*) AS total_row,
        SUM(CASE WHEN branch_id IS NULL THEN 1 ELSE 0 END) AS null_branch_id,
        SUM(CASE WHEN branch_category IS NULL THEN 1 ELSE 0 END) AS null_branch_category,
        SUM(CASE WHEN branch_name IS NULL THEN 1 ELSE 0 END) AS null_branch_name,
        SUM(CASE WHEN kota IS NULL THEN 1 ELSE 0 END) AS null_kota,
        SUM(CASE WHEN provinsi is NULL THEN 1 ELSE 0 END) AS null_provc,
        SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating
    FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.kantor_cabang`
)

SELECT *
FROM null_check_kb;

SELECT transaction_id, COUNT(*)
FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.final_transaction`
GROUP BY transaction_id
HAVING COUNT (*)>1;

WITH null_check_ti as (
    SELECT
        COUNT(*) AS total_row,
        SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
        SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
        SUM(CASE WHEN branch_id is null then 1 else 0 end) as null_branch_id,
        SUM(CASE WHEN customer_name is NULL THEN 1 ELSE 0 END) as null_customer_name,
        SUM(CASE WHEN product_id is Null THEN 1 ELSE 0 END) AS null_product_id,
        SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
        SUM(CASE WHEN discount_percentage is NULL THEN 1 ELSE 0 END) AS null_discount_percentage,
        SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating
    FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.final_transaction`)


SELECT*
FROM null_check_ti;

WITH sales_order as (
    SELECT
      ft.transaction_id, ft.date, ft.branch_id, ft.customer_name, ft.product_id, ft.price as actual_price, ft.discount_percentage, ft.rating as rating_transaksi, 
      (CASE 
            WHEN ft.price <= 50000 THEN 0.1
            WHEN ft.price <= 100000 THEN 0.15
            WHEN ft.price <= 300000 THEN 0.2
            WHEN ft.price <= 500000 THEN 0.25
            ELSE 0.3 END ) AS persentase_gross_laba,
      ft.price-(ft.price*ft.discount_percentage) AS nett_sales
    FROM `rakamin-pbi-kimia-farma-490322.kimia_farma.final_transaction` ft)
SELECT 
  so.transaction_id,so.date,so.branch_id,kb.branch_name,kb.kota,kb.provinsi,kb.rating as rating_cabang,so.customer_name,so.product_id,p.product_name,so.actual_price,so.discount_percentage,so.persentase_gross_laba,so.nett_sales,so.nett_sales * so.persentase_gross_laba as nett_profitt,so.rating_transaksi
FROM sales_order so
JOIN `rakamin-pbi-kimia-farma-490322.kimia_farma.kantor_cabang` kb
ON so.branch_id = kb.branch_id
JOIN `rakamin-pbi-kimia-farma-490322.kimia_farma.product` p
ON so.product_id = p.product_id
GROUP BY so.date,so.transaction_id,so.date,so.branch_id,kb.branch_name,kb.kota,kb.provinsi,kb.rating,so.customer_name,so.product_id,p.product_name,so.actual_price, so.discount_percentage,so.persentase_gross_laba,so.nett_sales,so.rating_transaksi
ORDER BY so.date ASC;