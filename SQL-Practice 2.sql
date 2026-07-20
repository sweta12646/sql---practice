/* ============================================================
   PRACTICE FILE: DATE & TIME FUNCTIONS
   Scenario: HR Analytics
   The HR team tracks employee joining dates, daily attendance,
   clock-in/clock-out times, and calculates working hours and
   tenure for payroll and performance reports.
   Instructions: Write the SQL query below each question.
   ============================================================ */


/* ------------------------------------------------------------
   STEP 1: CREATE TABLE
   ------------------------------------------------------------ */
create database practices;
use practices;

CREATE TABLE EmployeeAttendance (
    attendance_id INT,
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    date_of_joining DATE,
    work_date DATE,
    clock_in DATETIME,
    clock_out DATETIME
);


/* ------------------------------------------------------------
   STEP 2: INSERT DATA
   ------------------------------------------------------------ */

INSERT INTO EmployeeAttendance VALUES
(1, 101, 'Ravi Kumar', 'IT', '2023-04-10', '2026-07-01', '2026-07-01 09:05:00', '2026-07-01 18:10:00'),
(2, 102, 'Priya Sharma', 'HR', '2022-01-15', '2026-07-01', '2026-07-01 09:45:00', '2026-07-01 17:30:00'),
(3, 103, 'Aman Gupta', 'IT', '2024-06-01', '2026-07-02', '2026-07-02 10:00:00', '2026-07-02 19:20:00'),
(4, 104, 'Sneha Iyer', 'Sales', '2021-09-20', '2026-07-02', '2026-07-02 08:55:00', '2026-07-02 17:05:00'),
(5, 105, 'Karan Mehta', 'IT', '2023-11-05', '2026-07-03', '2026-07-03 09:15:00', '2026-07-03 18:45:00'),
(6, 106, 'Divya Nair', 'HR', '2020-03-12', '2026-07-03', '2026-07-03 09:00:00', '2026-07-03 16:50:00'),
(7, 107, 'Rohit Verma', 'Sales', '2024-02-18', '2026-07-06', '2026-07-06 09:30:00', NULL),
(8, 108, 'Anjali Singh', 'IT', '2025-05-01', '2026-07-06', '2026-07-06 09:10:00', '2026-07-06 20:00:00');

select * from EmployeeAttendance ;

/* ============================================================
   SECTION: DATE & TIME FUNCTIONS
   ============================================================ */

-- Q1. Display the current date and current time.
select curdate() as Today,
curtime() as now_time,
now() as current_date_time;

-- Q2. Extract the year, month, and day from each employee's date_of_joining.
SELECT emp_id,emp_name,
       YEAR(date_of_joining) AS Join_Year,
       MONTH(date_of_joining) AS Join_Month,
       DAY(date_of_joining) AS Join_Day
FROM EmployeeAttendance;

-- Q3. Display the day name (e.g., Monday, Tuesday) on which each employee joined.
SELECT emp_id,emp_name,
       DAYNAME(date_of_joining) AS Joining_Day
FROM EmployeeAttendance;

-- Q4. Find the total number of days each employee has worked in the company
--     (from date_of_joining till today).
SELECT emp_id,emp_name,
       DATEDIFF(CURDATE(), date_of_joining) AS Days_Worked
FROM employeeattendance;

-- Q5. Find the number of completed years of service for each employee
--     (tenure in years, from date_of_joining till today).
SELECT emp_id,emp_name,
       TIMESTAMPDIFF(YEAR, date_of_joining, CURDATE()) AS Years_of_Service
FROM employeeattendance;

-- Q6. Calculate the total number of hours each employee worked on a given work_date
--     (using clock_in and clock_out).
SELECT emp_id,emp_name,work_date,
       TIMESTAMPDIFF(HOUR, clock_in, clock_out) AS Hours_Worked
FROM employeeattendance;


-- Q7. Extract the hour at which each employee clocked in.
SELECT emp_id,emp_name,
       HOUR(clock_in) AS Clock_In_Hour
FROM employeeattendance;

-- Q8. Find employees who clocked in after 9:30 AM (late arrivals).
SELECT emp_id,emp_name,clock_in
FROM employeeattendance
WHERE TIME(clock_in) > '09:30:00';

-- Q9. Find employees who worked more than 9 hours on a given day.
SELECT emp_id,emp_name,work_date,
       TIMESTAMPDIFF(HOUR, clock_in, clock_out) AS Hours_Worked
FROM employeeattendance
WHERE TIMESTAMPDIFF(HOUR, clock_in, clock_out) > 9;

-- Q10. Add 30 days to each employee's date_of_joining to find their
--      probation completion date.
SELECT emp_id,emp_name,date_of_joining,
       DATE_ADD(date_of_joining, INTERVAL 30 DAY) AS Probation_Completion_Date
FROM employeeattendance;

-- Q11. Format date_of_joining as DD-MM-YYYY for a report.
SELECT emp_id,emp_name,
       DATE_FORMAT(date_of_joining, '%d-%m-%Y') AS Formatted_Joining_Date
FROM employeeattendance;

-- Q12. Find employees who joined in a specific month and year (e.g., June 2024).
SELECT emp_id,emp_name,date_of_joining
FROM employeeattendance
WHERE YEAR(date_of_joining) = 2024
  AND MONTH(date_of_joining) = 6;

-- Q13. Find the quarter of the year in which each employee joined.
SELECT emp_id,emp_name,date_of_joining,
       QUARTER(date_of_joining) AS Joining_Quarter
FROM employeeattendance;

-- Q14. Find the week number of the year for each work_date.
SELECT emp_id,emp_name,work_date,
       WEEK(work_date) AS Week_Number
FROM employeeattendance;

-- Q15. Find employees who have not yet clocked out (still working / missing clock_out).
SELECT emp_id,emp_name,work_date,clock_in
FROM employeeattendance
WHERE clock_out IS NULL;

-- Q16. Calculate the difference in minutes between clock_in and clock_out for each record.
SELECT emp_id,emp_name,work_date,
       TIMESTAMPDIFF(MINUTE, clock_in, clock_out) AS Minutes_Worked
FROM employeeattendance
WHERE clock_out IS NOT NULL;
