CREATE DATABASE HOSPITAL;

USE HOSPITAL;

SELECT * FROM HEALTH;

--- #1. Retrieve the Patient_id and ages of all patients.

SELECT PATIENT_ID, AGE FROM HEALTH;

--- #2. Select all female patients who are older than 40.

SELECT GENDER , AGE FROM HEALTH
WHERE AGE > 40 AND GENDER = 'FEMALE';

--- #3. Calculate the average BMI of patients.

SELECT EMPLOYEENAME, AVG(BMI) FROM HEALTH;

--- #4. List patients in descending order of blood glucose levels.

select EMPLOYEENAME, BLOOD_GLUCOSE_LEVEL from health
order by blood_glucose_level DESC;

--- #5. Find patients who have hypertension and diabetes.

select employeename, hypertension, diabetes from health
where hypertension = 1 and diabetes = 1;

--- #6. Determine the number of patients with heart disease.

select count(*) AS number_of_patients_with_heartdisease from health
where heart_disease = 1;

--- #7. Group patients by smoking history and count how many smokers and nonsmokers there are.

SELECT * FROM HEALTH;

SELECT SMOKING_HISTORY, COUNT(*) AS SMOKERS FROM HEALTH
WHERE SMOKING_HISTORY IN ('NEVER','CURRENT')
GROUP BY SMOKING_HISTORY;

SELECT SMOKING_HISTORY,
COUNT(CASE WHEN SMOKING_HISTORY = 'NEVER' THEN 1 END) AS NUMBEROFSMOKERS,
COUNT(CASE WHEN SMOKING_HISTORY = 'CURRENT' THEN 1 END) AS NUMBEROFNONSMOKERS FROM HEALTH
GROUP BY SMOKING_HISTORY;

--- #8.Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

SELECT * FROM HEALTH;

SELECT AVG(BMI) FROM HEALTH;

SELECT PATIENT_ID ,BMI FROM HEALTH
WHERE BMI > (SELECT  AVG(BMI) AS AVERAGEBMI FROM HEALTH);

--- #9.Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

SELECT * FROM HEALTH;

select MAX(HBA1C_LEVEL) from health;

select Min(HBA1C_LEVEL) from health;

SELECT * from health
where HBA1C_LEVEL = (select MAX(HBA1C_LEVEL) from health) or HBA1C_LEVEL= (select min(HBA1C_LEVEL) from health);


--- #10.Calculate the age of patients in years (assuming the current date as of now).

SELECT * from health;

SELECT PATIENT_ID , EMPLOYEENAME, (YEAR(curdate())-AGE) AS ESTIMATED_BIRTH_YEAR FROM HEALTH;

--- #11.Rank patients by blood glucose level within each gender group.

SELECT PATIENT_ID, EMPLOYEENAME, GENDER, BLOOD_GLUCOSE_LEVEL,
RANK() OVER(partition by GENDER order by BLOOD_GLUCOSE_LEVEL) AS GLUCOSE_LEVEL_RANKS FROM HEALTH;

--- #12. Update the smoking history of patients who are older than 50 to "Ex-smoker."

SELECT *FROM HEALTH;

UPDATE HEALTH
SET SMOKING_HISTORY = "EX-SMOKER"
WHERE AGE > 50 ;

--- #13. Insert a new patient into the database with sample data.

