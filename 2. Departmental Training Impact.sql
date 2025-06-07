/* 2. *Departmental Training Impact:
- Analyze how training programs improve departmental performance.*/
 SELECT tp.department_id,
    COUNT(DISTINCT tp.program_id) AS total_training_programs,
    COUNT(DISTINCT tp.employeeid) AS trained_employees,
    ROUND(AVG(tp.feedback_score), 2) AS avg_training_feedback,
    ROUND(AVG(CASE ed.performance_score
            WHEN 'Excellent' THEN 5
            WHEN 'Good' THEN 4
            WHEN 'Average' THEN 3
            WHEN 'Needs Improvement' THEN 2
            WHEN 'Poor' THEN 1
        END), 2) AS avg_performance_score
FROM  training_programs tp
JOIN employee_details ed ON tp.employeeid = ed.employeeid
GROUP BY tp.department_id ORDER BY  avg_performance_score DESC;