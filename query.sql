-- Insert assessment user information
INSERT INTO users (name, email, phone)
VALUES ('assessment', 'gu@gmail.com', 328355333);

SET @user_id = LAST_INSERT_ID();

INSERT INTO province (province_name)
VALUES ('Bắc Kạn');

SET @province_id = LAST_INSERT_ID();

INSERT INTO district (district_name, province_id)
VALUES ('Ba Bể', @province_id);

SET @district_id = LAST_INSERT_ID();

INSERT INTO commune (commune_name, district_id)
VALUES ('Phúc Lộc', @district_id);

SET @commune_id = LAST_INSERT_ID();

INSERT INTO housing (housing_type)
VALUES ('nhà riêng');

SET @housing_id = LAST_INSERT_ID();

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
INSERT INTO products (name, price, size, description)
VALUES ("KAPPA Women's Sneakers", 980000, 36, 'This is a sneaker');
SET @product_id = LAST_INSERT_ID();

INSERT INTO color (color)
VALUES ('yellow');

SET @color_id = LAST_INSERT_ID();

INSERT INTO discount (discount_name, discount_percentage)
VALUES ('50% OFF', 0.5);

SET @discount_id = LAST_INSERT_ID();

INSERT INTO product_discount (discount_id, product_id)
VALUES (@discount_id, @product_id);

INSERT INTO store (store_address)
VALUES ('abc Ho Chi Minh City');

SET @store_id = LAST_INSERT_ID();

INSERT INTO product_store (store_id, product_id)
VALUES (@store_id, @product_id);

INSERT INTO category (category_name)
VALUES ('Sneakers');

SET @category_id = LAST_INSERT_ID();

INSERT INTO product_category (product_id, category_id)
VALUES (@product_id, @category_id);

INSERT INTO model (model_name)
VALUES ('ABC');

SET @model_id = LAST_INSERT_ID();

INSERT INTO product_model(product_id, model_id)
VALUES (@product_id, @model_id);

INSERT INTO brand (brand_name)
VALUES ('KAPPA');

SET @brand_id = LAST_INSERT_ID();

INSERT INTO product_brand (product_id, brand_id)
VALUES (@product_id, @brand_id);

INSERT INTO product_color (product_id, color_id)
VALUES (@product_id, @color_id);

-- Display product
SELECT p.name, p.price, p.size, c.color
FROM products p JOIN product_color pc ON p.product_id = pc.product_id
                JOIN color c ON c.color_id = pc.color_id;


