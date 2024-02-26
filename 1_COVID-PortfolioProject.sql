SELECT count(iso_code)
  FROM [PortfolioProject].[dbo].[CovidDeaths]

  SELECT count(iso_code)
  FROM [PortfolioProject]..CovidVaccinations


  SELECT *
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  order by date

  SELECT *
  FROM PortfolioProject..CovidVaccinations
  order by date


  SELECT *
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  order by 3 , 4






  SELECT *
  FROM PortfolioProject..CovidVaccinations
  order by 3 ,4 


select *
from PortfolioProject..CovidVaccinations




--Select data that we use

 SELECT location , date , total_cases , new_cases ,
                               total_deaths , population
 from PortfolioProject..CovidDeaths
 order by 4 ,3


 --locking at total_case , total_deaths

 
 SELECT location , date , total_cases ,total_deaths, population
 from PortfolioProject..CovidDeaths
 where location like '%china%'
 order by total_cases,total_deaths ;

SELECT 
    location, 
    date, 
	total_cases, 
    total_deaths,
    CASE 
        WHEN TRY_CONVERT(float, total_cases) <> 0 THEN total_deaths / TRY_CONVERT(float, total_cases)*100
        ELSE 0 -- or any default value you prefer when total_cases is zero
    END AS deaths_persentige, 
    population
FROM 
    PortfolioProject..CovidDeaths
WHERE 
    location LIKE '%china%'
ORDER BY 
    total_cases, 
    total_deaths;



 select location , count(location) 
 FROM PortfolioProject..CovidDeaths
 Group by location ; 

 
 SELECT MAX(total_cases) As all_cases , MAX(total_deaths) AS all_deaths
 FROM PortfolioProject..CovidDeaths ;


 --what persentage of population in covied 
 
 SELECT 
    location, 
    date, 
	total_cases, 
    population, (total_cases/population)*100
    
FROM
    PortfolioProject..CovidDeaths
WHERE 
    location LIKE '%china%'
	ORDER BY 1 ,2 ;

	   
	   -- Cast علشااااان تحول  ل (int) =======>>>  مهممم
	   
SELECT location , max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..CovidDeaths
group by location
order by totaldeathcount desc


SELECT location , max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by totaldeathcount desc


SELECT continent , max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..CovidDeaths
where continent is not null
group by  continent
order by totaldeathcount desc


SELECT continent , max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..CovidDeaths
where continent is null
group by  continent
order by totaldeathcount desc

SELECT total_cases , total
from PortfolioProject..CovidDeaths
where continent is null
group by  continent
order by totaldeathcount desc