WITH rfm_metrics AS (
    SELECT 
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        MIN(o.order_purchase_timestamp) AS first_purchase,
        MAX(o.order_purchase_timestamp) AS last_purchase,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_monetary,
        MAX(1, (JULIANDAY(MAX(o.order_purchase_timestamp)) - JULIANDAY(MIN(o.order_purchase_timestamp))) / 30.44) AS lifespan_months
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN payments p ON o.order_id = p.order_id
    WHERE o.order_status != 'canceled'
    GROUP BY 1, 2, 3
)

SELECT 
    customer_unique_id,
    customer_city,
    customer_state,
    total_orders AS frequency,
    ROUND(total_monetary / total_orders, 2) AS ticket_avg,
    ROUND(total_monetary, 2) AS revenue,
    ROUND((total_monetary / lifespan_months), 2) AS monthly_avg_value
FROM rfm_metrics
ORDER BY revenue DESC;