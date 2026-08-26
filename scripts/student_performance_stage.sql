-- =====================================================
-- 1) STAGING TABLE
-- Purpose:
-- Loads the transformed CSV from GCS into a native BigQuery table.
-- Replace YOUR_PROJECT_ID and YOUR_BUCKET_NAME if running this manually.
-- =====================================================

LOAD DATA OVERWRITE `YOUR_PROJECT_ID.scholartrack_warehouse.student_performance_stage` (
    student_id STRING,
    Hours_Studied INT64,
    Attendance INT64,
    Parental_Involvement STRING,
    Access_to_Resources STRING,
    Extracurricular_Activities STRING,
    Sleep_Hours INT64,
    Previous_Scores INT64,
    Motivation_Level STRING,
    Internet_Access STRING,
    Tutoring_Sessions INT64,
    Family_Income STRING,
    Teacher_Quality STRING,
    School_Type STRING,
    Peer_Influence STRING,
    Physical_Activity INT64,
    Learning_Disabilities STRING,
    Parental_Education_Level STRING,
    Distance_from_Home STRING,
    Gender STRING,
    Exam_Score INT64,
    assessment_date DATE,
    assessment_year INT64,
    assessment_month INT64
)
FROM FILES (
    format = 'CSV',
    skip_leading_rows = 1,
    uris = ['gs://YOUR_BUCKET_NAME/raw/student_performance/transformed_student_performance.csv']
);