INSERT INTO HEALTH(EmployeeName, Patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES ( 'John Doe','PT84806', 'Male', 35, 0, 0, 'Never', 25.5, 5.3, 100, '1');

--- #14. Delete all patients with heart disease from the database.

DELETE FROM HEALTH
WHERE HEART_DISEASE = 1;

--- #15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

SELECT EMPLOYEENAME,PATIENT_ID, HYPERTENSION, DIABETES FROM HEALTH
WHERE HYPERTENSION = 1 
EXCEPT
SELECT EMPLOYEENAME,PATIENT_ID, HYPERTENSION, DIABETES FROM HEALTH
WHERE DIABETES = 1;

--- #16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

ALTER TABLE health
ADD UNIQUE (patient_id);

--- #17. Create a view that displays the Patient_ids, ages, and BMI of patients.

CREATE view PATIENTINFO AS 
SELECT PATIENT_ID, AGE, BMI FROM HEALTH;

SELECT * FROM PATIENTINFO;

--- #18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity

## Normalization:
-- Ensure the database is normalized to remove redundant data.
-- Normalize the tables to minimize duplicate information and reduce data anomalies.
-- Break down tables into smaller, more atomic units to reduce redundancy and improve maintainability.

## Use of Primary Keys and Foreign Keys:
 -- Implement primary keys on tables to ensure each row has a unique identifier.
 -- Employ foreign keys to establish relationships between tables, enforcing referential integrity and preventing inconsistent data.

## Avoidance of Repeated Data: 
-- Identify and eliminate repeated data by creating separate tables for entities and relationships.
-- For instance, instead of storing repeated text data (e.g., patient names) in multiple tables,
-- create a separate 'Patients' table with a unique identifier and reference it using foreign keys where necessary.

## Normalization Techniques: 
-- Employ normalization techniques like 
-- First Normal Form (1NF),
-- Second Normal Form (2NF),
-- Third Normal Form (3NF), and Boyce-Codd Normal Form (BCNF) to organize data and remove redundant attributes.

## Consistent Data Types: 
-- Ensure consistent data types across columns.
--  Use appropriate data types for columns to prevent data inconsistencies and improve data integrity.

## Use of Views: 
-- Utilize views to present consolidated and simplified data from multiple tables without altering the underlying structure.
--  Views can provide a way to access normalized data without compromising data integrity.

## Regular Maintenance and Review: 
-- Regularly review the database schema for improvements. 
-- Refactor the schema based on changing business requirements to optimize it for efficiency and maintainability.

## Constraint Enforcement: 
-- Enforce constraints such as UNIQUE, NOT NULL, and CHECK constraints to ensure data integrity at the database level.

## Normalization to Remove Redundancy: 
-- For example, if 'Patient' information is repeated in multiple tables, create a single 'Patients' table and reference it using foreign keys in related tables.

## Use of Indexes: 
-- Strategically use indexes to improve query performance and enforce uniqueness where necessary.

--- #19. Explain how you can optimize the performance of SQL queries on this dataset.

## Use Indexes: 
-- Create indexes on frequently used columns for WHERE, JOIN, and ORDER BY clauses to speed up data retrieval.

## Optimize Queries: 
-- Write efficient queries by avoiding unnecessary joins, 
-- selecting required columns, and using WHERE clauses effectively to limit results.
-- Minimize wildcard (*) selects and fetch only necessary data.

## Avoid Cursors: 
-- Prefer set-based operations like JOINs, GROUP BY, and aggregate functions over cursors,
-- as they are more efficient and less resource-intensive.

## Use EXPLAIN or Query Plan Analysis: 
-- Analyze query execution plans to identify optimization areas and understand how the database accesses data.

## Avoid Subqueries: 
-- Optimize queries by replacing subqueries with JOINs or derived tables for better performance.

## Proper Data Types and Design: 
-- Use suitable data types and normalize the database schema to prevent redundancy, enhancing query performance.

## Partitioning and Sharding: 
-- Consider partitioning or sharding for large datasets to improve data access and distribution.

## Database Configuration and Tuning: 
-- Configure database settings, memory allocation, and caching based on workload and best practices to optimize performance.

## Regular Maintenance: 
-- Perform routine tasks like updating statistics, rebuilding indexes, and database reorganization for optimal performance.

## Use Stored Procedures: 
-- Utilize stored procedures for frequent tasks to reduce network traffic and execute multiple SQL statements efficiently.

## Monitor and Analyze Performance: 
-- Continuously monitor database performance, identify bottlenecks, and apply optimization techniques.

## Limit Returned Data: 
-- Fetch only necessary data using LIMIT or TOP clauses, especially with large datasets, to improve query efficiency
