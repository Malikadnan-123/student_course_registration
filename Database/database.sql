create database student_course_registration;
show databases;
USE student_course_registration;
SELECT DATABASE();
CREATE TABLE Department (
    dept_id VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);
show tables;
DESC Department;
INSERT INTO Department VALUES
('CSE','Computer Science and Engineering'),
('ISE','Information Science and Engineering'),
('ECE','Electronics and Communication Engineering'),
('ME','Mechanical Engineering'),
('CE','Civil Engineering');
SELECT * FROM Department;

CREATE TABLE Student (
    usn VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    gender VARCHAR(10) NOT NULL
        CHECK (gender IN ('Male','Female')),
    sem INT NOT NULL CHECK (sem BETWEEN 1 AND 8),
    dept_id VARCHAR(10) NOT NULL,

    FOREIGN KEY (dept_id)
    REFERENCES Department(dept_id)
);
desc Student;
show tables;

CREATE TABLE Professor (
    prof_id VARCHAR(10) PRIMARY KEY,
    prof_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    designation VARCHAR(50) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,

    FOREIGN KEY (dept_id)
    REFERENCES Department(dept_id)
);
DESC Professor;
SHOW TABLES;

CREATE TABLE Subject (
    sub_code VARCHAR(20) PRIMARY KEY,
    sub_name VARCHAR(100) UNIQUE NOT NULL,
    credits INT NOT NULL
        CHECK (credits BETWEEN 1 AND 5),
    prof_id VARCHAR(10) NOT NULL,

    FOREIGN KEY (prof_id)
    REFERENCES Professor(prof_id)
);
DESC Subject;
SHOW TABLES;

CREATE TABLE Enrollment (
    enroll_id INT AUTO_INCREMENT PRIMARY KEY,
    usn VARCHAR(10) NOT NULL,
    sub_code VARCHAR(20) NOT NULL,
    enroll_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Active','Dropped','Completed')),

    FOREIGN KEY (usn)
    REFERENCES Student(usn),

    FOREIGN KEY (sub_code)
    REFERENCES Subject(sub_code)
);
desc Enrollment;
show tables;

show databases;
use student_course_registration;

INSERT INTO Professor
(prof_id, prof_name, phone, email, designation, dept_id)
VALUES

-- CSE
('CSE_01', 'Dr. Suneetha K R', '9876543201', 'suneetha.kr@bit-bangalore.edu.in', 'HOD', 'CSE'),
('CSE_02', 'Dr. Hemavathi P', '9876543202', 'hemavathi.p@bit-bangalore.edu.in', 'Professor', 'CSE'),
('CSE_03', 'Sunanda H G', '9876543203', 'sunanda.hg@bit-bangalore.edu.in', 'Assistant Professor', 'CSE'),

-- ISE
('ISE_01', 'Dr. Asha T', '9876543204', 'asha.t@bit-bangalore.edu.in', 'HOD', 'ISE'),
('ISE_02', 'Dr. Roopa H', '9876543205', 'roopa.h@bit-bangalore.edu.in', 'Professor', 'ISE'),
('ISE_03', 'Dr. Vani B', '9876543206', 'vani.b@bit-bangalore.edu.in', 'Assistant Professor', 'ISE'),

-- ECE
('ECE_01', 'Dr. Kalpana', '9876543207', 'kalpana@bit-bangalore.edu.in', 'HOD', 'ECE'),
('ECE_02', 'Dr. Radha', '9876543208', 'radha@bit-bangalore.edu.in', 'Professor', 'ECE'),
('ECE_03', 'Dr. Krishna', '9876543209', 'krishna@bit-bangalore.edu.in', 'Associate Professor', 'ECE'),

-- ME
('ME_01', 'Dr. Aswatha', '9876543210', 'aswatha@bit-bangalore.edu.in', 'HOD', 'ME'),
('ME_02', 'Dr. Honne', '9876543211', 'honne@bit-bangalore.edu.in', 'Professor', 'ME'),
('ME_03', 'Dr. Praveen', '9876543212', 'praveen@bit-bangalore.edu.in', 'Associate Professor', 'ME'),

