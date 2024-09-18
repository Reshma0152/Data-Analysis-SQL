-- Exploratory Data Analysis

select * 
from layoffs_staging2;
-- who laided alot
Select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;

-- whihc company laid off total employees
select * 
from layoffs_staging2
where percentage_laid_off=1 
ORDER BY funds_raised_millions DESC;


-- finding total laid off based on company
select company, SUM(total_laid_off)
from layoffs_staging2
GROUP  BY 1
ORDER BY 2 DESC;


-- finding total laid off based on industry 
select industry, SUM(total_laid_off)
from layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

-- finding total laid off based on country
select company, SUM(total_laid_off)
from layoffs_staging2
GROUP  BY 1
ORDER BY 2 DESC;

-- finding total laid off based on date
select `date`, SUM(total_laid_off)
from layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;


select YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY 1
ORDER BY 1 DESC;

-- rolling total pay offs

select SUBSTRING(`date`,1,7) as `month`, SUM(total_laid_off)
from layoffs_staging2
where SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER by 1 ASC;

with rolling_total as
(
select SUBSTRING(`date`,1,7) as `month`, SUM(total_laid_off) as total_off
from layoffs_staging2
where SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER by 1 ASC
)
select `month`, total_off,
 SUM(total_off) OVER(ORDER BY `month`) AS rolling_total
from rolling_total;

select company, SUM(total_laid_off)
from layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;


with rolling_total1 as
(
select company, SUM(total_laid_off) as total_off
from layoffs_staging2
GROUP BY company
ORDER by 1 ASC
)
select company,total_off,
 SUM(total_off) OVER(order by company) AS rolling_total1
from rolling_total1;

select company,total_laid_off,sum(total_laid_off) OVER(order by company) AS rolling_total1
from layoffs_staging2;

select company,YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

with company_year(company,years, total_laid_off) as 
(
select company,YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_year_rank AS
(
select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) as ranking
from company_year where years IS NOT NULL)
select * 
from company_year_rank
where ranking<=5
;





select * 
from layoffs_staging2;

select * 
from layoffs_staging2;












