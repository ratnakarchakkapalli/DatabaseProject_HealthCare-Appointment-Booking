Use HealthCare_Appointment_Database;
go

--------------------------------------------------------------------------------------------
-- Inserting data into 'Patients' table 
INSERT INTO Patients (Patient_ID, Patient_Name, Contact_Info, Address) VALUES 
('P0', 'John Doe', 'johndoe@example.com', '123 Maple Drive'),
('P1', 'Jane Smith', 'janesmith@example.com', '456 Oak Lane'),
('P2', 'Alice Johnson', 'alicejohnson@example.com', '789 Pine Street'),
('P3', 'Michael Brown', 'michaelbrown@example.com', '321 Cedar Blvd'),
('P4', 'Rachel Green', 'rachelgreen@example.com', '654 Spruce Road'),
('P5', 'Joey Tribbiani', 'joeytribbiani@example.com', '987 Walnut Avenue'),
('P6', 'Chandler Bing', 'chandlerbing@example.com', '213 Birch Street'),
('P7', 'Ross Geller', 'rossgeller@example.com', '132 Elm Street'),
('P8', 'Monica Geller', 'monicageller@example.com', '768 Maple Avenue'),
('P9', 'Phoebe Buffay', 'phoebebuffay@example.com', '456 Oak Drive');
GO

 -- Inserting data into 'EHR' table with custom Record_ID and Patient_ID values
INSERT INTO EHR (Record_ID, Patient_ID, Patient_Details, Generation_Date, Medical_records) VALUES
('R0', 'P0', 'Patient history and previous diagnoses.', '2024-01-01', 1),
('R1', 'P1', 'Patient allergies and current medication list.', '2024-01-02', 1),
('R2', 'P2', 'Summary of patient surgical history.', '2024-01-03', 1),
('R3', 'P3', 'Patient family medical history.', '2024-01-04', 0),
('R4', 'P4', 'Records of patient immunizations.', '2024-01-05', 1),
('R5', 'P5', 'Detailed patient visit notes for the last year.', '2024-01-06', 0),
('R6', 'P6', 'Lab results and radiology images.', '2024-01-07', 1),
('R7', 'P7', 'Records of chronic conditions and management plans.', '2024-01-08', 1),
('R8', 'P8', 'Emergency contact information and advance directives.', '2024-01-09', 0),
('R9', 'P9', 'Prescription records and dosages.', '2024-01-10', 1);
GO
--------------------------------------------------------------------------------------------
 -- Inserting data into 'Doctor' table with custom Doctor_ID values
INSERT INTO Doctor (Doctor_ID, Specialization_Name, [Availability], Qualifications, Background) VALUES
('D0', 'Cardiology', 'Mondays and Wednesdays, 9am-3pm', 'MD from XYZ University, 5 years of residency', 'Over 10 years of experience in cardiology'),
('D1', 'Pediatrics', 'Weekdays, 8am-4pm', 'MD from ABC Medical School, Specialization in Pediatrics', 'Has worked in pediatric care for over 7 years'),
('D2', 'Dermatology', 'Tuesday and Thursday, 10am-4pm', 'MD Dermatology, Board Certified', 'Special interest in dermatological research'),
('D3', 'Neurology', 'Monday to Friday, 1pm-5pm', 'PhD in Neuroscience, MD', '15 years of experience in neurological surgery'),
('D4', 'Orthopedics', 'Mondays, Wednesdays, and Fridays, 8am-2pm', 'MD Orthopedics, 10 years of residency', 'Expert in sports injuries and joint replacement'),
('D5', 'General Practice', 'Weekdays, 9am-5pm', 'MD General Medicine', '20 years serving in a family practice'),
('D6', 'Oncology', 'Weekdays, 10am-4pm', 'MD Oncology, Specialized in chemotherapy', 'Dedicated to cancer treatment and research for 12 years'),
('D7', 'Anesthesiology', 'On-call', 'MD Anesthesiology', 'Experience with all types of surgical procedures'),
('D8', 'Psychiatry', 'Tuesdays and Thursdays, 10am-3pm', 'MD Psychiatry', 'Focus on adult and adolescent psychiatry'),
('D9', 'Gastroenterology', 'Mondays and Fridays, 9am-1pm', 'MD Gastroenterology', 'Research in digestive disorders');
GO
--------------------------------------------------------------------------------------------
 -- Inserting data into 'Insurance' table 
