-- Queries using joins
-- Populate table
CREATE TABLE employee_detail (employee_id INT, name VARCHAR(255), date_of_birth INT, gender VARCHAR(1)); INSERT INTO employee_detail VALUES (1000,"Bob",20000304,"M"), (1001,"Joe",19740310,"M"), (1002,"Adam",19640312,"M"), (1003,"Debra",19910306,"F"), (1004,"Charlotte",19870307,"F"), (1005,"Katie",19960304,"F"), (1006,"Sam",19620313,"F"), (1007,"Ashley",19810308,"U"), (1008,"Robert",19680311,"M"), (1009,"Usman",19850307,"M"), (1010,"Andrea",19980304,"F"), (1011,"Vaskor",19680311,"M"), (1012,"Catherine",19890306,"F"), (1013,"Graham",19660312,"F"), (1014,"Christopher",19840307,"M"), (1015,"Laura",19780309,"F"), (1016,"Tanya",19940305,"U"), (1017,"Rachael",19910306,"F");
CREATE TABLE laptop_detail (laptop_id INT, os VARCHAR(255), date_of_manufacture INT); INSERT INTO laptop_detail VALUES (9000,"Mac",20171024), (9001,"Ubuntu",20161125), (9002,"Windows",20180511), (9003,"Mac",20160618), (9004,"Mac",20170812), (9005,"Windows",20180401);
CREATE TABLE jobs_history (employee_id INT, job_title VARCHAR(255), date_start INT, date_end INT); INSERT INTO jobs_history VALUES (1000,"Payroll",20190103,20991231), (1001,"Tech Lead",20151212,20991231), (1002,"Developer",20120503,20991231), (1003,"Developer",20180716,20991231), (1004,"Payroll",20171025,20991231), (1005,"Product Lead",20161003,20991231), (1006,"Lead Developer",20110223,20991231), (1007,"Developer",20180507,20991231), (1008,"Marketing Lead",20180816,20991231), (1009,"Developer",20150725,20991231), (1010,"Developer",20111215,20991231), (1011,"Tech Lead",20180226,20991231), (1012,"Product Lead",20180607,20991231), (1013,"Lead Developer",20150516,20991231), (1014,"Marketing Lead",20111006,20991231), (1015,"Developer",20171218,20991231), (1016,"Developer",20180329,20991231), (1017,"Developer",20150307,20991231), (1001,"Developer",20051128,20151211), (1002,"Payroll",20100831,20120502), (1001,"Payroll",20050828,20051127), (1004,"Product Lead",20151228,20171024), (1009,"Payroll",20140310,20150724), (1010,"Payroll",20110330,20111214), (1011,"Payroll",20170405,20180225), (1016,"Payroll",20161207,20180328);
CREATE TABLE current_job_detail (employee_id INT, job_title VARCHAR(255), salary INT, laptop_id INT); INSERT INTO current_job_detail VALUES (1000,"Payroll",16000,9000), (1001,"Tech Lead",61000,9001), (1002,"Developer",35000,9003), (1003,"Developer",37000,9001), (1004,"Payroll",16500,9000), (1005,"Product Lead",53000,9001), (1006,"Lead Developer",52000,9000), (1007,"Developer",48000,9000), (1008,"Marketing Lead",75000,9003), (1009,"Developer",38500,9001), (1010,"Developer",39500,9004), (1011,"Tech Lead",61000,9000), (1012,"Product Lead",49500,9004), (1013,"Lead Developer",46500,9005), (1014,"Marketing Lead",61000,9000), (1015,"Developer",41000,9000), (1016,"Developer",42500,9005), (1017,"Developer",45500,9000);

-- Total number of employees = 18
SELECT 
    COUNT(*)
FROM
    employee_detail;
    
-- Best paid employee = Robert	Marketing Lead	75000
    SELECT 
    employee_detail.name,
    current_job_detail.job_title,
    current_job_detail.salary
FROM
    employee_detail
        JOIN
    current_job_detail ON current_job_detail.employee_id = employee_detail.employee_id
WHERE
    current_job_detail.salary = (SELECT 
            MAX(current_job_detail.salary)
        FROM
            current_job_detail);

-- How many developers are there? = 10 
Select * from current_job_detail where job_title like "%eveloper%"; -- d ommited to deal with caps

-- How many developers in each bracket? = 1, as no developers on same wage
SELECT 
    salary, COUNT(*)
FROM
    current_job_detail
WHERE
    job_title LIKE '%eveloper%'
GROUP BY salary;

-- How many employees aren't developers, what are they paid? =8
SELECT 
    count(*), salary
FROM
    current_job_detail
WHERE
    job_title NOT LIKE '%eveloper%'
    group by salary; 