-- CE
('CE_01', 'Dr. B S Putte', '9876543213', 'bs.putte@bit-bangalore.edu.in', 'HOD', 'CE'),
('CE_02', 'Dr. Vatshala', '9876543214', 'vatshala@bit-bangalore.edu.in', 'Associate Professor', 'CE'),
('CE_03', 'Dr. Archana', '9876543215', 'archana@bit-bangalore.edu.in', 'Assistant Professor', 'CE');

select * from Professor;

INSERT INTO Student
(usn, name, address, phone, email, gender, sem, dept_id)
VALUES

-- CSE 2nd Semester
('1BI25CS001', 'Rahul Kumar', 'Patna, Bihar', '9000000001', '1BI25CS001@bit-bangalore.edu.in', 'Male', 2, 'CSE'),
('1BI25CS008', 'Sneha R', 'Mysuru, Karnataka', '9000000002', '1BI25CS008@bit-bangalore.edu.in', 'Female', 2, 'CSE'),
('1BI25CS014', 'Aman Verma', 'Ranchi, Jharkhand', '9000000003', '1BI25CS014@bit-bangalore.edu.in', 'Male', 2, 'CSE'),

-- CSE 4th Semester (Given Data)
('1BI24CS002', 'Abhinav Kumar', 'Begusarai, Bihar', '9000000004', '1BI24CS002@bit-bangalore.edu.in', 'Male', 4, 'CSE'),
('1BI24CS005', 'Adarsh Anand', 'Muzaffarpur, Bihar', '9000000005', '1BI24CS005@bit-bangalore.edu.in', 'Male', 4, 'CSE'),
('1BI24CS015', 'Ananya J', 'Bangalore, Karnataka', '9000000006', '1BI24CS015@bit-bangalore.edu.in', 'Female', 4, 'CSE'),

-- CSE 6th Semester
('1BI23CS003', 'Nikhil Sharma', 'Kanpur, Uttar Pradesh', '9000000007', '1BI23CS003@bit-bangalore.edu.in', 'Male', 6, 'CSE'),
('1BI23CS011', 'Priya S', 'Tumakuru, Karnataka', '9000000008', '1BI23CS011@bit-bangalore.edu.in', 'Female', 6, 'CSE'),
('1BI23CS018', 'Rohit Singh', 'Gaya, Bihar', '9000000009', '1BI23CS018@bit-bangalore.edu.in', 'Male', 6, 'CSE'),

-- CSE 8th Semester
('1BI22CS004', 'Arjun Patel', 'Ahmedabad, Gujarat', '9000000010', '1BI22CS004@bit-bangalore.edu.in', 'Male', 8, 'CSE'),
('1BI22CS010', 'Kavya N', 'Hubballi, Karnataka', '9000000011', '1BI22CS010@bit-bangalore.edu.in', 'Female', 8, 'CSE'),
('1BI22CS016', 'Vivek Raj', 'Darbhanga, Bihar', '9000000012', '1BI22CS016@bit-bangalore.edu.in', 'Male', 8, 'CSE');

select * from Student where dept_id='CSE';

INSERT INTO Student
(usn, name, address, phone, email, gender, sem, dept_id)
VALUES

-- ISE 2nd Semester
('1BI25IS001', 'Akash M', 'Ballari, Karnataka', '9000000013', '1BI25IS001@bit-bangalore.edu.in', 'Male', 2, 'ISE'),
('1BI25IS007', 'Nandini R', 'Mandya, Karnataka', '9000000014', '1BI25IS007@bit-bangalore.edu.in', 'Female', 2, 'ISE'),
('1BI25IS013', 'Sahil Gupta', 'Prayagraj, Uttar Pradesh', '9000000015', '1BI25IS013@bit-bangalore.edu.in', 'Male', 2, 'ISE'),