INSERT INTO Insurance (Insurance_ID, Plan_Details, Premium, Approval_Status, Out_of_pocket_maximum, Carrier_Details, Doctor_ID) VALUES
('I0', 'Basic Health Coverage', 100.00, 'Approved', 500.00, 'Carrier A', 'D0'),
('I1', 'Comprehensive Health Plan', 150.00, 'Pending', 1000.00, 'Carrier B', 'D1'),
('I2', 'Premium Health Plan', 200.00, 'Approved', 1500.00, 'Carrier C', 'D2'),
('I3', 'Family Health Plan', 180.00, 'Approved', 1200.00, 'Carrier D', 'D3'),
('I4', 'Individual Health Plan', 120.00, 'Pending', 600.00, 'Carrier E', 'D4'),
('I5', 'Dental Care Plan', 80.00, 'Approved', 300.00, 'Carrier F', 'D5'),
('I6', 'Vision Care Plan', 75.00, 'Approved', 250.00, 'Carrier G', 'D6'),
('I7', 'Emergency Health Plan', 250.00, 'Pending', 2000.00, 'Carrier H', 'D7'),
('I8', 'Senior Health Plan', 130.00, 'Approved', 700.00, 'Carrier I', 'D8'),
('I9', 'Child Health Plan', 90.00, 'Approved', 400.00, 'Carrier J', 'D9');
GO
--------------------------------------------------------------------------------------------
 -- Inserting data into 'Services' table with custom Service_ID values
INSERT INTO Services (Service_ID, Service_Type, Details) VALUES
('S0', 'General Consultation', 'A general health check-up and consultation.'),
('S1', 'Pediatric Care', 'Health services focused on the physical, mental, and social health of infants, children, and adolescents.'),
('S2', 'Cardiology', 'Heart and blood vessels related treatments and consultations.'),
('S3', 'Dermatology', 'Skin, hair, nails, and related diseases treatments.'),
('S4', 'Orthopedics', 'Diagnosis and treatment of disorders of the bones, joints, ligaments, tendons, muscles, and nerves.'),
('S5', 'Dentistry', 'Diagnostics, prevention, and treatment of diseases and conditions of the oral cavity.'),
('S6', 'Neurology', 'Treatment of disorders that affect the brain, spinal cord, and nerves.'),
('S7', 'Gastroenterology', 'Focus on the digestive system and its disorders.'),
('S8', 'Ophthalmology', 'Diagnosis and treatment of eye disorders.'),
('S9', 'Psychiatry', 'Medical specialty devoted to the diagnosis, prevention, study, and treatment of mental disorders.');
GO
-------------------------------------------------------------------------------------------- 
 -- Inserting data into 'Staff' table with custom Staff_ID values
INSERT INTO Staff (Staff_ID, Staff_name, Contact_details, Staff_type, [Role]) VALUES
('SF0', 'Alex Smith', 'alex.smith@example.com', 'Nurse', 'Responsible for patient care'),
('SF1', 'Maria Garcia', 'maria.garcia@example.com', 'Receptionist', 'Handles patient appointments and inquiries'),
('SF2', 'James Johnson', 'james.johnson@example.com', 'Technician', 'Operates medical equipment'),
('SF3', 'Emma Martinez', 'emma.martinez@example.com', 'Pharmacist', 'Manages medication distribution'),
('SF4', 'Michael Brown', 'michael.brown@example.com', 'Surgeon', 'Performs surgeries and operations'),
('SF5', 'Sophia Wilson', 'sophia.wilson@example.com', 'Therapist', 'Provides therapy and rehabilitation'),
('SF6', 'Isabella Davis', 'isabella.davis@example.com', 'Nurse', 'Assists doctors and cares for patients'),
('SF7', 'Ethan Miller', 'ethan.miller@example.com', 'Administrator', 'Oversees clinic operations'),
('SF8', 'Olivia Perez', 'olivia.perez@example.com', 'Lab Technician', 'Conducts lab tests and analysis'),
('SF9', 'William Rodriguez', 'william.rodriguez@example.com', 'Maintenance', 'Ensures medical equipment is operational');
GO
--------------------------------------------------------------------------------------------
 -- Inserting data into 'Practice_Location' table with custom Location_ID values
