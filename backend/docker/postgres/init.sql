CREATE TABLE IF NOT EXISTS Category (
    NAME VARCHAR(255) PRIMARY KEY,
    DESCRIPTION TEXT
);

CREATE TABLE IF NOT EXISTS Supplier (
    ID_SUPPLIER SERIAL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    ADDRESS VARCHAR(255),
    PHONE VARCHAR(20),
    EMAIL VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Product (
    ID_PROD SERIAL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    DESCRIPTION TEXT,
    PRICE_U_TABLE NUMERIC(10, 2) NOT NULL,
    PRICE_U_RETAIL NUMERIC(10, 2) NOT NULL,

    CATEGORY VARCHAR(255) REFERENCES Category(NAME) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Raw_Product (
    ID_RAW SERIAL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    UOM VARCHAR(10) NOT NULL,
    AMOUNT NUMERIC(10, 4) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product_Recipe (
    ID_PROD INT NOT NULL,
    ID_RAW INT NOT NULL,
    AMOUNT NUMERIC(10, 4) NOT NULL,

    PRIMARY KEY (ID_PROD, ID_RAW),
    FOREIGN KEY (ID_PROD) REFERENCES Product(ID_PROD) ON DELETE CASCADE,
    FOREIGN KEY (ID_RAW) REFERENCES Raw_Product(ID_RAW) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Order" (
    ID_ORDER SERIAL PRIMARY KEY,
    DATE TIMESTAMP NOT NULL,
    TABLE_NUMBER VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Order_Details (
    ID_ORDER INT NOT NULL,
    ID_PROD INT NOT NULL,
    QUANTITY INT NOT NULL,
    DISCOUNT NUMERIC(10, 2),

    PRIMARY KEY (ID_ORDER, ID_PROD),
    FOREIGN KEY (ID_ORDER) REFERENCES "Order"(ID_ORDER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PROD) REFERENCES Product(ID_PROD) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "Transaction" (
    ID_SUPPLIER INT NOT NULL,
    ID_RAW INT NOT NULL,
    DATE TIMESTAMP NOT NULL,
    AMOUNT NUMERIC(10, 4) NOT NULL,
    PRICE NUMERIC(10, 2),
    
    PRIMARY KEY (ID_SUPPLIER, ID_RAW, DATE),
    FOREIGN KEY (ID_SUPPLIER) REFERENCES Supplier(ID_SUPPLIER) ON DELETE CASCADE,
    FOREIGN KEY (ID_RAW) REFERENCES Raw_Product(ID_RAW) ON DELETE CASCADE
);