USE City_Sales;

CREATE TABLE Monthly_Sales (
  City VARCHAR(255),
  Year INT,
  Month INT,
  Sales INT
);

INSERT INTO Monthly_Sales (City, Year, Month, Sales) VALUES
  ('Delhi', 2020, 5, 4300),
  ('Delhi', 2020, 6, 2000),
  ('Delhi', 2020, 7, 2100),
  ('Delhi', 2020, 8, 2200),
  ('Delhi', 2020, 9, 1900),
  ('Delhi', 2020, 10, 200),
  ('Mumbai', 2020, 5, 4400),
  ('Mumbai', 2020, 6, 2800),
  ('Mumbai', 2020, 7, 6000),
  ('Mumbai', 2020, 8, 9300),
  ('Mumbai', 2020, 9, 4200),
  ('Mumbai', 2020, 10, 9700),
  ('Bangalore', 2020, 5, 1000),
  ('Bangalore', 2020, 6, 2300),
  ('Bangalore', 2020, 7, 6800),
  ('Bangalore', 2020, 8, 7000),
  ('Bangalore', 2020, 9, 2300),
  ('Bangalore', 2020, 10, 8400);



SELECT City, Year, Month, Sales,
    CASE WHEN City = 'Delhi' THEN LAG(Sales) OVER (PARTITION BY City ORDER BY Year, Month) ELSE NULL END AS Previous_Month_Sales,
    CASE WHEN City = 'Delhi' THEN LEAD(Sales) OVER (PARTITION BY City ORDER BY Year, Month) ELSE NULL END AS Next_Month_Sales,
    CASE WHEN City = 'Delhi' THEN SUM(Sales) OVER (PARTITION BY City ORDER BY Year, Month) ELSE NULL END AS YTD_Sales
FROM Monthly_Sales
ORDER BY CASE WHEN City = 'Delhi' THEN 0 ELSE 1 END, City, Month;