INSERT INTO Practice_Location (Location_ID, Practice_name, [Address], Operating_hours) VALUES
('L0', 'Main Street Clinic', '123 Main St, Townsville', '8:00 AM - 6:00 PM'),
('L1', 'Downtown Health Center', '456 Center St, Metropolis', '9:00 AM - 5:00 PM'),
('L2', 'Suburb Wellness Facility', '789 Suburb Rd, Springfield', '7:00 AM - 3:00 PM'),
('L3', 'Riverside Medical Practice', '101 River St, River City', '8:00 AM - 4:00 PM'),
('L4', 'Eastside Family Health', '202 East St, Eastville', '10:00 AM - 8:00 PM'),
('L5', 'Westend Community Care', '303 West Ave, Westtown', '24 Hours'),
('L6', 'Northpoint Pediatrics', '404 North St, Northberg', '8:00 AM - 6:00 PM'),
('L7', 'Southgate Specialists', '505 South Rd, Southgate', '9:00 AM - 5:00 PM'),
('L8', 'Hilltop General Hospital', '606 Hill St, Hilltop', 'Open 24 Hours'),
('L9', 'Lakeside Therapy Center', '707 Lake St, Lakeside', '8:00 AM - 8:00 PM');
GO
--------------------------------------------------------------------------------------------
-- Inserting data into 'Billing' table with custom ID values
INSERT INTO Billing (Receipt_ID, Patient_ID, Insurance_ID, Invoice_Number, Transaction_Status, [Date]) VALUES
('R0', 'P0', 'I0', 'INV0001', 'Paid', '2024-01-01'),
('R1', 'P1', 'I1', 'INV0002', 'Pending', '2024-01-02'),
('R2', 'P2', 'I2', 'INV0003', 'Paid', '2024-01-03'),
('R3', 'P3', 'I3', 'INV0004', 'Pending', '2024-01-04'),
('R4', 'P4', 'I4', 'INV0005', 'Paid', '2024-01-05'),
('R5', 'P5', 'I5', 'INV0006', 'Pending', '2024-01-06'),
('R6', 'P6', 'I6', 'INV0007', 'Paid', '2024-01-07'),
('R7', 'P7', 'I7', 'INV0008', 'Pending', '2024-01-08'),
('R8', 'P8', 'I8', 'INV0009', 'Paid', '2024-01-09'),
('R9', 'P9', 'I9', 'INV0010', 'Pending', '2024-01-10');
GO
--------------------------------------------------------------------------------------------
-- Inserting data into 'Scope_of_Treatment' table with custom Treatment_ID values
INSERT INTO Scope_of_Treatment (Treatment_ID, Medical_specialty, Treatment_Name, Treatment_Type) VALUES
('TE0', 'Cardiology', 'Echocardiogram', 'Diagnostic Test'),
('TE1', 'Orthopedics', 'Knee Replacement', 'Surgical Procedure'),
('TE2', 'Dermatology', 'Acne Treatment', 'Outpatient Care'),
('TE3', 'Pediatrics', 'Routine Vaccination', 'Preventive Care'),
('TE4', 'Neurology', 'EEG', 'Diagnostic Test'),
('TE5', 'General Medicine', 'Health Screening', 'Preventive Care'),
('TE6', 'Oncology', 'Chemotherapy', 'Treatment'),
('TE7', 'Gastroenterology', 'Colonoscopy', 'Diagnostic Test'),
('TE8', 'Psychiatry', 'Cognitive Behavioral Therapy', 'Therapy'),
('TE9', 'Endocrinology', 'Diabetes Management Program', 'Treatment');
GO
--------------------------------------------------------------------------------------------
 -- Inserting data into 'Scope_Doctor' table 
