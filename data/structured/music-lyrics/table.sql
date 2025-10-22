USE DATABASE BELMONT_HACKATHON;
USE SCHEMA PUBLIC;

CREATE TABLE MUSIC_LYRICS (
LYRIC_ID NUMBER
,artist_name TEXT
,track_name TEXT
,release_date NUMBER
,genre TEXT
,lyrics TEXT 
,len NUMBER
,dating DECIMAL
,violence DECIMAL
,world_life DECIMAL
,night_time DECIMAL
,shake_the_audience DECIMAL
,family_gospel DECIMAL
,romantic DECIMAL
,communication DECIMAL
,obscene DECIMAL
,music DECIMAL
,movement_places DECIMAL
,light_visual_perceptions  DECIMAL
,family_spiritual DECIMAL
,like_girls DECIMAL
,sadness DECIMAL
,feelings DECIMAL
,danceability DECIMAL
,loudness DECIMAL
,acousticness DECIMAL
,instrumentalness DECIMAL
,valence DECIMAL
,energy DECIMAL
,topic TEXT
,age DECIMAL
); 

CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('\\N', 'null', '')  -- Common options for handling nulls
EMPTY_FIELD_AS_NULL = TRUE
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_LYRICS
FROM @MUSIC_LYRICS/tcc_ceds_music.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;
