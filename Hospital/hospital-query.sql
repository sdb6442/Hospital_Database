# Queries showcasing database (3 Triggers, 3 Views, 15 Required Queries (3 Join, 3 Aggregation, 3 Nested, 6 Other Queries))

# Triggers (3 Total):
# Trigger 1 - certificationNumberLimit
mysql> delimiter //
CREATE TRIGGER certificationNumberLimit
BEFORE INSERT 
ON nurse FOR EACH ROW
BEGIN
IF length(NEW.certification_num) > 6 or length(NEW.certification_num) < 6 THEN UPDATE nurse set NEW.certification_num = 6
END IF;
END
mysql> delimiter ;

# Trigger 2 - nightlyFeeMax
mysql> delimiter //
CREATE TRIGGER nightlyFeeMax
BEFORE INSERT 
ON room FOR EACH ROW
BEGIN 
IF NEW.nightly_fee > 100 THEN UPDATE room SET NEW.nightly_fee = 100
END IF;
END
mysql> delimiter ;

# Trigger 3 - maximum_dosage
mysql> delimiter //
CREATE TRIGGER maximum_dosage
BEFORE INSERT 
ON medication FOR EACH ROW
BEGIN
IF length(NEW.dailyAmount) > 7 THEN UPDATE medication SET NEW.dailyAmount = '250 MG'
END IF;
END
mysql> delimiter ;


# VIEWS (3 Total):
# View 1- Active Patients
CREATE VIEW active_patient as
SELECT pa.patient_id, pa.fname, pa.lname, pa.address, pa.room_num, h.record_status
FROM patient pa Join healthrecord h On pa.patient_id = h.patient_id
WHERE record_status = 'Active';

# View 2- Nurse Duties (Nurse, Patient, Meds, Instructions)
CREATE VIEW nurse_duties as
SELECT concat(n.fname, ' ', n.lname) as nurse, p.patient_id, p.fname, p.lname, m.prescription_id, m.dailyAmount as daily_meds, i.instr_description, i.order_date, i.execution_date
FROM patient p
JOIN medication m ON p.patient_id = m.patient_id
JOIN nurse n ON n.nurse_num = m.nurse_num
JOIN instructions i ON i.nurse_num = n.nurse_num
WHERE i.execution_date > '2023-03-01'
GROUP BY p.patient_id;

# View 3 - Patient's Team (patient, nurse, physician)
CREATE VIEW patient_team as
SELECT concat(p.fname, ' ', p.lname) as patient, p.patient_id, concat(n.fname, ' ', n.lname) as nurse, n.nurse_num, concat(ph.fname, ' ', ph.lname) as physician, ph.physician_num
FROM patient p
JOIN medication me ON p.patient_id = me.patient_id
JOIN nurse n ON n.nurse_num = me.nurse_num
JOIN monitors m ON p.patient_id = m.patient_id
JOIN physician ph ON m.physician_num = ph.physician_num 
GROUP BY p.patient_id;

# The next 15 Queries are from part 6 of our report.

# Join Queries (Queries 1-3 in Report)
# Join Query 1- The total bill amount of Dr. Oscars' patients
SELECT sum(bill_amount)
FROM patient pa
Join monitors m On pa.patient_id = m.patient_id
Join physician ph On ph.physician_num = m.physician_num
Join invoice i On pa.patient_id = i.patient_id
WHERE ph.lname = 'Oscars';

# Join Query 2- Patients and their corresponding physician
SELECT p.fname, p.lname, m.start_date, m.end_date, phy.fname AS physician_fname, phy.lname AS physician_lname
FROM patient p
INNER JOIN monitors m ON p.patient_id = m.patient_id
INNER JOIN physician phy ON m.physician_num = phy.physician_num;

# Join Query 3- Patient and Physician information of patients with AIDS
SELECT p.fname, p.lname, phy.fname AS physician_fname, phy.lname 
AS physician_lname, h.disease, h.record_date, h.record_description
FROM patient p
INNER JOIN monitors m ON p.patient_id = m.patient_id
INNER JOIN physician phy ON m.physician_num = phy.physician_num
INNER JOIN healthRecord h ON p.patient_id = h.patient_id
WHERE h.disease = 'AIDS';

# Aggregation Queries (Queries 4-6 in Report)
# Aggregation Query 1- Patient count for each Physician
SELECT COUNT(*) AS num_patients, ph.fname, ph.lname, ph.field_of_expertise
FROM patient p
INNER JOIN monitors m ON m.patient_id = p.patient_id
INNER JOIN physician ph ON ph.physician_num = m.physician_num
GROUP BY ph.physician_num;

