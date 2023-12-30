# Hospital-Schema

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE IF NOT EXISTS room (
room_num INT PRIMARY KEY,
nightly_fee INT,
capacity INT

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS patient (
patient_id INT UNIQUE PRIMARY KEY,
fname VARCHAR(45),
lname VARCHAR(45),
address VARCHAR(100),
phone_number VARCHAR(45),
room_num INT,
num_nights INT,

FOREIGN KEY (room_num) REFERENCES room(room_num)

) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS physician (
physician_num INT UNIQUE PRIMARY KEY,
field_of_expertise VARCHAR(100),
certification_num VARCHAR(45),
fname VARCHAR(45),
lname VARCHAR(45),
address VARCHAR(100),
phone_number VARCHAR(45)

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS nurse (
nurse_num INT UNIQUE PRIMARY KEY,
certification_num VARCHAR(45),
fname VARCHAR(45),
lname VARCHAR(45),
address VARCHAR(100),
phone_number VARCHAR(45)

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS medication (
prescription_id INT UNIQUE PRIMARY KEY,
patient_id INT,
nurse_num INT,
dailyAmount VARCHAR(45),

FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (nurse_num) REFERENCES nurse(nurse_num)

) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS healthRecord (
patient_id INT UNIQUE PRIMARY KEY,
disease VARCHAR(45),
record_date VARCHAR(45),
record_status VARCHAR(45),
record_description VARCHAR(500),

FOREIGN KEY (patient_id) REFERENCES patient(patient_id)

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS instructions (
code_id INT PRIMARY KEY,
fee INT,
instr_description VARCHAR(500),
instr_status VARCHAR(45),
execution_date VARCHAR(45),
order_date VARCHAR(45),
physician_num INT,
nurse_num INT,

FOREIGN KEY (nurse_num) REFERENCES nurse(nurse_num),
FOREIGN KEY (physician_num) REFERENCES physician(physician_num)

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS monitors (
physician_num INT,
patient_id INT,
start_date VARCHAR(45),
end_date VARCHAR(45),

primary key (physician_num, patient_id),
FOREIGN KEY (physician_num) REFERENCES physician(physician_num),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id)

) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS invoice (
invoice_id INT PRIMARY KEY,
invoice_date VARCHAR(45),
bill_amount INT,
payable_items VARCHAR(45),
patient_id INT,
room_num INT,
code_id INT,

FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (room_num) REFERENCES room(room_num),
FOREIGN KEY (code_id) REFERENCES instructions(code_id)

) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS give_Meds (
patient_id INT,
nurse_num INT,
daily_amount INT,

PRIMARY KEY (patient_id, nurse_num),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (nurse_num) REFERENCES nurse(nurse_num)

) ENGINE = InnoDB;







