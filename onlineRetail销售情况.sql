SELECT * FROM `onlineretail_clean`
LIMIT 5

-- 查询总销售额，总订单数，总客户数
SELECT 
    ROUND(SUM(TotalAmount),2) AS TotalSales,
    Count(DISTINCT InvoiceNo) AS TotalOrders,
    COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM onlineretail_clean

-- 每月销售额趋势
SELECT 
    Year, Month, ROUND(SUM(TotalAmount),3) AS MonthlySales, 
    RTRIM(ROUND(SUM(TotalAmount),3)) AS MonthlySales2,
    CONVERT(SUM(TotalAmount),DECIMAL(20,3)) AS MonthlySales3
FROM onlineretail_clean
GROUP BY Year, Month
ORDER BY Year, Month

-- 各国销售额 Top 5
SELECT 
    Country, 
    CONVERT(SUM(TotalAmount),DECIMAL(20,3)) AS totalSales
FROM onlineretail_clean
GROUP BY Country
ORDER BY totalSales DESC
LIMIT 5

-- 销售额 Top 10 的产品（按描述）
SELECT 
    Description,
    SUM(Quantity) AS totalQuantity,
    CONVERT(SUM(TotalAmount),DECIMAL(20,3)) AS totalSales
FROM onlineretail_clean
GROUP BY Description
ORDER BY TotalSales DESC
LIMIT 10

-- 客户总数
SELECT count(Distinct CustomerID) AS customerNum
FROM onlineretail_clean


-- 客户购买频次分布（一次、两次、三次…）
SELECT 
    OrderCount,
    Count(CustomerID) AS CustomerCount
FROM
    (SELECT 
        CustomerID,
        Count(DISTINCT InvoiceNo) AS OrderCount
    FROM onlineretail_clean
    GROUP BY CustomerID
    ) as CustomerOrder
GROUP BY OrderCount
ORDER BY OrderCount DESC








