--Creating tables that will be used in the Tableau Dashboard

--1. Total Cases, Total Deaths and Death percentage

SELECT 
    SUM(new_cases) AS TotalCases,
    SUM(CAST(new_deaths AS INT)) AS TotalDeaths,
    (SUM(CAST(new_deaths AS INT)) * 100) / SUM(new_cases) AS DeathPercentage
FROM SQLDataExploration..CovidDeaths
WHERE continent IS NOT NULL;

--2. Continent, Total Deaths per Continent

SELECT 
    location, 
    SUM(CAST(new_deaths AS INT)) AS TotalDeathCount
FROM SQLDataExploration..CovidDeaths
WHERE continent IS NULL
  AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC;

--3. Country, Population, Infection Count and Percent of Population Infected per Country

SELECT 
    location, 
    population, 
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases / population) * 100) AS PercentPopulationInfected
FROM SQLDataExploration..CovidDeaths
WHERE population IS NOT NULL AND total_cases IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

--4. Country, Population, Infection Count and Percent of Population Infected per Country and Date

SELECT 
    location, 
    population, 
	date,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases / population) * 100.0) AS PercentPopulationInfected
FROM SQLDataExploration..CovidDeaths
WHERE population IS NOT NULL AND total_cases IS NOT NULL
GROUP BY location, population, date
ORDER BY PercentPopulationInfected DESC;


