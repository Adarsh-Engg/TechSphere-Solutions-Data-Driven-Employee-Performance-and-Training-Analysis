/* 1. Employee Productivity Analysis:
- Identify employees with the highest total hours worked and least absenteeism. */
select employeeid, employeename, sum(total_hours) as total_worked_hours, sum(days_absent + sick_leaves + vacation_leaves) AS total_leaves
 from attendance_records group by employeeid, employeename order by total_worked_hours desc, total_leaves asc;