
--Changing date format

SELECT SaleDateConverted, CONVERT(date,SaleDate) AS Date
FROM nashvilleHousing

UPDATE nashvilleHousing
SET SaleDate = CONVERT(date,SaleDate)

ALTER TABLE nashvilleHousing
ADD SaleDateConverted Date

update nashvilleHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

--property Address

SELECT *
FROM project1.dbo.nashvilleHousing
--WHERE propertyAddress is NULL
ORDER BY ParcelID


SELEct *
FROM project1.dbo.nashvilleHousing

SELECT a.ParcelID ,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM project1.dbo.nashvilleHousing a 
JOIN project1.dbo.nashvilleHousing b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM project1.dbo.nashvilleHousing a 
JOIN project1.dbo.nashvilleHousing b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is NULL

--Address,city,state

SELECT *
FROM nashvilleHousing

SELECT OwnerAddress
FROM nashvilleHousing

SELECT 
SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1) AS Address,
  SUBSTRING(OwnerAddress,CHARINDEX(',',OwnerAddress) +1,LEN(OwnerAddress)) As City,
     
FROM project1.dbo.nashvilleHousing

--SELECT 
--SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)) AS Address
--FROM project1.dbo.nashvilleHousing


ALTER TABLE nashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

update nashvilleHousing
SET OwnerSplitAddress = SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1) 

ALTER TABLE nashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

update nashvilleHousing
SET OwnerSplitCity = SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1)

 

SELECT
PARSENAME(REPLACE(OwnerSplitCity,',','.'),1) AS OwnerSplitState

FROM project1.dbo.nashvilleHousing

ALTER TABLE nashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE nashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerSplitCity,',','.'),1)

--ALTER TABLE nashvilleHousing
--ADD OwnerSplitState Nvarchar(255);

--UPDATE nashvilleHousing
--SET OwnerSplitState = SUBSTRING(OwnerSplitCity,CHARINDEX(',',OwnerSplitCity) +1,LEN(OwnerSplitCity))

SELECT *
FROM project1.dbo.nashvilleHousing

SELECT PropertyAddress
FROM project1.dbo.nashvilleHousing

SELECT
PARSENAME(REPLACE(PropertyAddress,',','.'),2) AS Address,
PARSENAME(REPLACE(PropertyAddress,',','.'),1) AS city

FROM project1.dbo.nashvilleHousing

SELECT *
FROM project1.dbo.nashvilleHousing

ALTER TABLE nashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE nashvilleHousing
SET PropertySplitAddress = PARSENAME(REPLACE(PropertyAddress,',','.'),2)

ALTER TABLE nashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE nashvilleHousing
SET PropertySplitCity = PARSENAME(REPLACE(PropertyAddress,',','.'),1)

SELECT *
FROM project1.dbo.nashvilleHousing

--CHanging y to yes,n to  no

SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
FROM project1.dbo.nashvilleHousing
GROUP BY SoldAsVacant
ORDER BY SoldAsVacant DESC

SELECT SoldAsVacant,
CASE 
   WHEN SoldAsVacant = 'Y' THEN 'YES'
   WHEN SoldAsVacant = 'N' THEN 'No'
   ELSE SoldAsVacant
END
FROM project1.dbo.nashvilleHousing

UPDATE nashvilleHousing
SET SoldAsVacant = 
   CASE 
   WHEN SoldAsVacant = 'Y' THEN 'YES'
   WHEN SoldAsVacant = 'N' THEN 'No'
   ELSE SoldAsVacant
   END

SELECT *
FROM project1.dbo.nashvilleHousing

--remove duplicates

WITH RowNumCte AS(
SELECT *,
ROW_NUMBER() over (
PARTITION BY ParcelID,
             SalePrice,
			 LegalReference,
			 PropertyAddress,
			 SaleDate
			 ORDER BY 
			    UniqueID
				)row_number
FROM project1.dbo.nashvilleHousing
)
SELECT *
FROM RowNumCte
WHERE row_number >1
ORDER BY PropertyAddress

SELECT *
FROM project1.dbo.nashvilleHousing

-- removing unused columns

SELECT *
FROM project1.dbo.nashvilleHousing

ALTER TABLE project1.dbo.nashvilleHousing
DROP COLUMN TaxDistrict,OwnerAddress,PropertyAddress

ALTER TABLE project1.dbo.nashvilleHousing
DROP COLUMN SaleDate

--End