-- ISE 4th Semester
('1BI24IS002', 'Harsh Vardhan', 'Patna, Bihar', '9000000016', '1BI24IS002@bit-bangalore.edu.in', 'Male', 4, 'ISE'),
('1BI24IS009', 'Deepika S', 'Bengaluru, Karnataka', '9000000017', '1BI24IS009@bit-bangalore.edu.in', 'Female', 4, 'ISE'),
('1BI24IS015', 'Ritesh Kumar', 'Samastipur, Bihar', '9000000018', '1BI24IS015@bit-bangalore.edu.in', 'Male', 4, 'ISE'),

-- ISE 6th Semester
('1BI23IS003', 'Manoj K', 'Mangaluru, Karnataka', '9000000019', '1BI23IS003@bit-bangalore.edu.in', 'Male', 6, 'ISE'),
('1BI23IS010', 'Anjali P', 'Shivamogga, Karnataka', '9000000020', '1BI23IS010@bit-bangalore.edu.in', 'Female', 6, 'ISE'),
('1BI23IS018', 'Aditya Raj', 'Nalanda, Bihar', '9000000021', '1BI23IS018@bit-bangalore.edu.in', 'Male', 6, 'ISE'),

-- ISE 8th Semester
('1BI22IS004', 'Kiran Kumar', 'Belagavi, Karnataka', '9000000022', '1BI22IS004@bit-bangalore.edu.in', 'Male', 8, 'ISE'),
('1BI22IS011', 'Pooja N', 'Davanagere, Karnataka', '9000000023', '1BI22IS011@bit-bangalore.edu.in', 'Female', 8, 'ISE'),
('1BI22IS017', 'Shashank R', 'Bhagalpur, Bihar', '9000000024', '1BI22IS017@bit-bangalore.edu.in', 'Male', 8, 'ISE');

select * from Student where dept_id='ISE';
select * from Student;

INSERT INTO Student
(usn, name, address, phone, email, gender, sem, dept_id)
VALUES

-- ECE 2nd Semester
('1BI25EC001', 'Rohan S', 'Kolar, Karnataka', '9000000025', '1BI25EC001@bit-bangalore.edu.in', 'Male', 2, 'ECE'),
('1BI25EC008', 'Megha P', 'Udupi, Karnataka', '9000000026', '1BI25EC008@bit-bangalore.edu.in', 'Female', 2, 'ECE'),
('1BI25EC014', 'Ayush Kumar', 'Purnia, Bihar', '9000000027', '1BI25EC014@bit-bangalore.edu.in', 'Male', 2, 'ECE'),

-- ECE 4th Semester
('1BI24EC003', 'Nikhil R', 'Hassan, Karnataka', '9000000028', '1BI24EC003@bit-bangalore.edu.in', 'Male', 4, 'ECE'),
('1BI24EC010', 'Sanjana M', 'Chikkamagaluru, Karnataka', '9000000029', '1BI24EC010@bit-bangalore.edu.in', 'Female', 4, 'ECE'),
('1BI24EC016', 'Abhishek Raj', 'Sitamarhi, Bihar', '9000000030', '1BI24EC016@bit-bangalore.edu.in', 'Male', 4, 'ECE'),

-- ECE 6th Semester
('1BI23EC004', 'Karthik N', 'Mysuru, Karnataka', '9000000031', '1BI23EC004@bit-bangalore.edu.in', 'Male', 6, 'ECE'),
('1BI23EC011', 'Anusha K', 'Tumakuru, Karnataka', '9000000032', '1BI23EC011@bit-bangalore.edu.in', 'Female', 6, 'ECE'),
('1BI23EC018', 'Vikas Singh', 'Ara, Bihar', '9000000033', '1BI23EC018@bit-bangalore.edu.in', 'Male', 6, 'ECE'),

-- ECE 8th Semester
('1BI22EC005', 'Pranav R', 'Ballari, Karnataka', '9000000034', '1BI22EC005@bit-bangalore.edu.in', 'Male', 8, 'ECE'),
('1BI22EC012', 'Keerthana S', 'Mandya, Karnataka', '9000000035', '1BI22EC012@bit-bangalore.edu.in', 'Female', 8, 'ECE'),
('1BI22EC019', 'Rahul Anand', 'Madhubani, Bihar', '9000000036', '1BI22EC019@bit-bangalore.edu.in', 'Male', 8, 'ECE');

