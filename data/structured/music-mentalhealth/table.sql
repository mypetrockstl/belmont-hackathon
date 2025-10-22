USE DATABASE BELMONT_HACKATHON;
USE SCHEMA PUBLIC;

CREATE OR REPLACE TABLE MUSIC_MENTAL_HEALTH (

SURVEYED_DTM  TEXT
,Age NUMBER
,Primary_streaming_service TEXT
,Hours_per_day DECIMAL
,While_working TEXT
,Instrumentalist TEXT
,Composer TEXT
,Fav_genre TEXT
,Exploratory TEXT
,Foreign_languages TEXT
,BPM NUMBER
,Frequency_Classical TEXT
,Frequency_Country TEXT
,Frequency_EDM TEXT
,Frequency_Folk TEXT
,Frequency_Gospel TEXT
,Frequency_Hip_hop TEXT
,Frequency_Jazz TEXT
,Frequency_Kpop TEXT
,Frequency_Latin TEXT
,Frequency_Lofi TEXT
,Frequency_Metal TEXT
,Frequency_Pop TEXT
,Frequency_RNB TEXT
,Frequency_Rap TEXT
,Frequency_Rock TEXT
,Frequency_Video_game_music TEXT
,Anxiety NUMBER
,Depression NUMBER 
,Insomnia NUMBER
,OCD NUMBER
,Music_effects TEXT
,Permissions TEXT

);

CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('\\N', 'null', '')  -- Common options for handling nulls
EMPTY_FIELD_AS_NULL = TRUE
;

-- Load data from the specific file in the stage
COPY INTO MUSIC_MENTAL_HEALTH
FROM @MUSIC_MENTAL_HEALTH/mxmh_survey_results.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail
;
