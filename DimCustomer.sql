-- Cleansed DimCustomer Table
SELECT
  c.[CustomerKey],
  --,[GeographyKey]
  -- ,[CustomerAlternateKey]
  --  ,[Title]
  c.[FirstName]
  --,[MiddleName]
  ,
  c.[LastName],
  c.FirstName + ' ' + c.LastName AS [FullName]
  --  ,[NameStyle]
  --  ,[BirthDate]
  --  ,[MaritalStatus]
  --  ,[Suffix]
  ,
  CASE c.Gender
    WHEN 'M' THEN 'Male'
    WHEN 'F' THEN 'Female'
  END AS Gender,
  --,[EmailAddress]
  --  ,[YearlyIncome]
  --  ,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  c.[DateFirstPurchase],
  --,[CommuteDistance]
  g.City AS 'CustomerCity'
FROM [AdventureWorksDW2019].[dbo].[DimCustomer] c
LEFT JOIN dbo.DimGeography g
  ON g.GeographyKey = c.GeographyKey
ORDER BY CustomerKey ASC