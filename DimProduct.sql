-- Cleansed DimProduct Table
SELECT
  p.ProductKey,
  p.ProductAlternateKey AS ProductItemCode,
  --,[ProductSubcategoryKey]
  --,[WeightUnitMeasureCode]
  --,[SizeUnitMeasureCode]
  p.EnglishProductName AS ProductName,
  ps.EnglishProductSubcategoryName AS Subcategory,
  pc.EnglishProductCategoryName AS ProductCategory,
  --,[SpanishProductName]
  --,[FrenchProductName]
  --,[StandardCost]
  --,[FinishedGoodsFlag]
  p.Color AS ProductColor,
  --,[SafetyStockLevel]
  --,[ReorderPoint]
  --,[ListPrice]
  p.Size AS ProductSize,
  --,[SizeRange]
  --,[Weight]
  --,[DaysToManufacture]
  p.ProductLine,
  --,[DealerPrice]
  --,[Class]
  --,[Style]
  p.ModelName AS ProductModelName,
  --,[LargePhoto]
  p.EnglishDescription AS ProductDescription,
  --,[FrenchDescription]
  --,[ChineseDescription]
  --,[ArabicDescription]
  --,[HebrewDescription]
  --,[ThaiDescription]
  --,[GermanDescription]
  --,[JapaneseDescription]
  --,[TurkishDescription]
  --,[StartDate]
  --,[EndDate]
  ISNULL(p.Status, 'Outdated') AS ProductStatus
FROM [AdventureWorksDW2019].[dbo].[DimProduct] p
LEFT JOIN dbo.DimProductSubcategory ps 
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory pc 
	ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY p.ProductKey ASC
