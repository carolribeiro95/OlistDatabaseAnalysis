--5) Quais as categorias de produtos mais venderam por ano?

WITH payments_per_orders AS (
    SELECT 
        order_id, 
        SUM(payment_value) AS order_value
    FROM payments
    GROUP BY order_id

),
total_orders_category AS (
    SELECT
        p.product_category_name AS category,
        SUM(i.price) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUBSTR(o.order_purchase_timestamp,1,4) AS year    
    FROM orders o
    INNER JOIN items i
    ON o.order_id = i.order_id
    INNER JOIN products p 
    ON i.product_id = p.product_id
    INNER JOIN payments_per_orders pay
    ON o.order_id = pay.order_id
    WHERE o.order_estimated_delivery_date IS NOT NULL
    AND p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name, year
),

ranked_category AS(
    SELECT
        *,
        (total_revenue/total_orders) AS ticker_avg,
        RANK() OVER (PARTITION BY year ORDER BY total_revenue DESC) AS ranking
    
    FROM total_orders_category
    WHERE category IS NOT NULL
    AND year IS NOT NULL
)

SELECT 
   category,
   total_orders,
   total_revenue,
   year,
   ticker_avg,
   ranking 
FROM ranked_category
WHERE ranking <=10
ORDER BY year DESC, ranking ASC;

