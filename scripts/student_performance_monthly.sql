-- =====================================================
-- 2) MONTHLY AGGREGATED TABLE
-- Purpose:
-- Reporting-ready monthly summary by school type.
-- =====================================================

CREATE OR REPLACE TABLE `valid-unfolding-485807-q6.scholartrack_warehouse.student_performance_monthly` AS
SELECT
    assessment_year,
    assessment_month,
    School_Type,
    AVG(Exam_Score) AS avg_score,
    COUNT(student_id) AS student_count
FROM `valid-unfolding-485807-q6.scholartrack_warehouse.student_performance`
GROUP BY
    assessment_year,
    assessment_month,
    School_Type
ORDER BY
    assessment_year,
    assessment_month,
    School_Type;