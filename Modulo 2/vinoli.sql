--DROP DATABASE IF EXISTS vinoli;

--CREATE DATABASE IF NOT EXISTS vinoli;

--USE vinoli;


DROP DATABASE IF EXISTS users;
DROP DATABASE IF EXISTS products;
DROP DATABASE IF EXISTS categories;
DROP DATABASE IF EXISTS products_categories;
DROP DATABASE IF EXISTS shopping_carts;
DROP DATABASE IF EXISTS Shopping_cart_products;


CREATE TABLE IF NOT EXISTS users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    price INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products_categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    category_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(products_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS shopping_carts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS shopping_cart_products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    shopping_cart_id INT,
    products_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(shopping_cart_id) REFERENCES shopping_carts(id) ON DELETE CASCADE,
    FOREIGN KEY(products_id) REFERENCES products(id) ON DELETE CASCADE
);


-- Users

INSERT INTO users(username) VALUES("user1"); --Carrito de compras

INSERT INTO users(username) VALUES("user2"); --Carrito de compras

INSERT INTO users(username) VALUES("user3"); --Carrito de compras

INSERT INTO users(username) VALUES("user4"); --Carrito de compras

--Products

INSERT INTO products(name, price) VALUES("Manzana",1);

INSERT INTO products(name, price) VALUES("Coco",2);


INSERT INTO products(name, price) VALUES("Smartphone",400);

INSERT INTO products(name, price) VALUES("Lapto",600);

INSERT INTO products(name, price) VALUES("Monitor",300);

INSERT INTO products(name, price) VALUES("Remera",30);

INSERT INTO products(name, price) VALUES("Camisa",40);

INSERT INTO products(name, price) VALUES("Sudadera",40);

--Categories


INSERT INTO categories(name) VALUES("Comida");
INSERT INTO categories(name) VALUES("Tecnologias");
INSERT INTO categories(name) VALUES("Ropa");
INSERT INTO categories(name) VALUES("Autos");

--Products Categories
INSERT INTO products_categories(product_id, category_id) VALUES(1,1);
INSERT INTO products_categories(product_id, category_id) VALUES(2,1);
INSERT INTO products_categories(product_id, category_id) VALUES(3,2);
INSERT INTO products_categories(product_id, category_id) VALUES(4,2);
INSERT INTO products_categories(product_id, category_id) VALUES(5,2);
INSERT INTO products_categories(product_id, category_id) VALUES(6,3);
INSERT INTO products_categories(product_id, category_id) VALUES(7,3);
INSERT INTO products_categories(product_id, category_id) VALUES(8,3);

--Shopping cart
INSERT INTO shopping_carts(user_id) VALUES(1);
INSERT INTO shopping_carts(user_id) VALUES(2);
INSERT INTO shopping_carts(user_id) VALUES(3);

--Shopping_cart_products
INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(1,1);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(1,2);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(1,3);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(2,1);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(2,2);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(2,3);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(2,4);

INSERT INTO shopping_cart_products(shopping_cart_id, products_id) VALUES(2,5);


-- INNER JOIN products_categories ON products.id = product_categories.product_id
-- WHERE product_categories.category_id = 1;

SELECT *
FROM products
INNER JOIN products_categories ON products.id = products_categories.products_id
WHERE products_categories.category_id = 1;

-- NATURAL JOIN  products_categories : nos ahorramos el campo que tenemos que buscar.
-- SUM : suma en sql.

-- OBTENER EL NOMBRE DE LA CATEGORIA CON MAS PRODUCTOS.

SELECT categories.name, COUNT(*) AS total
FROM categories
INNER JOIN product_categories ON categories.id = product_categories.category_id
GROUP BY Categories.id;

-- OBTENER TODOS AQUELLOS PRODUCTOS EN UN CARRITO DE COMPRA.

SELECT * FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.products_id;

-- Listar todos los productos del usuario cuyo id es 1.

SELECT * FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id;
INNER JOIN shopping_carts ON products.id = shopping_carts.user_id
WHERE shopping_carts.user_id = 1;