INSERT INTO Scope_Doctor (Doctor_ID, Treatment_ID) VALUES
('D0', 'TE0'),
('D1', 'TE1'),
('D2', 'TE2'),
('D3', 'TE3'),
('D4', 'TE4'),
('D5', 'TE5'),
('D6', 'TE6'),
('D7', 'TE7'),
('D8', 'TE8'),
('D9', 'TE9');
GO
--------------------------------------------------------------------------------------------
-- Inserting data into 'Appointment' table with custom Appointment_ID values
INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Date_Time, [Status], Details) VALUES
('AP0', 'P0', 'D0', '2024-04-20 09:00:00', 'Scheduled', 'Annual check-up'),
('AP1', 'P1', 'D1', '2024-04-20 10:00:00', 'Scheduled', 'Routine dental cleaning'),
('AP2', 'P2', 'D2', '2024-04-21 11:00:00', 'Scheduled', 'Consultation for skin rash'),
('AP3', 'P3', 'D3', '2024-04-21 13:00:00', 'Cancelled', 'Neurological exam'),
('AP4', 'P4', 'D4', '2024-04-22 14:00:00', 'Completed', 'Orthopedic surgery follow-up'),
('AP5', 'P5', 'D5', '2024-04-22 15:00:00', 'Scheduled', 'Physical therapy session'),
('AP6', 'P6', 'D6', '2024-04-23 09:00:00', 'Scheduled', 'Regular check-up for medication review'),
('AP7', 'P7', 'D7', '2024-04-23 10:00:00', 'Scheduled', 'Emergency appointment for acute back pain'),
('AP8', 'P8', 'D8', '2024-04-24 11:00:00', 'Completed', 'Annual eye exam'),
('AP9', 'P9', 'D9', '2024-04-24 13:00:00', 'Scheduled', 'Consultation for anxiety and stress management');
GO
--------------------------------------------------------------------------------------------
-- Inserting data into 'Analytics_and_Reports' table
INSERT INTO Analytics_and_Reports (Report_ID, Report_Type, Data_source, Report_Details) VALUES
('AR0', 'Patient Satisfaction Survey', 'Internal', 'Summary of patient satisfaction survey for Q1 2024.'),
('AR1', 'Monthly Revenue Report', 'Financial System', 'Detailed revenue report for March 2024.'),
('AR2', 'Appointment No-show Analysis', 'Appointment System', 'Analysis of no-show rates by department for April 2024.'),
('AR3', 'Annual Health Outcomes', 'Patient Records', 'Overview of health outcomes and improvements for the year 2023.'),
('AR4', 'Drug Prescription Trends', 'Pharmacy System', 'Trends in drug prescriptions for Q1 2024 with a focus on antibiotics.'),
('AR5', 'Staff Performance Review', 'HR System', 'Quarterly performance review of medical staff for Q1 2024.'),
('AR6', 'Patient Demographics Report', 'Patient Records', 'Analysis of patient demographics for the first half of 2024.'),
('AR7', 'Equipment Utilization Report', 'Operational', 'Report on medical equipment utilization rates for Q2 2024.'),
('AR8', 'Healthcare Service Usage', 'Appointment System', 'Statistical report on healthcare services usage by patients in Q2 2024.'),
('AR9', 'Insurance Claim Analysis', 'Financial System', 'Detailed analysis of insurance claims processed in Q2 2024.');
GO
--------------------------------------------------------------------------------------------
-- Inserting data into 'Notification' table
INSERT INTO Notification (Notification_No, Appointment_ID, Notification_Type, Date_and_time, Urgency_Level) VALUES
('N0', 'AP0', 'Reminder', '2024-04-19 09:00:00', 'High'),
('N1', 'AP1', 'Follow-up', '2024-04-20 10:00:00', 'Medium'),
('N2', 'AP2', 'Cancellation', '2024-04-21 11:00:00', 'High'),
('N3', 'AP3', 'Reschedule', '2024-04-22 13:00:00', 'Low'),
('N4', 'AP4', 'Confirmation', '2024-04-23 14:00:00', 'Medium'),
('N5', 'AP5', 'Reminder', '2024-04-24 15:00:00', 'High'),
('N6', 'AP6', 'Follow-up', '2024-04-25 09:00:00', 'Medium'),
('N7', 'AP7', 'Cancellation', '2024-04-26 10:00:00', 'High'),
('N8', 'AP8', 'Reschedule', '2024-04-27 11:00:00', 'Low'),
('N9', 'AP9', 'Confirmation', '2024-04-28 13:00:00', 'Medium');
GO
--------------------------------------------------------------------------------------------
-- Inserting associations into 'Staff_Location' table
INSERT INTO Staff_Location (Staff_ID, Location_ID) VALUES
('SF0', 'L0'),
('SF1', 'L1'),
('SF2', 'L2'),
('SF3', 'L2'),
('SF4', 'L1'),
('SF5', 'L3'),
('SF6', 'L0'),
('SF7', 'L1'),
('SF8', 'L2'),
('SF9', 'L3');
GO
--------------------------------------------------------------------------------------------
-- Inserting associations into 'Appointment_Service' table
INSERT INTO Appointment_Service (Appointment_ID, Service_ID) VALUES
('AP0', 'S0'),
('AP1', 'S1'),
('AP2', 'S2'),
('AP3', 'S0'), -- Assuming an appointment can have multiple services and vice versa
('AP4', 'S3'),
('AP5', 'S4'),
('AP6', 'S5'),
('AP7', 'S1'), -- Same service for different appointments
('AP8', 'S6'),
('AP9', 'S7');

-- Additional associations as examples
-- Note: 'AP1', 'AP2', ... and 'S1', 'S2', ... should be valid IDs in your Appointment and Services tables respectively
GO
--------------------------------------------------------------------------------------------
-- Insert rows with appointment IDs from AP1 to AP10
INSERT INTO Virtual (Appointment_ID, Call_Type) VALUES
('AP0', 'Consultation'),
('AP1', 'Follow-up'),
('AP2', 'Consultation'),
('AP3', 'Follow-up'),
('AP4', 'Consultation'),
('AP5', 'Follow-up'),
('AP6', 'Consultation'),
('AP7', 'Follow-up'),
('AP8', 'Consultation'),
('AP9', 'Follow-up');
GO
--------------------------------------------------------------------------------------------
-- Insert 10 rows with appointment IDs AP1 to AP10 and Location IDs L1 to L3
INSERT INTO In_Person (Appointment_ID, Waiting_Time, Location_ID) VALUES
('AP0', 15, 'L0'),
('AP2', 20, 'L1'),
('AP1', 10, 'L2'),
('AP3', 25, 'L3'),
('AP4', 30, 'L4'),
('AP5', 10, 'L5'),
('AP6', 20, 'L6'),
('AP7', 15, 'L7'),
('AP8', 10, 'L8'),
('AP9', 25, 'L9');