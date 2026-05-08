-- 1. Count transactions by status
SELECT status, COUNT(*) AS total_transactions
FROM transactions
GROUP BY status;
-- 2. Total captured GMV by merchant
SELECT merchant_name, SUM(amount_usd) AS captured_gmv
FROM transactions
WHERE status = 'CAPTURED'
GROUP BY merchant_name;
-- 3. Show top 10 merchants by captured GMV
SELECT merchant_name, SUM(amount_usd) AS captured_gmv
FROM transactions
WHERE status = 'CAPTURED'
GROUP BY merchant_name
ORDER BY captured_gmv DESC
LIMIT 10;
-- 4. Show daily GMV and successful transaction count
SELECT transaction_date,
       SUM(amount_usd) AS daily_gmv,
       COUNT(*) AS successful_transaction_count
FROM transactions
WHERE status = 'CAPTURED'
GROUP BY transaction_date
ORDER BY transaction_date;
-- 5. Find merchants with chargeback ratio above 1%
SELECT merchant_name,
       SUM(CASE WHEN status='CHARGEBACK' THEN 1 ELSE 0 END)100.0/COUNT() AS chargeback_ratio
FROM transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 1
-- 6. Find regions with average risk score above 50 and more than 20 transactions
SELECT gateway_region,
       AVG(risk_score) AS avg_risk_score,
       COUNT(*) AS total_transactions
FROM transactions
GROUP BY gateway_region
HAVING AVG(risk_score) > 50
AND COUNT(*) > 20;
-- 7. Find users with 3 or more failed or chargeback transactions on same day
SELECT user_id,
       transaction_date,
       COUNT(*) AS failed_count
FROM transactions
WHERE status IN ('FAILED','CHARGEBACK')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;
-- 8. Show chargeback count, unique affected users and chargeback amount by merchant
SELECT merchant_name,
       COUNT(*) AS chargeback_count,
       COUNT(DISTINCT user_id) AS unique_affected_users,
       SUM(amount_usd) AS chargeback_amount
FROM transactions
WHERE status='CHARGEBACK'
GROUP BY merchant_name;
