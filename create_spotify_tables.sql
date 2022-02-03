-- Creating tables for Spotify
CREATE TABLE artists (
     id VARCHAR(22) NOT NULL,
     followers INT,
	 genres VARCHAR(317),
	 name VARCHAR(194) NOT NULL,
	 popularity INT,
     PRIMARY KEY (id)
);


-- Creating tables for Spotify
CREATE TABLE tracks (
	 id VARCHAR(22),
	 name VARCHAR(529),
	 popularity INT,
	 duration_ms INT,
	 explicit INT,
	 artists VARCHAR(100), 
	 id_artists VARCHAR(22),
	 release_date VARCHAR(4),
	 danceability REAL,
	 energy REAL,
	 key INT,
	 loudness REAL,
	 mode INT,
	 speechiness REAL,
	 acousticness REAL,
	 instrumentalness REAL,
	 liveness REAL,
	 valence REAL,
	 tempo REAL,
	 time_signature INT,
	 decades VARCHAR(6)
     PRIMARY KEY (id)
);

-- removed additional tables
-- changed varchar release_date to 4
-- added decades column