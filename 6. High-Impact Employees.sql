/* 6. High-Impact Employees:
- Identify employees who significantly contribute to 
high-budget projects while maintaining excellent performance scores. */
SELECT pa.employeeid, ed.employeename, ed.department_id, ed.performance_score, 
pa.project_id, pa.project_name, pa.budget, pa.hours_worked, pa.milestones_achieved
FROM project_assignments pa
JOIN employee_details ed ON pa.employeeid = ed.employeeid
WHERE ed.performance_score = 'Excellent' AND pa.budget > (SELECT AVG(budget) FROM project_assignments)
ORDER BY pa.hours_worked DESC, pa.milestones_achieved DESC;