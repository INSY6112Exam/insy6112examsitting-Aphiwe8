CREATE SCHEMA IF NOT EXISTS Patients_st10493814;
USE Patients_st10493814;

-- Add drop table to prevent duplicates
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;

-- Q3.1

CREATE TABLE IF NOT EXISTS Patient (
Patient_id 				INT AUTO_INCREMENT NOT NULL,
PatientName 			VARCHAR(250) NOT NULL,
PatientSurname			VARCHAR(250) NOT NULL,
PatientDOB  			DATE NOT NULL,
PRIMARY KEY(Patient_id)
);

-- do not include id it will be auto created
-- Q 3.4 Patient table insert

INSERT INTO Patient (PatientName, PatientSurname, PatientDOB)
VALUES  ("Debbie", "Theart", "1980-03-17"),
		("Thomas", "Duncan", "1976-08-12");
        
SELECT* 
FROM Patient;

-- Q 3.2
CREATE TABLE IF NOT EXISTS Doctor (
Doctor_id 				INT AUTO_INCREMENT NOT NULL,
DoctorName 				VARCHAR(250) NOT NULL,
DoctorSurname			VARCHAR(250) NOT NULL,
PRIMARY KEY(Doctor_id)
);

-- Q 3.4 Doctor table insert
INSERT INTO Doctor (DoctorName, DoctorSurname)
VALUES  ("Zinhle", "Nukani"),
		("Ravi", "Maharaj");
        
Select*
FROM Doctor;

-- Q 3.3
-- drop the table because it had an inconstency and remake it 
DROP TABLE IF EXISTS Appointment;

CREATE TABLE IF NOT EXISTS Appointment (
    Appointment_id INT AUTO_INCREMENT NOT NULL,
    Patient_id INT NOT NULL,
    Doctor_id INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    AppointmentDuration INT NOT NULL,
    PRIMARY KEY (Appointment_id),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
);

-- Q 3.4 APPOINTMENT TABLE INSERT 
INSERT INTO Appointment (Patient_id, Doctor_id, AppointmentDate, AppointmentTime, AppointmentDuration)
VALUES  
    (1, 2, '2025-01-15', '09:00:00', 15),
    (2, 2, '2025-01-18', '15:00:00', 30),
    (1, 1, '2025-01-20', '10:00:00', 15),
    (1, 2, '2025-01-21', '11:00:00', 15);

SELECT * 
FROM Appointment;


-- Q 3.5
-- finding appointments during a specific time
SELECT*
FROM Appointment
WHERE AppointmentDate >= "2025-01-16" AND AppointmentDate <= "2025-01-20";



-- Q 3.6 using INNER JOIN
SELECT p.PatientName, p.PatientSurname,
    COUNT(a.Appointment_id) AS TotalAppointments
FROM Patient p
INNER JOIN Appointment a ON p.Patient_id = a.Patient_id
GROUP BY p.Patient_id, p.PatientName, p.PatientSurname
ORDER BY TotalAppointments DESC;

-- Q 3.8
-- creating a view showing Dr 2 patients
CREATE OR REPLACE VIEW PatientsWithDoctor2 AS
SELECT DISTINCT
    p.PatientName,
    p.PatientSurname
FROM Patient p
INNER JOIN Appointment a ON p.Patient_id = a.Patient_id
WHERE a.Doctor_id = 2
ORDER BY p.PatientSurname ASC;
 
SELECT * FROM PatientsWithDoctor2;


    