select * from Student where dept_id='ECE';
select * from Student;

INSERT INTO Student
(usn, name, address, phone, email, gender, sem, dept_id)
VALUES

-- ME 2nd Semester
('1BI25ME001', 'Aravind K', 'Vijayapura, Karnataka', '9000000037', '1BI25ME001@bit-bangalore.edu.in', 'Male', 2, 'ME'),
('1BI25ME008', 'Bhavana R', 'Raichur, Karnataka', '9000000038', '1BI25ME008@bit-bangalore.edu.in', 'Female', 2, 'ME'),
('1BI25ME014', 'Ritik Kumar', 'Buxar, Bihar', '9000000039', '1BI25ME014@bit-bangalore.edu.in', 'Male', 2, 'ME'),

-- ME 4th Semester
('1BI24ME003', 'Naveen P', 'Kalaburagi, Karnataka', '9000000040', '1BI24ME003@bit-bangalore.edu.in', 'Male', 4, 'ME'),
('1BI24ME010', 'Shreya M', 'Koppal, Karnataka', '9000000041', '1BI24ME010@bit-bangalore.edu.in', 'Female', 4, 'ME'),
('1BI24ME016', 'Amit Raj', 'Siwan, Bihar', '9000000042', '1BI24ME016@bit-bangalore.edu.in', 'Male', 4, 'ME'),

-- ME 6th Semester
('1BI23ME004', 'Pradeep S', 'Dharwad, Karnataka', '9000000043', '1BI23ME004@bit-bangalore.edu.in', 'Male', 6, 'ME'),
('1BI23ME011', 'Nisha K', 'Haveri, Karnataka', '9000000044', '1BI23ME011@bit-bangalore.edu.in', 'Female', 6, 'ME'),
('1BI23ME018', 'Vikash Kumar', 'Chapra, Bihar', '9000000045', '1BI23ME018@bit-bangalore.edu.in', 'Male', 6, 'ME'),

-- ME 8th Semester
('1BI22ME005', 'Kiran Raj', 'Bagalkot, Karnataka', '9000000046', '1BI22ME005@bit-bangalore.edu.in', 'Male', 8, 'ME'),
('1BI22ME012', 'Aishwarya P', 'Yadgir, Karnataka', '9000000047', '1BI22ME012@bit-bangalore.edu.in', 'Female', 8, 'ME'),
('1BI22ME019', 'Rohit Anand', 'Saharsa, Bihar', '9000000048', '1BI22ME019@bit-bangalore.edu.in', 'Male', 8, 'ME');

INSERT INTO Student
(usn, name, address, phone, email, gender, sem, dept_id)
VALUES

-- CE 2nd Semester
('1BI25CE001', 'Sandeep K', 'Bidar, Karnataka', '9000000049', '1BI25CE001@bit-bangalore.edu.in', 'Male', 2, 'CE'),
('1BI25CE008', 'Divya R', 'Chitradurga, Karnataka', '9000000050', '1BI25CE008@bit-bangalore.edu.in', 'Female', 2, 'CE'),
('1BI25CE014', 'Manish Kumar', 'Katihar, Bihar', '9000000051', '1BI25CE014@bit-bangalore.edu.in', 'Male', 2, 'CE'),

-- CE 4th Semester
('1BI24CE003', 'Harish P', 'Ramanagara, Karnataka', '9000000052', '1BI24CE003@bit-bangalore.edu.in', 'Male', 4, 'CE'),
('1BI24CE010', 'Pavithra M', 'Kodagu, Karnataka', '9000000053', '1BI24CE010@bit-bangalore.edu.in', 'Female', 4, 'CE'),
('1BI24CE016', 'Ankit Raj', 'Araria, Bihar', '9000000054', '1BI24CE016@bit-bangalore.edu.in', 'Male', 4, 'CE'),

