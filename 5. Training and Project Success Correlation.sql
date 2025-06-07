/* 5. Training and Project Success Correlation:
- Link training technologies with project milestones to assess the real-world impact of training. */
SELECT tp.employeeid, tp.technologies_covered, pa.project_id, pa.project_name, pa.technologies_used, pa.milestones_achieved
FROM training_programs as tp
JOIN project_assignments as pa ON tp.employeeid = pa.employeeid
WHERE pa.technologies_used LIKE CONCAT('%', SUBSTRING_INDEX(tp.technologies_covered, ',', 1), '%')
ORDER BY pa.milestones_achieved DESC;