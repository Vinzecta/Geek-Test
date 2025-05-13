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
