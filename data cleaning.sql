--Data Cleaning

select *
from housing

--Date format


select saledate, 
	   convert(date,saledate)
from housing

alter table housing
add saledateconverted Date;

update housing
set saledateconverted = convert(date,saledate)

--PropertyAddress

select *
from housing


--where propertyaddress 


order by 
	ParcelID

select 
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	ISNULL(a.propertyAddress, b.PropertyAddress)
from housing a
join housing b
on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyaddress = ISNULL(a.propertyaddress, b.propertyaddress)
from housing a
join housing b
on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

select *
from housing
where 
	propertyaddress is null

--Address to city, state

select 
	propertyaddress
from 
	housing
order by 
	ParcelID

select
	SUBSTRING(propertyaddress,1, CHARINDEX(',',propertyaddress)-1) as address,
	SUBSTRING(propertyaddress, CHARINDEX(',',propertyaddress)+1,len(propertyaddress)) as address
from 
	housing
order by 
	parcelid

alter table housing
add propertyaddresssplit nvarchar(255)

update housing
set propertyaddresssplit = SUBSTRING(propertyaddress,1,charindex(',',propertyaddress)-1)

alter table housing
add propertyaddresscity nvarchar(255)

update housing
set propertyaddresscity = SUBSTRING(propertyaddress, CHARINDEX(',',propertyaddress)+1,len(propertyaddress))





select 
	count(*)
from housing
where
	owneraddress is null

select 
	parsename(replace(owneraddress,',','.'),3),
	parsename(replace(owneraddress,',','.'),2),
	parsename(replace(owneraddress,',','.'),1)
from 
	housing


alter table housing
add owneraddresssplit nvarchar(255)

update housing
set owneraddresssplit = parsename(replace(owneraddress,',','.'),3)

alter table housing
add owneraddresscity nvarchar(255)

update housing
set owneraddresscity = parsename(replace(owneraddress,',','.'),2)

alter table housing
add owneraddressstate nvarchar(255)

update housing
set owneraddressstate = parsename(replace(owneraddress,',','.'),1)

--sold as vacant

select 
	distinct(soldasvacant),
	count(soldasvacant)
from 
	housing
group by
	soldasvacant
order by
	count(soldasvacant)

select soldasvacant,
	case when soldasvacant='Y' then 'Yes'
		 when soldasvacant='N' then 'No'
		 else soldasvacant
	end
from housing

update housing
set soldasvacant = case when soldasvacant='Y' then 'Yes'
		 when soldasvacant='N' then 'No'
		 else soldasvacant
	end



--Remove Duplicates

with rownumcte as(
select *,
	   row_number() over(
	   partition by
	   parcelid,
	   propertyaddress,
	   saleprice,
	   saledate,
	   legalreference
	   order by
	   uniqueid) row_num
from housing)
delete
from rownumcte
where row_num>1



with rownumcte as(
select *,
	   row_number() over(
	   partition by
	   parcelid,
	   propertyaddress,
	   saleprice,
	   saledate,
	   legalreference
	   order by
	   uniqueid) row_num
from housing)
select *
from rownumcte
where row_num>1

--unused columns

alter table housing
drop column propertyaddress

alter table housing
drop column owneraddress,taxdistrict,saledate

