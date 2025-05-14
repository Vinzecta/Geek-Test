SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM
    order_history o
JOIN
    order_detail od ON o.order_id = od.order_id
JOIN
    products p ON p.product_id = od.product_id
WHERE
    YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY
    DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY
    month;
