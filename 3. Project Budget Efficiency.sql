/* 3. Project Budget Efficiency:
- Evaluate the efficiency of project budgets by calculating costs per hour worked. */
SELECT project_id, project_name, budget,
SUM(hours_worked) AS total_hours_worked,
ROUND(budget / NULLIF(SUM(hours_worked), 0), 2) AS cost_per_hour
FROM project_assignments
GROUP BY project_id, project_name, budget
ORDER BY cost_per_hour ASC;