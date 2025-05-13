CREATE TABLE warranty (
    warranty_id SERIAL PRIMARY KEY,
    warranty_detail TEXT NOT NULL
);

-- Product table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    size INT NOT NULL,
    description TEXT NOT NULL,
    warranty_id INT,
    FOREIGN KEY (warranty_id) REFERENCES warranty (warranty_id) ON DELETE SET NULL
);

CREATE TABLE discount (
    discount_id SERIAL PRIMARY KEY,
    discount_name VARCHAR(255) NOT NULL UNIQUE,
    discount_percentage DECIMAL(3, 2) NOT NULL
);

CREATE TABLE product_discount (
    discount_id INT NOT NULL,
    product_id INT NOT NULL,
    UNIQUE(discount_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES discount (discount_id) ON DELETE CASCADE 
);

CREATE TABLE store (
    store_id SERIAL PRIMARY KEY,
    product_quantity INT NOT NULL,
    store_address TEXT NOT NULL
);

CREATE TABLE product_store (
    store_id INT,
    product_id INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE color (
    color_id SERIAL PRIMARY KEY,
    color VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE product_category (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE CASCADE
);

CREATE TABLE product_color (
    product_id INT,
    color_id INT,
    PRIMARY KEY (product_id, color_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color (color_id) ON DELETE CASCADE
);

CREATE TABLE model (
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(255) NOT NULL
);

CREATE TABLE product_model (
    product_id INT,
    model_id INT,
    PRIMARY KEY (product_id, model_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    FOREIGN KEY (model_id) REFERENCES model (model_id) ON DELETE CASCADE
);

CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

CREATE TABLE product_brand (
    product_id INT,
    brand_id INT,
    PRIMARY KEY (product_id, brand_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    FOREIGN KEY (brand_id) REFERENCES brand (brand_id) ON DELETE CASCADE
);

-- Registered user
CREATE TABLE registered_user (
    registered_id SERIAL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(64) -- Assuming using SHA-256 as hashing algorithm
);

-- User table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    registered_id INT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone DECIMAL(11, 0) UNIQUE NOT NULL,
    FOREIGN KEY (registered_id) REFERENCES registered_user (registered_id) ON DELETE SET NULL
);

-- Address table
CREATE TABLE province (
    province_id SERIAL PRIMARY KEY,
    province_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE district (
    district_id SERIAL PRIMARY KEY,
    district_name VARCHAR(20) NOT NULL,
    province_id INT NOT NULL,
    FOREIGN KEY (province_id) REFERENCES province (province_id) ON DELETE CASCADE
);

CREATE TABLE commune (
    commune_id SERIAL PRIMARY KEY,
    commune_name VARCHAR(30) NOT NULL,
    district_id INT NOT NULL,
    UNIQUE(commune_name, district_id),
    FOREIGN KEY (district_id) REFERENCES district (district_id) ON DELETE CASCADE
);

-- Housing type table
CREATE TABLE housing (
    housing_id SERIAL PRIMARY KEY,
    housing_type VARCHAR(9) NOT NULL UNIQUE
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    commune_id INT NOT NULL,
    address TEXT NOT NULL,
    housing_id INT NOT NULL,
    FOREIGN KEY (housing_id) REFERENCES housing (housing_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (commune_id) REFERENCES commune (commune_id) ON DELETE CASCADE
);

-- Order
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE order_discount (
    order_id INT NOT NULL,
    discount_id INT NOT NULL,
    UNIQUE(order_id, discount_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES discount (discount_id) ON DELETE CASCADE
);

CREATE TABLE order_detail (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE order_history (
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
    ship_option VARCHAR(22) NOT NULL,
    receipt VARCHAR(3) NOT NULL,
    payment_method VARCHAR(8) NOT NULL,
    total_money DECIMAL(10, 2) NOT NULL,
    order_date DATETIME NOT NULL
);




