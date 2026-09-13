DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id  INT PRIMARY KEY,
    first_name   VARCHAR(100) NOT NULL,
    last_name    VARCHAR(100) NOT NULL,
    title        VARCHAR(100) NOT NULL,
    birth_date   DATE         NOT NULL,
    notes        TEXT
);

CREATE TABLE customers (
    customer_id  VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(1000) NOT NULL,
    contact_name VARCHAR(1000) NOT NULL
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  VARCHAR(10) NOT NULL,
    employee_id  INT  NOT NULL,
    order_date   DATE NOT NULL,
    ship_city    VARCHAR(1000) NOT NULL,

    CONSTRAINT orders_customer_fk FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),
    CONSTRAINT orders_employee_fk FOREIGN KEY (employee_id)
        REFERENCES employees (employee_id)
);