-- CE 6th Semester
('1BI23CE004', 'Lokesh S', 'Tumakuru, Karnataka', '9000000055', '1BI23CE004@bit-bangalore.edu.in', 'Male', 6, 'CE'),
('1BI23CE011', 'Pooja K', 'Belagavi, Karnataka', '9000000056', '1BI23CE011@bit-bangalore.edu.in', 'Female', 6, 'CE'),
('1BI23CE018', 'Suraj Kumar', 'Jehanabad, Bihar', '9000000057', '1BI23CE018@bit-bangalore.edu.in', 'Male', 6, 'CE'),

-- CE 8th Semester
('1BI22CE005', 'Akshay R', 'Vijayanagara, Karnataka', '9000000058', '1BI22CE005@bit-bangalore.edu.in', 'Male', 8, 'CE'),
('1BI22CE012', 'Nandita P', 'Uttara Kannada, Karnataka', '9000000059', '1BI22CE012@bit-bangalore.edu.in', 'Female', 8, 'CE'),
('1BI22CE019', 'Rakesh Anand', 'Madhepura, Bihar', '9000000060', '1BI22CE019@bit-bangalore.edu.in', 'Male', 8, 'CE');

SELECT COUNT(*) AS Total_Students FROM Student;

ALTER TABLE Subject
ADD sem INT NOT NULL
CHECK (sem BETWEEN 1 AND 8);

desc Subject;

show databases;
use student_course_registration;
show tables;
desc subject;

ALTER TABLE Subject
ADD dept_id VARCHAR(10) NOT NULL;
ALTER TABLE Subject
ADD CONSTRAINT fk_subject_department
FOREIGN KEY (dept_id)
REFERENCES Department(dept_id);
desc subject;

ALTER TABLE Subject
DROP INDEX sub_name;
SHOW INDEX FROM Subject;

INSERT INTO Subject
(sub_code, sub_name, credits, sem, dept_id, prof_id)
VALUES

-- ================= CSE =================
('CS201', 'Programming in C', 4, 2, 'CSE', 'CSE_03'),
('CS202', 'Engineering Mathematics II', 3, 2, 'CSE', 'CSE_02'),

('CS401', 'Design and Analysis of Algorithms', 4, 4, 'CSE', 'CSE_02'),
('CS402', 'Database Management Systems', 3, 4, 'CSE', 'CSE_03'),

('CS601', 'Operating Systems', 4, 6, 'CSE', 'CSE_01'),
('CS602', 'Computer Networks', 3, 6, 'CSE', 'CSE_02'),

('CS801', 'Internship', 5, 8, 'CSE', 'CSE_01'),
('CS802', 'Project Work', 4, 8, 'CSE', 'CSE_02'),

-- ================= ISE =================
('IS201', 'Python Programming', 4, 2, 'ISE', 'ISE_03'),
('IS202', 'Discrete Mathematics', 3, 2, 'ISE', 'ISE_02'),

('IS401', 'Web Technologies', 4, 4, 'ISE', 'ISE_02'),
('IS402', 'Software Engineering', 3, 4, 'ISE', 'ISE_03'),

('IS601', 'Data Mining', 4, 6, 'ISE', 'ISE_01'),
('IS602', 'Cloud Computing', 3, 6, 'ISE', 'ISE_02'),

('IS801', 'Internship', 5, 8, 'ISE', 'ISE_01'),
('IS802', 'Project Work', 4, 8, 'ISE', 'ISE_02');

INSERT INTO Subject
(sub_code, sub_name, credits, sem, dept_id, prof_id)
VALUES

-- ================= ECE =================
('EC201', 'Basic Electronics', 4, 2, 'ECE', 'ECE_03'),
('EC202', 'Network Analysis', 3, 2, 'ECE', 'ECE_02'),

('EC401', 'Analog Communication', 4, 4, 'ECE', 'ECE_02'),
('EC402', 'Digital Signal Processing', 3, 4, 'ECE', 'ECE_03'),

('EC601', 'VLSI Design', 4, 6, 'ECE', 'ECE_01'),
('EC602', 'Embedded Systems', 3, 6, 'ECE', 'ECE_02'),