# Aggregation Query 2 -  Total fees owed on each room
SELECT r.room_num, SUM(r.nightly_fee*p.num_nights) AS Total_Room_Fees
FROM patient p
JOIN room r ON p.room_num = r.room_num
GROUP BY r.room_num;

# Aggregation Query 3 - Max/Min Payable Items, Max/Min and Avg Bill Amount of 
#                       Patients with Healthrecord status of 'Active'
SELECT Count(p.patient_id) AS Active_Patients, Max(i.payable_items) as Max_Payable_Items, Min(i.payable_items) as Min_Payable_Items, 
Max(i.bill_amount) AS Max_Bill, Min(i.bill_amount) AS Min_Bill, Avg(i.bill_amount) AS Avg_Bill
FROM patient p, invoice i, healthrecord h
WHERE p.patient_id = i.patient_id AND p.patient_id = h.patient_id
AND h.record_status = 'Active';

# NESTED QUERIES (Queries 7-9 in Report):
# Nested Query 1-  Nurses not in contact with Covid-19 patients
SELECT n.nurse_num, n.fname, n.lname
FROM nurse n
JOIN medication m ON n.nurse_num = m.nurse_num
WHERE m.patient_id 
NOT IN (SELECT p.patient_id FROM patient p JOIN healthrecord h ON p.patient_id = h.patient_id
WHERE h.disease = 'Covid-19');

# Nested Query 2 - Rooms With Less Capacity and Same Nightly Fee as Room 5
SELECT room_num, nightly_fee, capacity
FROM room r1
WHERE r1.capacity < (SELECT r2.capacity
FROM room r2
WHERE r2.room_num = 5 AND r1.nightly_fee = r2.nightly_fee);

# Nested Query 3 - Patients with the same room number and payable_items
SELECT p1.patient_id, p1.fname, p1.lname, p1.address, p1.room_num, i1.invoice_id, i1.invoice_date, i1.bill_amount, i1.payable_items
FROM patient p1, invoice i1
WHERE p1.patient_id = i1.patient_id
AND EXISTS (SELECT p2.patient_id
FROM patient p2, invoice i2
WHERE p1.room_num = p2.room_num AND i1.payable_items = i2.payable_items AND p1.patient_id <> p2.patient_id);

# Other Queries (Queries 10-15 in Report) :
# Query 10 - Returns nurses names that have 3 vowels in their first name and last name
SELECT fname, lname
FROM nurse
WHERE fname OR lname REGEXP '[aeiouAEIOU].[aeiouAEIOU].[aeiouAEIOU]';

# Query 11 - Displays the patient with the highest bill amount
SELECT invoice_id, invoice_date, CONCAT(patient.fname, ' ', patient.lname) as patient_name
FROM invoice
INNER JOIN patient ON invoice.patient_id = patient.patient_id
ORDER BY bill_amount DESC LIMIT 1;

# Query 12 - List of patients with their info that have been prescribed medication by the nurse with id=99
SELECT *
FROM patient
WHERE patient_id IN (
    SELECT patient_id
    FROM medication
    WHERE nurse_num = 99
);

# Query 13 - Lists the physicians name and phone number who have at least one patient who has been in the hospital > 3 days
SELECT DISTINCT physician.fname, physician.lname, physician.phone_number 
FROM physician 
JOIN instructions ON physician.physician_num = instructions.physician_num 
JOIN invoice ON instructions.code_id = invoice.code_id 
JOIN patient ON invoice.patient_id = patient.patient_id 
WHERE patient.num_nights > 3;

# Query 14 - Lists patients' name and phone number who is in a room with a capacity of 2 or more
SELECT fname, lname, phone_number
FROM patient
JOIN room ON patient.room_num = room.room_num
WHERE room.capacity >= 2;

# Query 15 - Finds patients with a difference in the fees associated with their instructions
#            and their final invoice bill amount, then calculates and displays the difference.
SELECT p.patient_id, p.fname, p.lname, ins.fee, i.bill_amount, ABS(i.bill_amount-ins.fee) AS difference
FROM patient p
JOIN invoice i ON p.patient_id = i.patient_id
JOIN instructions ins ON i.code_id = ins.code_id 
WHERE i.bill_amount <> ins.fee
GROUP BY p.patient_id;
