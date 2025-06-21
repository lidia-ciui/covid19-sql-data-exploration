--1. Exploring both tables to understand the data

SELECT *
FROM SQLDataExploration..CovidDeaths
ORDER BY 3, 4;

SELECT *
FROM SQLDataExploration..CovidVaccinations
ORDER BY 3, 4;

--2. Selecting the data that will be used for analysis

SELECT continent, 
	   location, 
	   date, 
	   total_cases, 
	   new_cases, 
	   total_deaths, 
	   population
FROM SQLDataExploration..CovidDeaths
ORDER BY 1, 2;


--3. Total Cases vs Total Deaths per Country
--Shows the likelihood of death if contracting the virus in Romania

SELECT location, date, total_cases, total_deaths,
       CASE 
           WHEN total_cases = 0 THEN NULL
           ELSE (total_deaths / total_cases) * 100
       END AS DeathPercentage
FROM SQLDataExploration..CovidDeaths
WHERE location LIKE '%Romania%'
ORDER BY 1, 2;


--4. Total Cases vs Population
--Shows what percentage of the population was infected with the virus in Romania

SELECT location, date, population, total_cases,
       CASE 
           WHEN total_cases = 0 THEN NULL
           ELSE (total_cases / population) * 100
       END AS infected_percentage
FROM SQLDataExploration..CovidDeaths
WHERE location LIKE '%Romania%'
ORDER BY 1, 2;


--5. Countries with highest infection rate compared to the population

SELECT location, 
       population, 
       MAX(total_cases) AS HighestInfectionCount, 
       MAX((total_cases / population)) * 100 AS InfectedPercentage
FROM SQLDataExploration..CovidDeaths
GROUP BY location, population
ORDER BY InfectedPercentage DESC;


--6. Countries with highest death count 

SELECT location, 
       MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM SQLDataExploration..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


--7. Continents with highest death count 

SELECT continent, 
       MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM SQLDataExploration..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;


--8. Total Cases, Total Deaths and Death Percentage globally on a daily basis


SELECT date, 
	   SUM(new_cases) AS total_cases, 
	   SUM(cast(new_deaths as int)) AS total_deaths, 
	   SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM SQLDataExploration..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1


--9. Total Cases, Total Deaths and Death Percentage globally


SELECT SUM(new_cases) as total_cases, 
	   SUM(cast(new_deaths as int)) AS total_deaths, 
	   SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM SQLDataExploration..CovidDeaths
WHERE continent is not null


--10. Total Population vs Number of Vaccinated People and Vaccinated Percentage using CTE


WITH PopulationvsVaccinated AS (
    SELECT dea.continent, 
		   dea.location, 
           dea.date, 
           dea.population, 
           vac.new_vaccinations, 
           SUM(COALESCE(CONVERT(int, vac.new_vaccinations), 0)) 
              OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
    FROM SQLDataExploration..CovidDeaths dea
    JOIN 
        SQLDataExploration..CovidVaccinations vac
        ON dea.location = vac.location 
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, 
    CASE 
        WHEN Population = 0 THEN 0
        ELSE (RollingPeopleVaccinated / Population) * 100 
    END AS VaccinatedPercentage
FROM PopulationvsVaccinated;


--11. Total Population vs Number of Vaccinated People and Vaccinated Percentage using TEMP TABLE


-- Drop the table if it exists

IF OBJECT_ID('tempdb..#VaccinatedPercentageTable') IS NOT NULL
    DROP TABLE #VaccinatedPercentageTable;

-- Create the table structure

CREATE TABLE #VaccinatedPercentageTable
(
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_Vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

-- Insert the data into the temporary table

INSERT INTO #VaccinatedPercentageTable
SELECT dea.continent, 
       dea.location, 
       dea.date, 
       dea.population, 
       vac.new_vaccinations,
       SUM(COALESCE(CONVERT(INT, vac.new_vaccinations), 0)) 
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM SQLDataExploration..CovidDeaths dea
JOIN 
    SQLDataExploration..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

-- Select data from the temporary table and calculate VaccinatedPercentage
SELECT *, 
       CASE 
           WHEN Population = 0 THEN 0  
           ELSE (RollingPeopleVaccinated / Population) * 100 
       END AS VaccinatedPercentage
FROM #VaccinatedPercentageTable;


--12. Creating a View about the Vaccinated Population that can be used for Visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, 
       dea.location, 
       dea.date, 
       dea.population, 
       vac.new_vaccinations,
       SUM(COALESCE(CONVERT(int, vac.new_vaccinations), 0)) 
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM SQLDataExploration..CovidDeaths dea
JOIN 
    SQLDataExploration..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT * 
FROM PercentPopulationVaccinated;