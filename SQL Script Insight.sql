/* 1. Employee Productivity Analysis:
- Identify employees with the highest total hours worked and least absenteeism. */
select employeeid, employeename, sum(total_hours) as total_worked_hours, sum(days_absent + sick_leaves + vacation_leaves) AS total_leaves
 from attendance_records group by employeeid, employeename order by total_worked_hours desc, total_leaves asc limit 10;
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

/* 3. Project Budget Efficiency:
- Evaluate the efficiency of project budgets by calculating costs per hour worked. */
SELECT project_id, project_name, budget,
SUM(hours_worked) AS total_hours_worked,
ROUND(budget / NULLIF(SUM(hours_worked), 0), 2) AS cost_per_hour
FROM project_assignments
GROUP BY project_id, project_name, budget
ORDER BY cost_per_hour ASC;

/*4. Attendance Consistency:
- Measure attendance trends and identify departments with significant deviations. */
SELECT ed.department_id,
    ROUND(AVG(ar.total_hours), 2) AS avg_total_hours,
    ROUND(AVG(ar.days_present), 2) AS avg_days_present,
    ROUND(AVG(ar.days_absent), 2) AS avg_days_absent,
    ROUND(STDDEV_POP(ar.total_hours), 2) AS std_dev_hours,
    COUNT(DISTINCT ar.employeeid) AS employees_count
FROM attendance_records as ar
JOIN employee_details ed ON ar.employeeid = ed.employeeid
GROUP BY ed.department_id ORDER BY std_dev_hours DESC;

/* 5. Training and Project Success Correlation:
- Link training technologies with project milestones to assess the real-world impact of training. */
SELECT tp.employeeid, tp.technologies_covered, pa.project_id, pa.project_name, pa.technologies_used, pa.milestones_achieved
FROM training_programs as tp
JOIN project_assignments as pa ON tp.employeeid = pa.employeeid
WHERE pa.technologies_used LIKE CONCAT('%', SUBSTRING_INDEX(tp.technologies_covered, ',', 1), '%')
ORDER BY pa.milestones_achieved DESC;

/*  6. High-Impact Employees:
- Identify employees who significantly contribute to 
high-budget projects while maintaining excellent performance scores. */
SELECT pa.employeeid, ed.employeename, ed.department_id, ed.performance_score, 
pa.project_id, pa.project_name, pa.budget, pa.hours_worked, pa.milestones_achieved
FROM project_assignments pa
JOIN employee_details ed ON pa.employeeid = ed.employeeid
WHERE ed.performance_score = 'Excellent' AND pa.budget > (SELECT AVG(budget) FROM project_assignments)
ORDER BY pa.hours_worked DESC, pa.milestones_achieved DESC;

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