('EC801', 'Internship', 5, 8, 'ECE', 'ECE_01'),
('EC802', 'Project Work', 4, 8, 'ECE', 'ECE_02'),

-- ================= ME =================
('ME201', 'Engineering Mechanics', 4, 2, 'ME', 'ME_03'),
('ME202', 'Engineering Graphics', 3, 2, 'ME', 'ME_02'),

('ME401', 'Thermodynamics', 4, 4, 'ME', 'ME_02'),
('ME402', 'Manufacturing Processes', 3, 4, 'ME', 'ME_03'),

('ME601', 'Heat Transfer', 4, 6, 'ME', 'ME_01'),
('ME602', 'Machine Design', 3, 6, 'ME', 'ME_02'),

('ME801', 'Internship', 5, 8, 'ME', 'ME_01'),
('ME802', 'Project Work', 4, 8, 'ME', 'ME_02');

INSERT INTO Subject
(sub_code, sub_name, credits, sem, dept_id, prof_id)
VALUES

-- ================= CE =================
('CE201', 'Engineering Geology', 4, 2, 'CE', 'CE_03'),
('CE202', 'Building Materials', 3, 2, 'CE', 'CE_02'),

('CE401', 'Structural Analysis', 4, 4, 'CE', 'CE_02'),
('CE402', 'Concrete Technology', 3, 4, 'CE', 'CE_03'),

('CE601', 'Transportation Engineering', 4, 6, 'CE', 'CE_01'),
('CE602', 'Environmental Engineering', 3, 6, 'CE', 'CE_02'),

('CE801', 'Internship', 5, 8, 'CE', 'CE_01'),
('CE802', 'Project Work', 4, 8, 'CE', 'CE_02');

SELECT COUNT(*) AS Total_Subjects
FROM Subject;

desc enrollment;

INSERT INTO Enrollment (usn, sub_code, status)
VALUES

-- ================= CSE =================

-- Sem 2
('1BI25CS001', 'CS201', 'Active'),
('1BI25CS008', 'CS201', 'Active'),
('1BI25CS008', 'CS202', 'Active'),

-- Sem 4
('1BI24CS002', 'CS401', 'Active'),
('1BI24CS005', 'CS401', 'Active'),
('1BI24CS005', 'CS402', 'Active'),

-- Sem 6
('1BI23CS003', 'CS601', 'Active'),
('1BI23CS003', 'CS602', 'Active'),

-- Sem 8
('1BI22CS004', 'CS801', 'Completed'),
('1BI22CS010', 'CS802', 'Active'),

-- ================= ISE =================

-- Sem 2
('1BI25IS001', 'IS201', 'Active'),
('1BI25IS007', 'IS201', 'Active'),
('1BI25IS007', 'IS202', 'Active'),

-- Sem 4
('1BI24IS002', 'IS401', 'Active'),
('1BI24IS009', 'IS401', 'Active'),
('1BI24IS009', 'IS402', 'Active'),

-- Sem 6
('1BI23IS003', 'IS601', 'Active'),
('1BI23IS003', 'IS602', 'Active'),

-- Sem 8
('1BI22IS004', 'IS801', 'Completed'),
('1BI22IS011', 'IS802', 'Active'),

-- ================= ECE =================

-- Sem 2
('1BI25EC001', 'EC201', 'Active'),
('1BI25EC008', 'EC201', 'Active'),
('1BI25EC008', 'EC202', 'Active'),

-- Sem 4
('1BI24EC003', 'EC401', 'Active'),
('1BI24EC010', 'EC401', 'Active');

SELECT COUNT(*) FROM Enrollment;

INSERT INTO Enrollment (usn, sub_code, status)
VALUES

-- ================= ECE =================

-- Sem 4
('1BI24EC010', 'EC402', 'Active'),

-- Sem 6
('1BI23EC004', 'EC601', 'Active'),
('1BI23EC004', 'EC602', 'Active'),

-- Sem 8
('1BI22EC005', 'EC801', 'Completed'),
('1BI22EC012', 'EC802', 'Active'),

-- ================= ME =================

