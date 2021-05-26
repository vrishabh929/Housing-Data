-- Exploratory Data Analysis

select distinct(landuse)
from housing

select 
	landuse,count(landuse) as count_of_landuse
from 
	housing
group by
	landuse
order by
	count_of_landuse desc

select 
	landuse,round(avg(SalePrice),2) as saleprice
from 
	housing
group by
	landuse
order by
	saleprice desc



select 
	soldasvacant,count(soldasvacant) as count_of_vacant
from 
	housing
--where soldasvacant = 'No'
group by
	--landuse,
	soldasvacant
order by
	count(soldasvacant) 



select landuse,
	   round(avg(acreage),2) as avg_acreage,
	   round(avg(landvalue),2) as avg_landvalue,
	   round(avg(buildingvalue),2) as avg_buildingvalue
from 
	housing
where
	 not landuse='RESIDENTIAL CONDO' and
	 not landuse='CONDOMINIUM OFC  OR OTHER COM CONDO' and
	 not landuse='CONDO' and
	 not landuse='SMALL SERVICE SHOP' and
	 not landuse='RESTURANT/CAFETERIA' and 
	 not landuse='NIGHTCLUB/LOUNGE' and
	 buildingvalue>0
group by
	landuse
order by
	avg_buildingvalue

select * 
from 
	housing
where
	landuse = 'NIGHTCLUB/LOUNGE'

select top(500)
	landuse,
	count(landuse) as num_of_lands,
	yearbuilt,
	year(cast(saledateconverted as date)) as saleyear,
	propertyaddresscity
from 
	housing
where
	yearbuilt is not null --and 
	--landuse ='CHURCH'
group by
	landuse,
	yearbuilt,
	year(cast(saledateconverted as date)),
	propertyaddresscity
order by
	2 desc,
	yearbuilt,
	year(cast(saledateconverted as date))


--select landuse,
--	   propertyaddresscity,
--	   owneraddresscity
--from
--	housing
--where 
--	yearbuilt is not null
--group by
--	landuse,
--	propertyaddresscity,
--	owneraddresscity

select *
from 
	housing
where 
	yearbuilt = 2015



select
	landuse,
	cast(avg(bedrooms) as int) as bed_rooms,
	cast(avg(FullBath) as int) as fullbath
	--cast(avg(HalfBath) as int) as bed_rooms
from 
	housing
where
	yearbuilt is not null
group by 
	landuse
order by
	2 desc,
	3 desc