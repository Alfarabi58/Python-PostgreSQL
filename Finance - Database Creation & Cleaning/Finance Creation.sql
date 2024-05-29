-- untuk membuat tabel df
CREATE TABLE df (
    id SERIAL PRIMARY KEY,
    Segment INTEGER,
	Country INTEGER,
	Product INTEGER,
	Discount_Band INTEGER,
	Units_Sold FLOAT,
	Manufacturing FLOAT,
	Sale_Price FLOAT,
	Gross_Sales FLOAT,
	Discounts FLOAT,
	Sales FLOAT,
	COGS FLOAT,
	Profit FLOAT,
	Date DATE,
	Month_Number DATE,
	Month_Name VARCHAR(100),
	Year INTEGER
);

-- untuk membuat tabel segment
CREATE TABLE Segment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- untuk membuat tabel country
CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
	
-- untuk membuat tabel product
CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
	
-- untuk membuat tabel discount_band
CREATE TABLE Discount_Band (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- untuk masukin value ke tabel df
COPY df(Segment, Country, Product, Discount_Band, Units_Sold, Manufacturing, Sale_Price, Gross_Sales, Discounts, Sales, COGS, Profit, Date, Month_Number, Month_Name, Year)
FROM 'C:\tmp\df_done'
DELIMITER ','
CSV HEADER;

-- untuk masukin value ke tabel segment
COPY Segment(name)
FROM 'C:\tmp\Segment_baru'
DELIMITER ','
CSV HEADER;

-- untuk masukin value ke tabel country
COPY Country(name)
FROM 'C:\tmp\Country_baru'
DELIMITER ','
CSV HEADER;

-- untuk masukin value ke tabel product
COPY Product(name)
FROM 'C:\tmp\Produk_baru'
DELIMITER ','
CSV HEADER;

-- untuk masukin value ke tabel discount band
COPY Discount_Band(name)
FROM 'C:\tmp\Discount_Band_baru'
DELIMITER ','
CSV HEADER;

-- untuk membuat user dan password
CREATE USER user_1 WITH PASSWORD '11111';
CREATE USER user_2 WITH PASSWORD '22222';

-- untuk memberikan akses select kepada user_1
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_1; --user
-- untuk memberikan seluruh akses kepada user_2
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO user_2; --admin

-- untuk mengecek akses yang diberikan kepada user_1 udah sesuai atau belum
SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'df' AND grantee = 'user_1';
-- untuk mengecek akses yang diberikan kepada user_2 udah sesuai atau belum
SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'df' AND grantee = 'user_2';

-- untuk menampilkan tabel
select * from df
select * from segment
select * from country
select * from product
select * from discount_band

-- untuk menampilkan total profit dari masing-masing segment
SELECT Segment, SUM(Profit) AS total_profit
FROM df
WHERE Discounts > 0
GROUP BY Segment
ORDER BY 1 DESC;

-- untuk menampilkan rata-rata, minimum, maksimum dari sales masing-masing negara
SELECT Country,
    AVG(Sales) AS rata_rata_sales,
    MIN(Sales) AS sales_minimum,
    MAX(Sales) AS sales_maksimum
FROM df
GROUP BY Country
ORDER BY 1 DESC;

-- untuk menyimpan hasil query kedalam format csv
COPY (
    SELECT Segment, SUM(Profit) AS total_profit
    FROM df
    WHERE Discounts > 0
    GROUP BY Segment
) TO 'C:\tmp\Tabel_1A' WITH CSV HEADER;

COPY (
    SELECT Country, AVG(Sales) AS rata_rata_sales, MIN(Sales) AS sales_minimum, MAX(Sales) AS sales_maksimum
    FROM df
    GROUP BY Country
) TO 'C:\tmp\Tabel_1B' WITH CSV HEADER;

-- proses diatas yang pertama melakukan pembuatan database baru yang terdiri dari tabel df, segment, country, product, discount band,
-- setelah itu memasukan value dari file CSV, lalu membuat user beserta passwordnya serta memberikan akses, 
-- setelah itu melakukan pengujian data dan menyimpan hasil query dalam format CSV
