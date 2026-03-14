-- 3) Taxa de aprovação de pedidos por ano e estado
WITH orders_status AS (
    SELECT 
        c.customer_unique_id,
        o.order_id,
        p.payment_type,
        p.payment_value,
        o.order_status,
        o.order_approved_at,
        c.customer_city,
        c.customer_state,
        COUNT(o.order_id) AS total_orders,
        COUNT(CASE WHEN
            o.order_status = 'delivered' OR o.order_status = 'shipped'
        THEN 1 END) AS total_orders_concluded,
        SUBSTR(o.order_approved_at,1,7) AS month_year,
        SUBSTR(o.order_approved_at,1,4) AS year
    FROM orders o
    INNER JOIN payments p 
    ON o.order_id = p.order_id
    INNER JOIN customers c 
    ON o.customer_id = c.customer_id
    WHERE o.order_approved_at IS NOT NULL
    GROUP BY c.customer_state, year
)

SELECT
    year,
    customer_state,
    total_orders,
    total_orders_concluded,
    ROUND((total_orders_concluded*100/total_orders),2) AS approved_orders_rate
FROM orders_status
ORDER BY year, approved_orders_rate DESC;