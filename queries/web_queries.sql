-- ######################## PAGES ########################
-- ====================== Home Page ======================
SELECT
	tb.tconst,
	tb.primarytitle,
	tb.startyear,
	tb.runtimeminutes,
	tb.genres,
	tr.averagerating,
	tr.numvotes
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.titletype = 'movie'
ORDER BY tr.numvotes DESC
LIMIT 10;

-- ====================== Movie Listing Page ======================
SELECT
  tconst,
  title,
  year,
  length,
  genres,
  averageRating,
  numVotes
FROM movie_summary
WHERE
  (genres ILIKE '%Action%' OR genres IS NULL) AND
  (year = 2010 OR year IS NULL) AND
  (averageRating >= 7.0 OR averageRating IS NULL)
ORDER BY
  averageRating DESC NULLS LAST,
  year DESC NULLS LAST,
  genres DESC NULLS LAST,
  numVotes DESC NULLS LAST
LIMIT 50 OFFSET 0;

-- ====================== Series Listing Page ======================
SELECT
  tconst,
  title,
  startYear,
  endYear,
  genres,
  averageRating,
  numVotes,
  totalSeasons
FROM series_summary
WHERE
  genres ILIKE '%Drama%' AND
  startYear BETWEEN 2010 AND 2020 AND
  averageRating >= 7.5
ORDER BY averageRating DESC
LIMIT 50;

-- ====================== Movie Summary Page ======================
SELECT *
FROM movie_summary
WHERE tconst = 'tt3063586';

-- ====================== Series Summary Page ======================
SELECT *
FROM series_summary
WHERE tconst = 'tt0989125';


-- ######################## SPECIAL FEATURES ########################
-- ====================== Filtering for Adult Content ======================
SELECT tconst, primarytitle, startyear, genres
FROM title_basics
WHERE isadult = false; -- or true, depending on what you want ;)

-- ====================== Search Engine ======================
SELECT
  tconst,
  title,
  year,
  genres,
  averageRating,
  numVotes
FROM movie_summary
WHERE title ILIKE '%batman%'
ORDER BY averageRating DESC, numVotes DESC
LIMIT 20;

-- ====================== User Favorites ======================
-- Making another table to allow users to make a list of their favorite movies or tv shows
CREATE TABLE user_favorites (
user_id UUID NOT NULL,
tconst TEXT NOT NULL REFERENCES title_basics(tconst),
added_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP, -- TIMESTAMPZ for storing time WITH time zone
PRIMARY KEY (user_id, tconst)
);

