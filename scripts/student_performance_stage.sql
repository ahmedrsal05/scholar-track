-- =====================================================
-- 1) FINAL DETAILED WAREHOUSE TABLE
-- Purpose:
-- Main analytical table for row-level reporting.
-- Partitioned by assessment_date
-- Clustered by School_Type, Internet_Access
-- =====================================================

CREATE OR REPLACE TABLE `valid-unfolding-485807-q6.scholartrack_warehouse.student_performance`
PARTITION BY assessment_date
CLUSTER BY School_Type, Internet_Access AS
SELECT
    student_id,
    assessment_date,
    assessment_year,
    assessment_month,
    Hours_Studied,
    Attendance,
    Parental_Involvement,
    Access_to_Resources,
    Extracurricular_Activities,
    Sleep_Hours,
    Previous_Scores,
    Motivation_Level,
    Internet_Access,
    Tutoring_Sessions,
    Family_Income,
    Teacher_Quality,
    School_Type,
    Peer_Influence,
    Physical_Activity,
    Learning_Disabilities,
    Parental_Education_Level,
    Distance_from_Home,
    Gender,
    Exam_Score
FROM `valid-unfolding-485807-q6.scholartrack_warehouse.student_performance_stage`;