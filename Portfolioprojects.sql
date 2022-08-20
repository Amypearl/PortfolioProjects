SELECT *
 FROM practice.coviddeaths
 ORDER BY 3,4;
 
 -- SELECT *
 -- FROM practice.covidvaccinations_
 -- ORDER BY 3,4;
 
 -- Select Data that we are going to be using
 
 SELECT Location.date, total_cases, new_cases, total_deaths, population
 FROM practice.coviddeaths
 ORDER BY 1,2;
 
 -- Looking at Total Cases vs Total Deaths
 -- Shows the likelihood of dying when covid is contracted in USA
 
 SELECT Location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 FROM practice.coviddeaths
 -- WHERE location like '%states%'
 ORDER BY 1,2;
 
 -- Looking at Total cases vs Population
-- Shows the percentage of population that got Covid

 SELECT Location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected
 FROM practice.coviddeaths
 -- WHERE location like '%states%'
 GROUP BY Location, Population
 ORDER BY PercentagePopulationInfected Desc;
 
 -- Showing Countries with Highest Death Count per Population
 
SELECT Location, population, MAX(total_deaths) as TotalDeathCount
 FROM practice.coviddeaths
 -- WHERE location like '%states%'
 GROUP BY Location
 ORDER BY TotalDeathCount Desc;
 
 -- GLOBAL NUMBERS 
 
 SELECT Location,date,SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_cases)*100 as DeathPercentage
 FROM practice.coviddeaths
 -- WHERE location like '%states%'
-- GROUP BY Date
 ORDER BY 1,2;
 
 -- Looking at Total Population vs Vaccinations
 
 Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations, 
 SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location,dea.date) AS RollingPeopleVaccinated
 -- (RollingPeopleVacccinated/population)*100
 FROM practice.coviddeaths dea
 JOIN practice.covidvaccinations_ vac
 ON dea.location = vac.location
 AND dea.date = vac.date
 WHERE dea.continent IS NOT NULL
 ORDER BY 2,3;
 
 -- Create View to store data for later visualizations
 Create view PercentagePopulationVaccinated
 AS
 Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations, 
 SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location,dea.date) AS RollingPeopleVaccinated
 -- (RollingPeopleVacccinated/population)*100
 FROM practice.coviddeaths dea
 JOIN practice.covidvaccinations_ vac
 ON dea.location = vac.location
 AND dea.date = vac.date
 WHERE dea.continent IS NOT NULL
 -- ORDER BY 2,3;
 
 
 