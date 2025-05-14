-- Insert assessment user information
INSERT INTO users (name, email, phone)
VALUES ('assessment', 'gu@gmail.com', 328355333);

-- Get the user_id
SET @user_id = LAST_INSERT_ID();

-- Insert province information
INSERT INTO province (province_name)
VALUES ('Bắc Kạn');

-- Get the province_id
SET @province_id = LAST_INSERT_ID();

-- Insert district information
INSERT INTO district (district_name, province_id)
VALUES ('Ba Bể', @province_id);

-- Get the district_id
SET @district_id = LAST_INSERT_ID();

-- Insert commune information
INSERT INTO commune (commune_name, district_id)
VALUES ('Phúc Lộc', @district_id);

-- Get the commune_id
SET @commune_id = LAST_INSERT_ID();

-- Insert housing information
INSERT INTO housing (housing_type)
VALUES ('nhà riêng');

-- Get the housing_id
SET @housing_id = LAST_INSERT_ID();

-- Insert address information
INSERT INTO addresses (user_id, commune_id, address, housing_id)
VALUES (@user_id, @commune_id, '73 tân hòa 2', @housing_id);

-- Display user information
SELECT 
    u.name, 
    u.email, 
    u.phone,
    p.province_name AS province,
    d.district_name AS district,
    c.commune_name AS commune,
    a.address AS address,
    h.housing_type AS `housing type`
FROM users u
JOIN addresses a ON u.user_id = a.user_id
JOIN housing h ON h.housing_id = a.housing_id
JOIN commune c ON c.commune_id = a.commune_id
JOIN district d ON d.district_id = c.district_id
JOIN province p ON p.province_id = d.province_id;

-- Insert product information
INSERT INTO products (name, price, quantity, size, description)
VALUES ("KAPPA Women's Sneakers", 980000, 5, 36, 'This is a sneaker');

-- Get the product_id
SET @product_id = LAST_INSERT_ID();

-- Insert color information
INSERT INTO color (color)
VALUES ('yellow');

-- Get the color_id
SET @color_id = LAST_INSERT_ID();

-- Insert store information
INSERT INTO store (store_address)
VALUES ('abc Ho Chi Minh City');

-- Get the store_id
SET @store_id = LAST_INSERT_ID();

-- Insert product-store mapping
INSERT INTO product_store (store_id, product_id)
VALUES (@store_id, @product_id);

-- Insert category information
INSERT INTO category (category_name)
VALUES ('Sneakers');

-- Get the category_id
SET @category_id = LAST_INSERT_ID();

-- Insert product-category mapping
INSERT INTO product_category (product_id, category_id)
VALUES (@product_id, @category_id);

-- Insert model information
INSERT INTO model (model_name)
VALUES ('ABC');

-- Get the model_id
SET @model_id = LAST_INSERT_ID();

-- Insert product-model mapping
INSERT INTO product_model (product_id, model_id)
VALUES (@product_id, @model_id);

-- Insert brand information
INSERT INTO brand (brand_name)
VALUES ('KAPPA');

-- Get the brand_id
SET @brand_id = LAST_INSERT_ID();

-- Insert product-brand mapping
INSERT INTO product_brand (product_id, brand_id)
VALUES (@product_id, @brand_id);

-- Insert product-color mapping
INSERT INTO product_color (product_id, color_id)
VALUES (@product_id, @color_id);

-- Display product information
SELECT p.name, p.price, p.size, c.color
FROM products p 
JOIN product_color pc ON p.product_id = pc.product_id
JOIN color c ON c.color_id = pc.color_id;

-- Get information from a particular user
SELECT user_id INTO @user_id FROM users WHERE email = 'gu@gmail.com';

-- Insert order information
INSERT INTO orders (user_id)
VALUES (@user_id);

-- Get the order_id
SET @order_id = LAST_INSERT_ID();

-- Insert order details
INSERT INTO order_detail (order_id, product_id, quantity)
VALUES (@order_id, @product_id, 1);

-- Create the total price calculation function
DELIMITER $$

CREATE FUNCTION calculate_total_price(order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_price DECIMAL(10, 2);
    
    SELECT COALESCE(SUM(o.quantity * p.price), 0) INTO total_price
    FROM order_detail o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.order_id = order_id;

    RETURN total_price;
END$$

DELIMITER ;

-- Insert order history with total price calculation
INSERT INTO order_history (order_id, ship_option, receipt, payment_method, total_money, order_date)
VALUES (@order_id, 'Giao tận nơi', 'Yes', 'Online', calculate_total_price(@order_id), NOW());

-- Update product quantities after the order
UPDATE products p
JOIN order_detail o ON p.product_id = o.product_id
SET p.quantity = p.quantity - o.quantity
WHERE o.order_id = @order_id;

-- Display the result 
SELECT ship_option AS 'Ship Option',
       receipt AS 'Receipt',
       payment_method AS 'Payment Method',
       total_money AS 'Total Money',
       order_date AS 'Order Date'
FROM order_history
WHERE order_id = @order_id;

SELECT p.name AS 'Product name',
       cc.color AS 'Color',
       p.size AS 'Product size',
       o.quantity AS 'Quantity'
FROM products p JOIN order_detail o ON p.product_id = o.product_id
                JOIN product_color c ON c.product_id = p.product_id
                JOIN color cc ON c.color_id = cc.color_id;
WHERE order_id = @order_id;
