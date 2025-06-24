-- Import cleaned title.basics
COPY title_basics FROM '/import/title.basics.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import cleaned name.basics
COPY name_basics FROM '/import/name.basics.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import cleaned title.akas
COPY title_akas FROM '/import/title.akas.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import cleaned title.crew
COPY title_crew FROM '/import/title.crew.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import cleaned title.principals
COPY title_principals FROM '/import/title.principals.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import cleaned title.episode
COPY title_episode FROM '/import/title.episode.filtered.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');

-- Import title.ratings (if no cleaning was required)
COPY title_ratings FROM '/import/title.ratings.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER, NULL '\N', QUOTE E'\001');
