# Query Explanations

## Home Page Query

### Purpose:

Display the top 10 most popular movies based on the number of votes.

### Explanation:

We joined `title_basics` and `title_ratings` using `tconst` to get movie details and ratings. Filtered for movies (`titletype = 'movie'`), sorted by `numvotes` in descending order, and limited the result to 10. This shows the most popular movies.

---

## Movie Listing Page Query

### Purpose:

List movies with optional filters for genre, year, and rating, and return results in a meaningful order

### Explanation:

This query selects movies from the `movie_summary` table, applying optional filters for `genres`, `year`, and `averageRating`. Each filter condition includes an `OR IS NULL` clause, which allows the same query to support both filtered and unfiltered use cases.

For a better user experience, the results are sorted using `ORDER BY` with `NULLS LAST`, prioritizing entries that have complete data first. Sorting is done by `averageRating`, `year`, `genres`, and `numVotes` — all with nulls placed at the end. This ensures that movies with actual ratings and metadata are shown first, and less complete entries only appear if needed. We used `LIMIT 50 OFFSET 0` for pagination.

---

## Series Listing Page Query

### Purpose:

List TV series with filters for genre, year range, and rating.

### Explanation:

We selected from `series_summary`, filtered for series with 'Drama' in the genre, a start year between 2010 and 2020, and a minimum average rating of 7.5. Results are ordered by rating and limited to 50 for pagination.

---

## Movie Summary Page Query

### Purpose:

Show detailed information for a specific movie.

### Explanation:

This query selects all columns from `movie_summary` for a given `tconst`. It provides a full summary for the selected movie.

---

## Series Summary Page Query

### Purpose:

Show detailed information for a specific TV series.

### Explanation:

Similar to the movie summary, this selects all columns from `series_summary` for a given `tconst`, giving a complete overview of the series.

---

## Adult Content Filter Query

### Purpose:

Exclude (or include) adult content from listings.

### Explanation:

A simple filter on `isadult = false` (or `true` if needed) in `title_basics` to control whether adult titles are shown.

---

## Search Engine Query

### Purpose:

Search for movies by title keyword.

### Explanation:

We used `ILIKE` for case-insensitive, partial matching on the `title` column in `movie_summary`. Results are ordered by rating and number of votes, and limited to 20.

---

## User Favorites Table (Schema Creation)

### Purpose:

Allow users to save their favorite movies or TV shows.

### Explanation:

We created a `user_favorites` table with a composite primary key of `user_id` and `tconst`. The `tconst` references `title_basics`, and `added_at` records when the favorite was added.

---

## Top Director-Actor Pairs Query

### Purpose:

Find director-actor pairs who have collaborated on at least three movies, ranked by average rating.

### Explanation:

We joined `title_basics`, `title_crew`, `title_principals`, `title_ratings`, and `name_basics` to link directors and actors. Filtered for actors/actresses, grouped by director and actor names, and used `HAVING` to require at least three collaborations. Results are ordered by average rating and limited to the top 10 pairs.

---

## Average IMDb Rating per Genre Query

### Purpose:

Find the highest-rated genres with enough titles.

### Explanation:

We split the `genres` column using `string_to_array` and `UNNEST` to handle multiple genres per title. Grouped by genre, calculated average rating, and filtered for genres with more than 50 titles. Results are ordered by rating and limited to the top 10 genres.

---

## Average Rating per Genre per Decade Query

### Purpose:

Track how genre ratings change over time by decade.

### Explanation:

We calculated the decade using `FLOOR(startYear / 10) * 10`, split genres as before, and joined ratings. Grouped by decade and genre, filtered for titles with more than 100 votes, and ordered by decade and title count.

---

## Rating by Runtime Category Query

### Purpose:

Analyze how movie length relates to average ratings.

### Explanation:

We used a `CASE` statement to bucket movies into runtime categories (Short, Medium, Feature, Long, Unknown). Grouped by category, counted titles, and calculated average rating for each group. Results are ordered by the number of titles.
