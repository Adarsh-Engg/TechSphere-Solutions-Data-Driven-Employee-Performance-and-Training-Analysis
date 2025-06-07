/* 7. Cross Analysis of Training and Project Success
- Identify employees who have undergone training in specific technologies and 
contributed to high-performing projects using those technologies */
SELECT tp.employeeid,tp.employeename, tp.technologies_covered,
    pa.project_id, pa.project_name, pa.technologies_used,
    pa.milestones_achieved
FROM training_programs as tp
JOIN project_assignments pa ON tp.employeeid = pa.employeeid
WHERE pa.technologies_used LIKE CONCAT('%', SUBSTRING_INDEX(tp.technologies_covered, ',', 1), '%')
AND pa.milestones_achieved >= (SELECT AVG(milestones_achieved) FROM project_assignments)
ORDER BY pa.milestones_achieved DESC; 