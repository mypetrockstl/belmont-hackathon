USE DATABASE BELMONT_HACKATHON;
USE SCHEMA PUBLIC;

CREATE TABLE MUSIC_GENRE
(
Artist_Name TEXT
,Track_Name TEXT
,Popularity DECIMAL
,danceability DECIMAL
,energy DECIMAL
,key DECIMAL
,loudness DECIMAL
,mode DECIMAL
,speechiness DECIMAL
,acousticness DECIMAL
,instrumentalness DECIMAL
,liveness DECIMAL
,valence DECIMAL
,tempo DECIMAL
,duration_in_ms DECIMAL
,time_signature NUMBER
,Class NUMBER

);

CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('\\N', 'null', '')  -- Common options for handling nulls
EMPTY_FIELD_AS_NULL = TRUE
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_GENRE
FROM @MUSIC_GENRE/test.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_GENRE
FROM @MUSIC_GENRE/train.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;