-- Sem 2
('1BI25ME001', 'ME201', 'Active'),
('1BI25ME008', 'ME201', 'Active'),
('1BI25ME008', 'ME202', 'Active'),

-- Sem 4
('1BI24ME003', 'ME401', 'Active'),
('1BI24ME010', 'ME401', 'Active'),
('1BI24ME010', 'ME402', 'Dropped'),

-- Sem 6
('1BI23ME004', 'ME601', 'Active'),
('1BI23ME004', 'ME602', 'Active'),

-- Sem 8
('1BI22ME005', 'ME801', 'Active'),
('1BI22ME012', 'ME802', 'Active'),

-- ================= CE =================

-- Sem 2
('1BI25CE001', 'CE201', 'Active'),
('1BI25CE008', 'CE201', 'Active'),
('1BI25CE008', 'CE202', 'Active'),

-- Sem 4
('1BI24CE003', 'CE401', 'Active'),
('1BI24CE010', 'CE401', 'Active'),
('1BI24CE010', 'CE402', 'Dropped'),

-- Sem 6
('1BI23CE004', 'CE601', 'Active'),
('1BI23CE004', 'CE602', 'Active'),

-- Sem 8
('1BI22CE005', 'CE801', 'Active'),
('1BI22CE012', 'CE802', 'Active');

SELECT COUNT(*) AS Total_Enrollments
FROM Enrollment;

-- List of Students Department-wise
select * from student order by dept_id;

-- List of Student Semester-wise
select * from student order by sem;

-- Enrollments by status
select * from enrollment order by status;

-- Count of enrollment by status
SELECT status, COUNT(*) AS Count
FROM Enrollment
GROUP BY status;

-- Student + Subject details (JOIN)
SELECT
    s.usn,
    s.name,
    s.dept_id,
    s.sem,
    sub.sub_code,
    sub.sub_name,
    e.status
FROM Student s
JOIN Enrollment e
    ON s.usn = e.usn
JOIN Subject sub
    ON e.sub_code = sub.sub_code;
    
-- List of Students not enrolled
SELECT usn, name, dept_id, sem
FROM Student
WHERE usn NOT IN (
    SELECT DISTINCT usn
    FROM Enrollment
);

-- Professor-wise subjects
SELECT
    p.prof_name,
    s.sub_code,
    s.sub_name,
    s.sem,
    s.credits
FROM Professor p
JOIN Subject s
    ON p.prof_id = s.prof_id
ORDER BY p.prof_id;

-- View for student course registration details
CREATE VIEW Student_Enrollment_View AS
SELECT
    st.usn,
    st.name,
    st.dept_id,
    st.sem,
    sb.sub_code,
    sb.sub_name,
    e.status
FROM Enrollment e
JOIN Student st
    ON e.usn = st.usn
JOIN Subject sb
    ON e.sub_code = sb.sub_code;
    
SELECT * FROM Student_Enrollment_View;

-- Trigger
-- Objective :- To prevent a student from enrolling in the same subject twice.
DELIMITER $$

CREATE TRIGGER trg_prevent_duplicate_enrollment
BEFORE INSERT ON Enrollment
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Enrollment
        WHERE usn = NEW.usn
        AND sub_code = NEW.sub_code
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student is already enrolled in this subject';
    END IF;
END$$

DELIMITER ;

INSERT INTO Enrollment(usn, sub_code, status)
VALUES ('1BI24CS015', 'CS401', 'Active');

-- Stored Procedure to enroll a student in a subject
DELIMITER $$

CREATE PROCEDURE EnrollStudent(
    IN p_usn VARCHAR(20),
    IN p_sub_code VARCHAR(20)
)
BEGIN
    INSERT INTO Enrollment(usn, sub_code, status)
    VALUES (p_usn, p_sub_code, 'Active');
END$$

DELIMITER ;

-- Testing stored procedure
CALL EnrollStudent('1BI24CE016', 'CE401');

select * from Student where dept_id='CSE';

CALL EnrollStudent('1BI25CS014', 'CS202');

select * from enrollment where usn='1BI25CS014';