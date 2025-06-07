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