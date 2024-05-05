--Create Database
Create Database HealthCare_Appointment_Database;
go

--------------------------------------------------------------------------------------------
-- Creating tables

-- Creating the 'Patients' table
CREATE TABLE Patients (
    Patient_ID VARCHAR(20) PRIMARY KEY,
    Patient_Name NVARCHAR(100),
    Contact_info NVARCHAR(100),
    [Address] NVARCHAR(255)
    );
--------------------------------------------------------------------------------------------
    -- Creating the 'EHR' table
CREATE TABLE EHR (
    Record_ID VARCHAR(20) PRIMARY KEY,
    Patient_ID VARCHAR(20),
    Patient_Details TEXT,
    Generation_Date DATE,
    Medical_records BIT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Doctor' table
CREATE TABLE Doctor (
    Doctor_ID VARCHAR(20) PRIMARY KEY,
    Specialization_Name VARCHAR(255),
    [Availability] VARCHAR(255),
    Qualifications TEXT,
    Background TEXT
);
--------------------------------------------------------------------------------------------
-- Creating the 'Insurance' table
CREATE TABLE Insurance (
    Insurance_ID VARCHAR(20) PRIMARY KEY,
    Doctor_ID VARCHAR(20),
    Plan_Details TEXT,
    Premium DECIMAL(10, 2),
    Approval_Status VARCHAR(50),
    Out_of_pocket_maximum DECIMAL(10, 2),
    Carrier_Details VARCHAR(250),
    FOREIGN KEY(Doctor_ID) REFERENCES Doctor(Doctor_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Services' table
CREATE TABLE Services (
    Service_ID VARCHAR(20) PRIMARY KEY,
    Service_Type VARCHAR(255),
    Details TEXT
);
--------------------------------------------------------------------------------------------
-- Creating the 'Staff' table
CREATE TABLE Staff (
    Staff_ID VARCHAR(20) PRIMARY KEY,
    Staff_name VARCHAR(255),
    Contact_details VARCHAR(255),
    Staff_type VARCHAR(255),
    [Role] TEXT
);
--------------------------------------------------------------------------------------------
-- Creating the 'Practice_Location' table
CREATE TABLE Practice_Location (
    Location_ID VARCHAR(20) PRIMARY KEY,
    Practice_name VARCHAR(255),
    [Address] TEXT,
    Operating_hours TEXT
);
--------------------------------------------------------------------------------------------
-- Creating the 'Appointment' table
CREATE TABLE Appointment (
    Appointment_ID VARCHAR(20) PRIMARY KEY,
    Patient_ID VARCHAR(20),
    Doctor_ID VARCHAR(20),
    Date_Time DATETIME,
    [Status] VARCHAR(255),
    Details TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);
--------------------------------------------------------------------------------------------
--Tables for VIRTUAL subtype
CREATE TABLE Virtual(
    Appointment_ID VARCHAR(20) PRIMARY KEY,
    Call_Type VARCHAR(255),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
    );
--------------------------------------------------------------------------------------------
--Tables for IN PERSON subtype
CREATE TABLE In_Person(
    Appointment_ID VARCHAR(20) PRIMARY KEY,
    Waiting_Time INT,
    Location_ID VARCHAR(20),
    FOREIGN KEY (Location_ID) REFERENCES [Practice_Location](Location_ID)
    );

--------------------------------------------------------------------------------------------
-- Creating the 'Appointment_Service' junction table to handle the many-to-many relationship between Appointments and Services
CREATE TABLE Appointment_Service (
    Appointment_ID VARCHAR(20),
    Service_ID VARCHAR(20),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID),
    PRIMARY KEY (Appointment_ID, Service_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Billing' table
CREATE TABLE Billing (
    Receipt_ID VARCHAR(20) PRIMARY KEY,
    Patient_ID VARCHAR(20),
    Insurance_ID VARCHAR(20),
    Invoice_Number VARCHAR(255),
    Transaction_Status VARCHAR(255),
    [Date] DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Insurance_ID) REFERENCES Insurance(Insurance_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Scope_of_Treatment' table
CREATE TABLE Scope_of_Treatment (
    Treatment_ID VARCHAR(20) PRIMARY KEY,
    Medical_specialty VARCHAR(255),
    Treatment_Name VARCHAR(255),
    Treatment_Type VARCHAR(255)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Scope_Doctor' table as a JUNCTION for associative entity
CREATE TABLE Scope_Doctor(
Doctor_ID VARCHAR(20),
Treatment_ID VARCHAR(20),
FOREIGN KEY(Doctor_ID) REFERENCES Doctor(Doctor_ID),
FOREIGN KEY(Treatment_ID) REFERENCES Scope_of_Treatment(Treatment_ID),
PRIMARY KEY (Doctor_ID,Treatment_ID)
);

--------------------------------------------------------------------------------------------
-- Creating the 'Staff_Location' junction table to handle the many-to-many relationship between Staff and Practice_Location
CREATE TABLE Staff_Location (
    Staff_ID VARCHAR(20),
    Location_ID VARCHAR(20),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Location_ID) REFERENCES Practice_Location(Location_ID),
    PRIMARY KEY (Staff_ID, Location_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Notification' table
CREATE TABLE Notification (
    Notification_No VARCHAR(20) PRIMARY KEY,
    Appointment_ID VARCHAR(20),
    Notification_Type VARCHAR(255),
    Date_and_time DATETIME,
    Urgency_Level VARCHAR(255),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);
--------------------------------------------------------------------------------------------
-- Creating the 'Analytics_and_Reports' table
CREATE TABLE Analytics_and_Reports (
    Report_ID VARCHAR(20) PRIMARY KEY,
    Report_Type VARCHAR(255),
    [Data_source] VARCHAR(255),
    Report_Details TEXT
)

GO 
--------------------------------------------------------------------------------------------
--Stored Procedure1:Retrieves the patient details on entering the Patient's ID 


CREATE PROCEDURE GetPatientDetailsByID
    @Input_Patient_ID VARCHAR(20),
    @Output_Patient_Name NVARCHAR(100) OUTPUT,
    @Output_Contact_Info NVARCHAR(100) OUTPUT,
    @Output_Address NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    -- Assuming the Patient_ID is unique
    SELECT 
        @Output_Patient_Name = Patient_Name,
        @Output_Contact_Info = Contact_info,
        @Output_Address = [Address]
    FROM Patients
    WHERE Patient_ID = @Input_Patient_ID;
END;


-- Declare variables to store the output values
DECLARE @PatientName NVARCHAR(100),
        @ContactInfo NVARCHAR(100),
        @PatientAddress NVARCHAR(255);

-- Execute the stored procedure for a specific patient ID
EXEC GetPatientDetailsByID
    @Input_Patient_ID = 'P1', -- Replace with the actual patient ID
    @Output_Patient_Name = @PatientName OUTPUT,
    @Output_Contact_Info = @ContactInfo OUTPUT,
    @Output_Address = @PatientAddress OUTPUT;

-- Select the variables to view the output
SELECT @PatientName AS PatientName, 
       @ContactInfo AS ContactInfo, 
       @PatientAddress AS Address;

	   GO

--------------------------------------------------------------------------------------------
--Stored Procedure2: Allows altering of Patient's Information on providing the patients id	   

CREATE PROCEDURE UpdatePatientDetails
    @Patient_ID VARCHAR(20),
    @New_Contact_Info NVARCHAR(100),
    @New_Address NVARCHAR(255),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    UPDATE Patients
    SET Contact_info = @New_Contact_Info,
        Address = @New_Address
    WHERE Patient_ID = @Patient_ID;
    
    IF @@ROWCOUNT = 1
        SET @ResultMessage = 'Patient details updated successfully.';
    ELSE
        SET @ResultMessage = 'Update failed: Patient ID not found.';
END;

-- Declare variables for the input parameters and for capturing the output message
DECLARE @OutputMessage NVARCHAR(255);

-- Set your input parameters with actual values
DECLARE @InputPatientID VARCHAR(20) = 'P6'; -- Replace with actual patient ID
DECLARE @InputNewContactInfo NVARCHAR(100) = 'chandler@example.com'; -- Replace with new contact info
DECLARE @InputNewAddress NVARCHAR(255) = '365, Newsberry street, Boston'; -- Replace with new address

-- Execute the stored procedure with input parameters and capture the output message
EXEC UpdatePatientDetails
    @Patient_ID = @InputPatientID,
    @New_Contact_Info = @InputNewContactInfo,
    @New_Address = @InputNewAddress,
    @ResultMessage = @OutputMessage OUTPUT;

-- Display the result message
SELECT @OutputMessage AS OutputMessage;

GO 
--------------------------------------------------------------------------------------------
--Stored Procedure3: Retrieves Appointment Details on providing the patient id 

CREATE PROCEDURE GetAppointmentDetails
    @Appointment_ID VARCHAR(20)
AS
BEGIN
    SELECT 
        ap.Appointment_ID,
        ap.Date_Time,
        ap.Status,
        ap.Details,
        p.Patient_Name,
        p.Contact_info AS Patient_Contact,
        p.[Address] AS Patient_Address,
        d.Doctor_ID,
        d.Specialization_Name,
        d.[Availability],
        d.Qualifications
    FROM 
        Appointment ap
    INNER JOIN 
        Patients p ON ap.Patient_ID = p.Patient_ID
    INNER JOIN 
        Doctor d ON ap.Doctor_ID = d.Doctor_ID
    WHERE 
        ap.Appointment_ID = @Appointment_ID;
END;


EXEC GetAppointmentDetails @Appointment_ID = 'AP2'; -- Replace 'AP1' with a valid Appointment_ID
GO

--------------------------------------------------------------------------------------------
--Stored Procedure 4: Creates an Appointment after all the relevant details are entered.

CREATE PROCEDURE CreateAppointment
    @Input_Appointment_ID VARCHAR(20),
    @Input_Patient_ID VARCHAR(20),
    @Input_Doctor_ID VARCHAR(20),
    @Input_Date_Time DATETIME,
    @Input_Status VARCHAR(255),
    @Input_Details NVARCHAR(255),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    -- Check if the Patient_ID exists in the Patients table
    IF NOT EXISTS (SELECT 1 FROM Patients WHERE Patient_ID = @Input_Patient_ID)
    BEGIN
        SET @ResultMessage = 'Patient does not exist in our database';
        RETURN;
    END

    -- Check if the Doctor_ID exists in the Doctor table
    IF NOT EXISTS (SELECT 1 FROM Doctor WHERE Doctor_ID = @Input_Doctor_ID)
    BEGIN
        SET @ResultMessage = 'Doctor does not exist in our database';
        RETURN;
    END

    -- Check if the appointment time is already taken with the status 'Scheduled'
    IF EXISTS (SELECT 1 FROM Appointment
               WHERE Doctor_ID = @Input_Doctor_ID
               AND Date_Time = @Input_Date_Time
               AND Status = 'Scheduled')
    BEGIN
        SET @ResultMessage = 'The appointment time is already taken';
        RETURN;
    END

    -- Check if the Appointment_ID is unique
    IF EXISTS (SELECT 1 FROM Appointment WHERE Appointment_ID = @Input_Appointment_ID)
    BEGIN
        SET @ResultMessage = 'The Appointment ID already exists, it must be unique';
        RETURN;
    END

    -- Insert the new appointment
    INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Date_Time, Status, Details)
    VALUES (@Input_Appointment_ID, @Input_Patient_ID, @Input_Doctor_ID, @Input_Date_Time, @Input_Status, @Input_Details);

    -- If insert is successful, set the result message
    SET @ResultMessage = 'Appointment created successfully';
END;

DECLARE @ResultMsg NVARCHAR(255);

EXEC CreateAppointment
    @Input_Appointment_ID = 'AP10', -- Make sure this is unique
    @Input_Patient_ID = 'P1',      -- Existing patient ID
    @Input_Doctor_ID = 'D5',       -- Existing doctor ID
    @Input_Date_Time = '2024-12-20 09:00:00.000',  -- Desired date and time
    @Input_Status = 'Scheduled',               -- Appointment status
    @Input_Details = 'Checkup and consultation', -- Appointment details
    @ResultMessage = @ResultMsg OUTPUT;

SELECT @ResultMsg AS Message; -- Displays the result message

DELETE FROM Appointment
WHERE Appointment_ID = 'A10';

--------------------------------------------------------------------------------------------
-- View:1 gives an idea about the profile of the paitent without exposing any medical records
GO

CREATE VIEW Patient_Profile AS
SELECT
    p.Patient_ID,
    p.Patient_Name, 
    COUNT(a.Appointment_ID) AS TotalAppointments,
    SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS CompletedAppointments,
    d.Specialization_Name,
    i.Approval_Status,
	b.Transaction_Status
FROM
    Patients p
JOIN Appointment a ON p.Patient_ID = a.Patient_ID
JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
JOIN Insurance i ON d.Doctor_ID = i.Doctor_ID 
JOIN Billing b ON p.Patient_ID = b.Patient_ID
GROUP BY
    p.Patient_ID, p.Patient_Name, d.Specialization_Name, i.Approval_Status,b.Transaction_Status;
GO
SELECT * FROM Patient_Profile;


--------------------------------------------------------------------------------------------
GO
--View2: Overview about the particular appointment of the patient
CREATE VIEW PatientVisitSummary AS
SELECT
    p.Patient_Name,
    p.Contact_info,
    a.Date_Time AS Appointment_Date,
    a.Status AS Appointment_Status,
    d.Doctor_ID,
    d.Specialization_Name AS Doctor_Specialization,
    STRING_AGG(s.Service_Type, ', ') AS Services_Provided, -- Aggregates all services provided in the appointment
    i.Premium,
    i.Approval_Status AS Insurance_Status
FROM
    Appointment a
JOIN
    Patients p ON a.Patient_ID = p.Patient_ID
JOIN
    Doctor d ON a.Doctor_ID = d.Doctor_ID
LEFT JOIN
    Appointment_Service asv ON a.Appointment_ID = asv.Appointment_ID
LEFT JOIN
    Services s ON asv.Service_ID = s.Service_ID
LEFT JOIN
    Billing b ON p.Patient_ID = b.Patient_ID
LEFT JOIN
    Insurance i ON b.Insurance_ID = i.Insurance_ID
GROUP BY
    p.Patient_Name,
    p.Contact_info,
    a.Date_Time,
    a.Status,
    d.Doctor_ID,
    d.Specialization_Name,
    i.Premium,
    i.Approval_Status
GO

SELECT * FROM PatientVisitSummary
ORDER BY Appointment_Date DESC;

--------------------------------------------------------------------------------------------
-- View3: provides a history of the doctor and his appointments
GO

CREATE VIEW Doctor_PR AS
SELECT
    d.Doctor_ID,
    d.Specialization_Name,
	d.[Availability],
 -- we are making an overview to understand the doctors load based on no of patients he handled
    SUM(CASE WHEN a.[Status] = 'Completed' THEN 1 ELSE 0 END)
	AS CompletedAppointments,
    SUM(CASE WHEN a.[Status] = 'Scheduled' THEN 1 ELSE 0 END)
	AS ScheduledAppointments,
    SUM(CASE WHEN a.[Status] = 'Cancelled' THEN 1 ELSE 0 END)
	AS CancelledAppointments
FROM
    Doctor d
LEFT JOIN Appointment a ON d.Doctor_ID = a.Doctor_ID
GROUP BY
    d.Doctor_ID, d.Specialization_Name,d.[Availability];
GO
SELECT * FROM Doctor_PR;

--------------------------------------------------------------------------------------------

-- Trigger1: Create an audit table to store changes made to the Patients table
GO
CREATE TABLE PatientsAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Patient_ID VARCHAR(20),
    Patient_Name NVARCHAR(100),
    Contact_info NVARCHAR(100),
    [Address] NVARCHAR(255),
    [Action]  NVARCHAR(10), 
    [actiondate]     DATE DEFAULT GETDATE()
);
GO

-- Create or alter a trigger that audits inserts and updates on the Patients table
CREATE OR ALTER TRIGGER trg_Patients_Audit
ON Patients
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PatientsAudit (Patient_ID, Patient_Name, Contact_info, [Address], [Action])
        SELECT i.Patient_ID, i.Patient_Name, i.Contact_info, i.[Address], 'Update'
        FROM inserted i
        JOIN deleted d ON i.Patient_ID = d.Patient_ID;
    END
    ELSE 
    BEGIN
        INSERT INTO PatientsAudit (Patient_ID, Patient_Name, Contact_info, [Address], [Action])
        SELECT Patient_ID, Patient_Name, Contact_info, [Address], 'Insert'
        FROM inserted;
    END
END;
GO


--Query to check the trigger

INSERT INTO Patients (Patient_ID, Patient_Name, Contact_Info, Address) VALUES 
('P9_test', 'Gold Berg', 'goldberg@example.com', '691 Parker Street')

SELECT * from PatientsAudit;

--------------------------------------------------------------------------------------------

--Trigger2: Create an audit table to store changes made to the Doctor table
Go
CREATE TABLE DoctorAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Doctor_ID VARCHAR(20),
    Specialization_Name VARCHAR(255),
    [Availability] VARCHAR(255),   
    [Action] NVARCHAR(10), 
    [ActionDate] DATE DEFAULT GETDATE()
);
GO

-- Create or alter a trigger that audits inserts and updates on the Doctor table
CREATE OR ALTER TRIGGER trg_Doctor_Audit
ON Doctor
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON; 

    
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO DoctorAudit (Doctor_ID, Specialization_Name, [Availability], [Action])
        SELECT i.Doctor_ID, i.Specialization_Name, i.[Availability], 'Update'
        FROM inserted i
        JOIN deleted d ON i.Doctor_ID = d.Doctor_ID;
    END
    ELSE 
    BEGIN
        INSERT INTO DoctorAudit (Doctor_ID, Specialization_Name, [Availability], [Action])
        SELECT Doctor_ID, Specialization_Name, [Availability], 'Insert'
        FROM inserted;
    END
END;
GO


--Query to check the trigger
update Doctor
set Specialization_Name = 'Immunology'
WHERE Doctor_ID= 'D0'

select * from DoctorAudit;

--------------------------------------------------------------------------------------------

-- CREATING CHECK CONSTRAINTS
-- CHECK Constraint1: Adding a CHECK constraint on 'Appointment.Status'
ALTER TABLE Appointment
ADD CONSTRAINT CHK_Appointment_Status CHECK ([Status] IN ('Scheduled', 'Completed', 'Cancelled'));
--------------------------------------------------------------------------------------------
-- CHECK Constraint2: Adding a CHECK constraint on 'EHR.Medical_records'
ALTER TABLE EHR
ADD CONSTRAINT CHK_EHR_Medical_records CHECK (Medical_records IN (0, 1));
--------------------------------------------------------------------------------------------
-- CHECK Constraint3:Adding a CHECK constraint on 'Billing.Transaction_Status'
ALTER TABLE Billing
ADD CONSTRAINT CHK_Billing_Transaction_Status CHECK (Transaction_Status IN ('Paid', 'Pending','Canceled'));
--------------------------------------------------------------------------------------------
-- CHECK Constraint4: Adding a CHECK constraint on 'Notification.Urgency_Level'
ALTER TABLE Notification
ADD CONSTRAINT CHK_Notification_Urgency_Level CHECK (Urgency_Level IN ('Low', 'Medium', 'High'));

--------------------------------------------------------------------------------------------

--User Defined Function1: Creating a function that concatenates the appointment ID with its status
Go
CREATE FUNCTION dbo.Appoint_status
(
    @Appointment NVARCHAR(50),
    @Status NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @Appointment + '-' + @Status
END

go

-- Alter the Appointment table to add a new computed column that uses the Appoint_status UDF

ALTER TABLE Appointment
ADD Appointment_Status AS dbo.Appoint_status(Appointment_ID, [Status])

select * FROM Appointment;

--------------------------------------------------------------------------------------------

--User Defined Function2: calculate the days past since the invoice was issued
GO

CREATE FUNCTION dbo.DaysSinceInvoiceIssued
(
    @InvoiceDate DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @InvoiceDate, GETDATE());
END;


go

-- Alter the Billing table to add a new computed column
ALTER TABLE Billing
ADD Days_Since_Invoice_Issued AS dbo.DaysSinceInvoiceIssued([Date]);

select * from Billing;

--------------------------------------------------------------------------------------------
--Column Data Encryption

GO

-- Create Master Key
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Gr14yd26';
GO

-- Create Certificate
CREATE CERTIFICATE OHABP_Cert WITH SUBJECT = 'OHABP Data Encryption';
GO

-- Create Symmetric Key using the certificate for encryption protection
CREATE SYMMETRIC KEY OHABP_Key WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE OHABP_Cert;
GO

ALTER TABLE Staff ADD Encrypted_Contact_details VARBINARY(MAX);
GO


-- Open the Symmetric Key for use
OPEN SYMMETRIC KEY OHABP_Key DECRYPTION BY CERTIFICATE OHABP_Cert;

-- Encrypt the Contact_details data and store it in the Encrypted_Contact_Details column
UPDATE Staff
SET Encrypted_Contact_details = EncryptByKey(Key_GUID('OHABP_Key'), Contact_details);

-- Close the Symmetric Key after use
CLOSE SYMMETRIC KEY OHABP_Key;
GO

-- Remove the original columns
ALTER TABLE Staff
DROP COLUMN Contact_details;

-- Rename the Encrypted_Contact_details column to Contact_details
EXEC sp_rename 'Staff.Encrypted_Contact_details', 'Contact_details', 'COLUMN';

select * from Staff;

--decryption

-- Open the Symmetric Key for decryption
OPEN SYMMETRIC KEY OHABP_Key DECRYPTION BY CERTIFICATE OHABP_Cert;

-- Select and decrypt the Contact_details column
SELECT Staff_ID, Staff_name, Staff_type, [Role],
       CONVERT(VARCHAR(MAX), DECRYPTBYKEY(Contact_details)) AS Decrypted_Contact_details
FROM Staff;

-- Close the Symmetric Key after use
CLOSE SYMMETRIC KEY OHABP_Key;

--------------------------------------------------------------------------------------------

--CREATING NON CLUSTERED INDEXES

--Non-clustered Index1: Index on the Doctor.Availability column
CREATE NONCLUSTERED INDEX idx_Doctor_Availability ON Doctor([Availability]);

--A query to find all doctors available on Eg.-'Mondays and Wednesdays, 9am-3pm':
SELECT * FROM Doctor WHERE Availability = 'Mondays and Wednesdays, 9am-3pm';

--------------------------------------------------------------------------------------------
--Non-clustered Index2: Index on the Appointment.Date_Time column
CREATE NONCLUSTERED INDEX idx_Appointment_DateTime ON Appointment(Date_Time);

--A query to find all appointments scheduled for a specific date Eg.-'2024-04-20':
SELECT * FROM Appointment WHERE CAST(Date_Time AS DATE) = '2024-04-20';

--------------------------------------------------------------------------------------------
-- Non-clustered Index3: Index on the Insurance.Approval_Status column
CREATE NONCLUSTERED INDEX idx_Insurance_ApprovalStatus ON Insurance(Approval_Status);

--A query to get all insurance plans that are currently approved:
SELECT * FROM Insurance WHERE Approval_Status = 'Approved';

--------------------------------------------------------------------------------------------
-- Non-clustered Index4:Index on the Billing.Transaction_Status column
CREATE NONCLUSTERED INDEX idx_Billing_TransactionStatus ON Billing(Transaction_Status);

-- Query to find all transactions that are pending
SELECT * FROM Billing WHERE Transaction_Status = 'Pending';
