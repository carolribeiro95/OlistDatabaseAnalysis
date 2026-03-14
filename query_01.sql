-- 1) Quais são os clientes responsáveis por 80% do 
-- faturamento da empresa em 2017?

WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_spent
    FROM customers c
    INNER JOIN orders o 
    ON c.customer_id = o.customer_id
    INNER JOIN payments p 
    ON o.order_id = p.order_id
    WHERE substr(o.order_purchase_timestamp,1,4) = '2017'
    GROUP BY c.customer_unique_id
    ORDER BY total_spent DESC
),
cumulative_sum AS(
    SELECT
        customer_unique_id,
        total_spent,
        total_orders,
        SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_spent,
        SUM(total_spent) OVER () AS total_global 
    FROM customer_spending 
)

SELECT
    customer_unique_id,
    total_spent,
    ROUND((cumulative_spent * 100/total_global),2) AS "percent_cumulative(%)"
FROM cumulative_sum
WHERE (cumulative_spent/total_global) <= 0.8
ORDER BY total_spent DESC;


-- Qual a porcentagem de clientes representa 80% do faturamento em 2017?

WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_spent
    FROM customers c
    INNER JOIN orders o 
    ON c.customer_id = o.customer_id
    INNER JOIN payments p 
    ON o.order_id = p.order_id
    WHERE substr(o.order_purchase_timestamp,1,4) = '2017'
    GROUP BY c.customer_unique_id
    ORDER BY total_spent DESC
),
cumulative_sum AS(
    SELECT
        customer_unique_id,
        SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_spent,
        SUM(total_spent) OVER () AS total_global,
        COUNT(*) OVER () AS total_customers 
    FROM customer_spending 
),
pareto AS (
    SELECT * 
    FROM cumulative_sum
    WHERE (cumulative_spent/total_global) <= 0.8
)

SELECT
    COUNT(*) AS vip_customers,
    total_customers,
    ROUND((COUNT(*)*100/total_customers),2) AS customers_vip_percent,
    "80%" AS revenue_percent
FROM pareto;

-- Qual a porcentagem de clientes representa 80% do faturamento em 2018?

WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_spent
    FROM customers c
    INNER JOIN orders o 
    ON c.customer_id = o.customer_id
    INNER JOIN payments p 
    ON o.order_id = p.order_id
    WHERE substr(o.order_purchase_timestamp,1,4) = '2018'
    GROUP BY c.customer_unique_id
    ORDER BY total_spent DESC
),
cumulative_sum AS(
    SELECT
        customer_unique_id,
        SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_spent,
        SUM(total_spent) OVER () AS total_global,
        COUNT(*) OVER () AS total_customers 
    FROM customer_spending 
),
pareto AS (
    SELECT * 
    FROM cumulative_sum
    WHERE (cumulative_spent/total_global) <= 0.8
)

SELECT
    COUNT(*) AS vip_customers,
    total_customers,
    ROUND((COUNT(*)*100/total_customers),2) AS customers_vip_percent,
    "80%" AS revenue_percent
FROM pareto;