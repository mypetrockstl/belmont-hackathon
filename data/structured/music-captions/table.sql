CREATE OR REPLACE TABLE MUSIC_CAPTIONS (
ytid TEXT
,start_s NUMBER
,end_s NUMBER
,aspect_list ARRAY
,caption text
,author_id number
,is_balanced_subset boolean
,is_audioset_eval boolean
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
COPY INTO MUSIC_CAPTIONS(ytid,start_s,end_s,aspect_list,caption,author_id,is_balanced_subset,is_audioset_eval)
FROM 
(
    SELECT
        $1::TEXT,                 -- Column 1: ID, explicitly cast to INT
        $2::NUMBER,             -- Column 2: Name, explicitly cast to VARCHAR
        $3::NUMBER,             -- Column 2: Name, explicitly cast to VARCHAR 
        PARSE_JSON($5)::ARRAY,    -- Column 3: Tags, parse the string as JSON then cast to ARRAY
        $6::TEXT,             -- Column 2: Name, explicitly cast to VARCHAR 
        $7::NUMBER,             -- Column 2: Name, explicitly cast to VARCHAR 
        $8::BOOLEAN,             -- Column 2: Name, explicitly cast to VARCHAR 
        $9::BOOLEAN             -- Column 2: Name, explicitly cast to VARCHAR 
        
    FROM @MUSIC_CAPTIONS/musiccaps-public.csv
)

FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE'  -- Option to continue loading even if a few records fail

;
