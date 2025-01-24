Select* 
from ProtofiloProject.dbo.Nashvillehousing


Select SaleDateConverted,Convert(Date,SaleDate)
from ProtofiloProject.dbo.Nashvillehousing

update Nashvillehousing
SET SaleDate = Convert(Date,SaleDate)

ALTER TABLE Nashvillehousing
Add SaleDateConverted Date;

update Nashvillehousing
SET SaleDateConverted = Convert(Date,SaleDate)

Select *
from ProtofiloProject.dbo.Nashvillehousing
--where PropertyAddress is not null
order by ParcelID

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from ProtofiloProject.dbo.Nashvillehousing a
join ProtofiloProject.dbo.Nashvillehousing b
  on a.ParcelID =b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null

  update a
  set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
  from ProtofiloProject.dbo.Nashvillehousing a
join ProtofiloProject.dbo.Nashvillehousing b
  on a.ParcelID =b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null

  Select PropertyAddress
from ProtofiloProject.dbo.Nashvillehousing
--where PropertyAddress is not null
--order by ParcelID

select 
substring (propertyAddress, 0, CHARINDEX(',',PropertyAddress)) as Address
,substring (propertyAddress, CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address
from ProtofiloProject.dbo.Nashvillehousing


ALTER TABLE Nashvillehousing
Add PropertySplitAddress NVARCHAR (255);

update Nashvillehousing
SET PropertySplitAddress = substring (propertyAddress, 0, CHARINDEX(',',PropertyAddress)) 

ALTER TABLE Nashvillehousing
Add PropertySplitCity NVARCHAR (255);

update Nashvillehousing
SET PropertySplitCity = substring (propertyAddress, CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))


Select OwnerAddress
from ProtofiloProject.dbo.Nashvillehousing

Select
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from ProtofiloProject.dbo.Nashvillehousing

ALTER TABLE Nashvillehousing
Add OwnerSplitAddress NVARCHAR (255);

update Nashvillehousing
SET OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3)

Alter Table Nashvillehousing
Add OwnerSplitCity NVARCHAR (255);

update Nashvillehousing
SET OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2)


ALTER TABLE Nashvillehousing
Add OwnerSplitState NVARCHAR (255);

update Nashvillehousing
SET OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)

Select *
from ProtofiloProject.dbo.Nashvillehousing

Select  Distinct(SoldAsVacant),count(SoldAsVacant)
from ProtofiloProject.dbo.Nashvillehousing
group by SoldAsVacant
Order by 2

select SoldAsVacant
,case when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant ='N' then 'No'
	  else SoldAsVacant 
	  end
from ProtofiloProject.dbo.Nashvillehousing

update Nashvillehousing
set SoldAsVacant =case when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant ='N' then 'No'
	  else SoldAsVacant 
	  end

with RowNumCTE AS (
select *,
ROW_NUMBER() over(
partition by ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					order by 
					 UniqueID)
					 row_num
from ProtofiloProject.dbo.Nashvillehousing
--order by ParcelID
)

select *
from RowNumCTE
Where row_num >1
Order by PropertyAddress

select *
from ProtofiloProject.dbo.Nashvillehousing

select *
from ProtofiloProject.dbo.Nashvillehousing

alter table ProtofiloProject.dbo.Nashvillehousing
drop column OwnerAddress,TaxDistrict,PropertyAddress,SaleDate


