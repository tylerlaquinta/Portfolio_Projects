use PortfolioProject;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1, 2;


-- Looking at Total Cases Vs Total Deaths in United States

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 AS death_percentage
FROM CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1, 2;


-- Total Cases Vs Population
-- What percent of population got covid in United States

SELECT location, date, population, total_cases, ROUND(((total_cases/population)*100), 2) AS infection_rate
FROM CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1, 2;


-- Countries with highest infection rate

SELECT location, date, population, total_cases, ROUND(((total_cases/population)*100), 2) AS infection_rate
FROM CovidDeaths
WHERE date = (SELECT MAX(date) FROM CovidDeaths) AND continent IS NOT NULL
ORDER BY infection_rate DESC;


SELECT location, population, MAX(total_cases), (MAX((total_cases/population))*100) AS infection_rate
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infection_rate DESC;


-- Death Count

SELECT location, population, MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY total_death_count DESC;


-- Death Percentage

SELECT location, population, MAX(CAST(total_deaths AS INT)) AS total_death_count,
       (MAX((CAST(total_deaths AS INT)))/population)*100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY death_percentage DESC;


-- Death Count by Continent

SELECT location, MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC;



-- Global Numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;



-- Total Population Vs Vaccination Population

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CAST(vac.new_vaccinations AS INT)) OVER 
       (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

-- USE CTE

With PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CAST(vac.new_vaccinations AS INT)) OVER 
       (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (rolling_people_vaccinated/population)*100
FROM PopVsVac;


-- Temp Table -> Come back to

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent NVARCHAR(255),
location NVARCHAR(255),
date DATETIME,
population NUMERIC,
new_Vaccinations NUMERIC,
rolling_people_vaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL

SELECT *, (rolling_people_vaccinated/population)*100
FROM #PercentPopulationVaccinated;



--Creating View

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT * FROM
PercentPopulationVaccinated;
