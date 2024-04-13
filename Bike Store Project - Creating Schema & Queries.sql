-- create schemas
CREATE SCHEMA production;

CREATE SCHEMA sales;


-- create tables
CREATE TABLE `categories` (
    `category_id` int  NOT NULL ,
    `category_name` varchar(255)  NOT NULL ,
    PRIMARY KEY (
        `category_id`
    )
);

CREATE TABLE `brands` (
    `brand_id` int  NOT NULL ,
    `brand_name` varchar(255)  NOT NULL ,
    PRIMARY KEY (
        `brand_id`
    )
);

CREATE TABLE `products` (
    `product_id` int  NOT NULL ,
    `product_name` varchar(255)  NOT NULL ,
    `brand_id` int  NOT NULL ,
    `category_id` int  NOT NULL ,
    `model_year` int  NOT NULL ,
    `list_price` decimal(10,2)  NOT NULL ,
    PRIMARY KEY (
        `product_id`
    )
);

CREATE TABLE `customers` (
    `customer_id` int  NOT NULL ,
    `first_name` varchar(255)  NOT NULL ,
    `last_name` varchar(255)  NOT NULL ,
    `phone` varchar(25)  NOT NULL ,
    `email` varchar(255)  NOT NULL ,
    `street` varchar(255)  NOT NULL ,
    `city` varchar(50)  NOT NULL ,
    `state` varchar(25)  NOT NULL ,
    `zip_code` varchar(5)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `stores` (
    `store_id` int  NOT NULL ,
    `store_name` varchar(255)  NOT NULL ,
    `phone` varchar(25)  NOT NULL ,
    `email` varchar(255)  NOT NULL ,
    `street` varchar(255)  NOT NULL ,
    `city` varchar(255)  NOT NULL ,
    `state` varchar(25)  NOT NULL ,
    `zip_code` varchar(5)  NOT NULL ,
    PRIMARY KEY (
        `store_id`
    )
);

CREATE TABLE `staffs` (
    `staff_id` int  NOT NULL ,
    `first_name` varchar(50)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `email` varchar(255)  NOT NULL ,
    `phone` varchar(25)  NOT NULL ,
    `active` int  NOT NULL ,
    `store_id` int  NOT NULL ,
    `manager_id` int  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    ),
    CONSTRAINT `uc_staffs_email` UNIQUE (
        `email`
    )
);

CREATE TABLE `orders` (
    `order_id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `order_status` int  NOT NULL ,
    `order_date` date  NOT NULL ,
    `required_date` date  NOT NULL ,
    `shipped_date` date  NOT NULL ,
    `store_id` int  NOT NULL ,
    `staff_id` int  NOT NULL ,
    PRIMARY KEY (
        `order_id`
    )
);

CREATE TABLE `order_items` (
    `order_id` int  NOT NULL ,
    `item_id` int  NOT NULL ,
    `product_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    `list_price` decimal(10,2)  NOT NULL ,
    `discount` decimal(4,2)  NOT NULL ,
    PRIMARY KEY (
        `order_id`,`item_id`
    )
);

CREATE TABLE `stocks` (
    `store_id` int  NOT NULL ,
    `product_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `store_id`,`product_id`
    )
);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_brand_id` FOREIGN KEY(`brand_id`)
REFERENCES `brands` (`brand_id`);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_category_id` FOREIGN KEY(`category_id`)
REFERENCES `categories` (`category_id`);

ALTER TABLE `staffs` ADD CONSTRAINT `fk_staffs_store_id` FOREIGN KEY(`store_id`)
REFERENCES `stores` (`store_id`);

ALTER TABLE `staffs` ADD CONSTRAINT `fk_staffs_manager_id` FOREIGN KEY(`manager_id`)
REFERENCES `staffs` (`staff_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customers` (`customer_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_store_id` FOREIGN KEY(`store_id`)
REFERENCES `stores` (`store_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staffs` (`staff_id`);

ALTER TABLE `order_items` ADD CONSTRAINT `fk_order_items_order_id` FOREIGN KEY(`order_id`)
REFERENCES `orders` (`order_id`);

ALTER TABLE `order_items` ADD CONSTRAINT `fk_order_items_product_id` FOREIGN KEY(`product_id`)
REFERENCES `products` (`product_id`);

ALTER TABLE `stocks` ADD CONSTRAINT `fk_stocks_store_id` FOREIGN KEY(`store_id`)
REFERENCES `stores` (`store_id`);

ALTER TABLE `stocks` ADD CONSTRAINT `fk_stocks_product_id` FOREIGN KEY(`product_id`)
REFERENCES `products` (`product_id`);

