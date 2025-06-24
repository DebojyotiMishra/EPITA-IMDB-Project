# IMDb Data Cleaning & Preprocessing Summary

Before importing the TSV files into PostgreSQL using COPY commands in `import/import.sql`, all raw IMDb TSV files were preprocessed using shell tools (`cut`, `awk`, `grep`) to improve quality and avoid foreign key constraint violations. This ensured a clean database with consistent relationships between tables.

## Overview of Cleaning process

| File                  | Cleaning Performed                                 | Reason                                         |
|-----------------------|----------------------------------------------------|------------------------------------------------|
| `title.crew.tsv`      | Filter by valid tconst from `title.basics.tsv`     | To ensure no orphan rows on FK join            |
| `title.principals.tsv`| Same as above                                      | Avoids actor/crew linked to unknown titles     |
| `title.episode.tsv`   | Filter parentTconst by valid titles                | Ensure episode-series relations are valid      |
| `title.akas.tsv`      | Same: filter titleId by `title.basics.tsv`         | Prevents join failures in title UI pages       |
| `name.basics.tsv`     | Remove rows with NULL primaryName or broken nconst | Name needed for display & joins                |

## Detailed Per-File Cleaning Steps

### 1. `title.crew.tsv`

**Problem:**  
Some `tconst` values in `title.crew.tsv` don't exist in `title.basics.tsv`, which causes foreign key errors.

**Solution:**
```sh
cut -f1 title.basics.tsv > valid_titles.txt #Extracts the first column (tconst) from title.basics.tsv and saves it to a list of valid titles
awk 'NR==FNR {valid[$1]; next} ($1 in valid)' valid_titles.txt title.crew.tsv > title.crew.filtered.tsv #Goes through title.crew.tsv and keeps only the rows where the first column (the title ID) exists in valid_titles.txt
```

---

### 2. `title.principals.tsv`

**Problem:**  
Contains `tconst` and `nconst` values not present in `title.basics.tsv` or `name.basics.tsv`.

**Solution:**
```sh
# Extract all valid tconst and nconst values from the main tables.
cut -f1 title.basics.tsv > valid_titles.txt
cut -f1 name.basics.tsv > valid_names.txt

awk 'NR==FNR {valid[$1]; next} ($1 in valid)' valid_titles.txt title.principals.tsv > tmp1.tsv # Keeps only rows where the title ID is valid
awk 'NR==FNR {valid[$1]; next} ($3 in valid)' valid_names.txt tmp1.tsv > title.principals.filtered.tsv # From those rows, keeps only the ones where the person ID (column 3) is also valid.
```

---

### 3. `title.episode.tsv`

**Problem:**  
`parentTconst` in this file must exist in `title.basics.tsv`.

**Solution:**
```sh
# Keeps only rows where the second column (parent series ID) is in the list of valid titles
cut -f1 title.basics.tsv > valid_titles.txt
awk 'NR==FNR {valid[$1]; next} ($2 in valid)' valid_titles.txt title.episode.tsv > title.episode.filtered.tsv
```

---

### 4. `title.akas.tsv`

**Problem:**  
`titleId` (foreign key to `title_basics.tconst`) might reference non-existent titles.

**Solution:**
```sh
# Keeps only the rows where the first column (titleId) is a known valid title
cut -f1 title.basics.tsv > valid_titles.txt
awk 'NR==FNR {valid[$1]; next} ($1 in valid)' valid_titles.txt title.akas.tsv > title.akas.filtered.tsv
```

---

### 5. `name.basics.tsv`

**Problem:**  
Some rows have missing or null `primaryName`, which is critical for person display.

**Solution:**
```sh
# Keeps only rows that have a name in column 2 and that are not marked as \N (null). This avoids loading people without a name.
awk -F'\t' 'NF >= 2 && $2 != "\\N"' name.basics.tsv > name.basics.filtered.tsv
```

After having had cleaned up our data, we imported the data using the COPY commands in copy_commands.sql in imports/