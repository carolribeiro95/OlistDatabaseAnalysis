-- 2) Taxa de conversão de pagamento

WITH status_orders AS (  
    SELECT
        SUBSTR(order_purchase_timestamp,1,4) AS year,
        SUBSTR(order_purchase_timestamp,1,7) AS month_year,
        COUNT(order_id) AS total_orders,
        COUNT(CASE WHEN order_status = 'delivered' 
        OR order_status = 'shipped'
        THEN 1 END) AS total_orders_paid
    FROM orders
    WHERE year = '2017'
    GROUP BY month_year
)

SELECT
    month_year,
    total_orders,
    total_orders_paid,
    ROUND((total_orders_paid*100/total_orders),2) AS conversion_rate
FROM status_orders
ORDER BY month_year;