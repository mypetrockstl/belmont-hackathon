USE DATABASE BELMONT_HACKATHON;
USE SCHEMA PUBLIC;

CREATE OR REPLACE TABLE MUSIC_POPULARITY (

energy DECIMAL
,tempo DECIMAL
,danceability DECIMAL
,playlist_genre TEXT
,loudness  DECIMAL
,liveness DECIMAL
,valence DECIMAL
,track_artist TEXT
,time_signature NUMBER
,speechiness  DECIMAL
,track_popularity NUMBER
,track_href TEXT
,uri TEXT
,track_album_name TEXT
,playlist_name TEXT
,analysis_url TEXT
,track_id TEXT
,track_name TEXT
,track_album_release_date DATE
,instrumentalness  DECIMAL
,track_album_id TEXT
,mode DECIMAL
,key DECIMAL
,duration_ms  DECIMAL
,acousticness  DECIMAL
,id TEXT
,playlist_subgenre TEXT
,type TEXT
,playlist_id TEXT

);

CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
NULL_IF = ('\\N', 'null', '')  -- Common options for handling nulls
EMPTY_FIELD_AS_NULL = TRUE
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_POPULARITY
FROM @MUSIC_POPULARITY/high_popularity_spotify_data.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_POPULARITY (time_signature,track_popularity,speechiness,danceability,playlist_name,track_artist,duration_ms,energy,playlist_genre,playlist_subgenre,track_href,track_name,mode,uri,type,track_album_release_date,analysis_url,id,instrumentalness,track_album_id,playlist_id,track_id,valence,key,tempo,loudness,acousticness,liveness,track_album_name)
FROM @MUSIC_POPULARITY/low_popularity_spotify_data.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;
