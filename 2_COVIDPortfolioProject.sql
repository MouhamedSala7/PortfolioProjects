select*
from PortfolioProject..CovidVaccinations
order by date 


select*
from PortfolioProject..CovidVaccinations vac
join PortfolioProject..CovidDeaths des
  on vac.location = des.location 
  and vac.date = des.date
   

select des.continent , des.location , des.date , des.population , vac.new_vaccinations , 
 sum(cast (vac.new_vaccinations as BIGINT)) over 
              (partition by des.location order by des.location , des.date) as rollingpeoplevaccienated 
			--   (rollingpeoplevaccienated/des.population)*100
from PortfolioProject..CovidVaccinations vac
join PortfolioProject..CovidDeaths des
  on vac.location = des.location 
       and vac.date = des.date
 where des.continent is not null 
   order by 2,3 

   
 --- USE CTE --



 WITH PopvsVac (continent, location, date, population, new_vaccinations, rollingpeoplevaccinated) AS
(
    SELECT 
        des.continent, 
        des.location, 
        des.date, 
        des.population, 
        vac.new_vaccinations, 
        SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER 
            (PARTITION BY des.location ORDER BY des.date) AS rollingpeoplevaccinated
    FROM 
        PortfolioProject..CovidVaccinations vac
    JOIN 
        PortfolioProject..CovidDeaths des ON vac.location = des.location AND vac.date = des.date
    WHERE 
        des.continent IS NOT NULL 
)

SELECT 
    *,
    (rollingpeoplevaccinated / CAST(population AS FLOAT)) * 100 AS vaccination_rate_percentage
FROM 
    PopvsVac;


	-- Temp_Table

CREATE table #PercentPopulationVeccenated 
( continent nvarchar (255) ,
  location nvarchar (255) ,
  date datetime ,
  population numeric ,
  new_vaccinations numeric ,
  rollingpeoplevaccinated numeric 
  )
INSERT INTO #PercentPopulationVeccenated 


   SELECT 
        des.continent, 
        des.location, 
        des.date, 
        des.population, 
        vac.new_vaccinations, 
        SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER 
            (PARTITION BY des.location ORDER BY des.date) AS rollingpeoplevaccinated
    FROM 
        PortfolioProject..CovidVaccinations vac
    JOIN 
        PortfolioProject..CovidDeaths des ON vac.location = des.location AND vac.date = des.date
    WHERE 
        des.continent IS NOT NULL

SELECT 
    *,
    (rollingpeoplevaccinated / CAST(population AS FLOAT)) * 100 AS vaccination_rate_percentage
FROM 
    #PercentPopulationVeccenated;



	DROP TABLE #PercentPopulationVeccenated




	CREATE View PercentPopulationVeccenated AS
	 SELECT 
        des.continent, 
        des.location, 
        des.date, 
        des.population, 
        vac.new_vaccinations, 
        SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER 
            (PARTITION BY des.location ORDER BY des.date) AS rollingpeoplevaccinated
    FROM 
        PortfolioProject..CovidVaccinations vac
    JOIN 
        PortfolioProject..CovidDeaths des ON vac.location = des.location AND vac.date = des.date
    WHERE 
        des.continent IS NOT NULL



select*
from PercentPopulationVeccenated
