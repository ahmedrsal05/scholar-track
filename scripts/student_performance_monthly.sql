-- =====================================================
-- 2) MONTHLY AGGREGATED TABLE
-- Purpose:
-- Reporting-ready monthly summary by school type.
-- =====================================================

-- Replace YOUR_PROJECT_ID if running this manually.
CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.scholartrack_warehouse.student_performance_monthly` AS
SELECT
    assessment_year,
    assessment_month,
    School_Type,
    AVG(Exam_Score) AS avg_score,
    COUNT(student_id) AS student_count
FROM `YOUR_PROJECT_ID.scholartrack_warehouse.student_performance`
GROUP BY
    assessment_year,
    assessment_month,
    School_Type
ORDER BY
    assessment_year,
    assessment_month,
    School_Type;
