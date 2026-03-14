--4) Cálculo do faturamento por mês e ano

WITH ticket_medium AS (  
    SELECT
        SUM(p.payment_value) AS revenue,
        COUNT (DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value)/COUNT(DISTINCT o.order_id) AS ticket_avg,
        SUBSTR(o.order_approved_at,1,7) AS month_year,
        SUBSTR(o.order_approved_at,1,4) AS year
    FROM orders o 
    INNER JOIN payments p 
    ON o.order_id = p.order_id
    WHERE o.order_approved_at IS NOT NULL
    AND o.order_status IS NOT 'canceled'
    GROUP BY SUBSTR(o.order_approved_at,1,7)
    ORDER BY month_year ASC, revenue DESC
),
ranked_ticket AS(
    SELECT
        year,
        month_year,
        total_orders,
        revenue,
        ticket_avg,
        RANK() OVER (PARTITION BY year ORDER BY revenue DESC) AS rank 
    FROM ticket_medium
)

SELECT
    rank,
    revenue,
    ticket_avg,
    total_orders,
    month_year,
    year
FROM ranked_ticket
ORDER BY month_year ASC;
