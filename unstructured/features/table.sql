USE DATABASE BELMONT_HACKATHON;
USE SCHEMA PUBLIC;


    CREATE OR REPLACE TABLE FEATURE_DOCUMENTS AS
SELECT
    RELATIVE_PATH,
    TO_VARCHAR (
        SNOWFLAKE.CORTEX.PARSE_DOCUMENT (
            '@FEATURES',
            RELATIVE_PATH,
            {'mode': 'LAYOUT'} ):content
        ) AS EXTRACTED_LAYOUT
FROM
    DIRECTORY('@FEATURES')
WHERE
    RELATIVE_PATH LIKE '%.pdf';

            CREATE OR REPLACE TABLE FEATURE_CHUNKS AS
SELECT
    relative_path,
    BUILD_SCOPED_FILE_URL(@FEATURES, relative_path) AS file_url,
    (
        relative_path || ':\n'
        || coalesce('Header 1: ' || c.value['headers']['header_1'] || '\n', '')
        || coalesce('Header 2: ' || c.value['headers']['header_2'] || '\n', '')
        || c.value['chunk']
    ) AS chunk,
    'English' AS language
FROM
    FEATURE_DOCUMENTS,
    LATERAL FLATTEN(SNOWFLAKE.CORTEX.SPLIT_TEXT_MARKDOWN_HEADER(
        EXTRACTED_LAYOUT,
        OBJECT_CONSTRUCT('#', 'header_1', '##', 'header_2'),
        2000, -- chunks of 2000 characters
        300 -- 300 character overlap
    )) c;
