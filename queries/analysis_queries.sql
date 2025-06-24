-- ######################## ANALYSIS QUERIES ########################
-- ====================== Top Director-Actor Pairs ======================
-- Finds director-actor pairs who collaborated at least thrice and ranks them by average rating.
SELECT
  d.primaryName AS director_name,
  a.primaryName AS actor_name,
  COUNT(*) AS movie_count,
  ROUND(AVG(r.averageRating), 2) AS avg_rating
FROM title_basics b
JOIN title_crew c ON b.tconst = c.tconst
JOIN title_principals p ON b.tconst = p.tconst
JOIN title_ratings r ON b.tconst = r.tconst
JOIN name_basics d ON c.directors = d.nconst
JOIN name_basics a ON p.nconst = a.nconst
WHERE p.category IN ('actor', 'actress')
  AND c.directors IS NOT NULL
GROUP BY d.primaryName, a.primaryName
HAVING COUNT(*) >= 3 -- at least 3 collaborations
ORDER BY avg_rating DESC
LIMIT 10;

-- ====================== Average IMDB Rating per Genre for the top 10 genres ======================
-- Shows the highest-rated genres with a minimum of 50 titles
SELECT
  genre,
  ROUND(AVG(r.averageRating), 2) AS avg_rating,
  COUNT(*) AS total_titles
FROM (
  SELECT
    b.tconst,
    UNNEST(string_to_array(b.genres, ',')) AS genre
  FROM title_basics b
  JOIN title_ratings r ON b.tconst = r.tconst
  WHERE b.genres IS NOT NULL
) AS sub
JOIN title_ratings r ON sub.tconst = r.tconst
GROUP BY genre
HAVING COUNT(*) > 50
ORDER BY avg_rating DESC
LIMIT 10;

-- ====================== Average Rating Per Genre Per Decade ======================
-- why did i do this? i heard letterboxd had this feature, so i wanted to see if i could do it too
SELECT
  FLOOR(tb.startYear / 10) * 10 AS decade,
  genre,
  COUNT(*) AS title_count,
  ROUND(AVG(tr.averageRating), 2) AS avg_rating
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
JOIN UNNEST(STRING_TO_ARRAY(tb.genres, ',')) AS genre ON TRUE
WHERE tb.startYear BETWEEN 1900 AND 2025
  AND tr.numVotes > 100
GROUP BY decade, genre
ORDER BY decade, title_count DESC;

-- ====================== Rating by Runtime Category ======================
-- explores how runtime affects average ratings across all titles
SELECT
  CASE
    WHEN tb.runtimeMinutes < 60 THEN 'Short (<60min)'
    WHEN tb.runtimeMinutes BETWEEN 60 AND 89 THEN 'Medium (60–89min)'
    WHEN tb.runtimeMinutes BETWEEN 90 AND 119 THEN 'Feature (90–119min)'
    WHEN tb.runtimeMinutes >= 120 THEN 'Long (120+min)'
    ELSE 'Unknown'
  END AS runtime_category,
  COUNT(*) AS total_titles,
  ROUND(AVG(tr.averageRating), 2) AS avg_rating
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.runtimeMinutes IS NOT NULL
GROUP BY runtime_category
ORDER BY total_titles DESC;