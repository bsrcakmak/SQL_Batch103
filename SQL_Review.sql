CREATE TABLE students(
student_id char(5) PRIMARY KEY,
student_name varchar,
email_address varchar NOT NULL,
student_age numeric(2) CHECK(student_age>0),
phone_number char(10) UNIQUE
)

SELECT * FROM students;

INSERT INTO students VALUES('1234','Tom Hanks','th@gmail.com',15,'123456789');
INSERT INTO students VALUES('1236','Brad Pitt','br@gmail.com',16,'123456777');
INSERT INTO students VALUES('1237','Angelina Jolie','aj@gmail.com',17,'123456666');

--Tabloya spesifik veriler eklemek istersek
INSERT INTO students(student_id,email_address,phone_number) VALUES ('1235','sg@gmail.com','3524267');

-- Change 1234 student_id to 1250 
UPDATE students
SET student_id='1250'
WHERE student_id='1234';

-- Change Tom Hanks to Anthony Quin 
UPDATE students
SET student_name='Anthony Quin'
WHERE student_name='Tom Hanks';

-- Following code gives error because email_address field has NOY NULL Constraint 
UPDATE students
SET email_address=NULL
WHERE email_address='br@gmail.com'
-- Bu islem yapilamaz ERROR verir cunku NOT NULL degeri verildi olusturulurken

-- Update all students, ages to the maximum ages
UPDATE students
SET student_age=(SELECT MAX(student_age) FROM students);

-- Create parents table with the 
CREATE TABLE parents (
parent_id char(5) PRIMARY KEY,
parent_name TEXT,
student_id char(5),
parent_address TEXT,
parent_dob date
);

SELECT * FROM parents;

-- Insert 4 record into the parents table
INSERT INTO parents VALUES('11111','Ali Can','12345','Miami','1991-12-13');
INSERT INTO parents VALUES('22222','Ayse Can','12346','USA','1990-02-12');
INSERT INTO parents VALUES('33333','Ahmet Can','12347','London','1993-03-4');
INSERT INTO parents VALUES('44444','Arzu Can','12348','Paris','1991-10-26');


-- Change all date of births to the minimum date of births
UPDATE parents
SET parent_dob= (SELECT MIN(parent_dob) FROM parents);


CREATE TABLE pupils(
student_id char(5) PRIMARY KEY,
pupil_name varchar,
email_address varchar NOT NULL,
pupil_age numeric(2) CHECK(pupil_age>0),
pupil_number char(10) UNIQUE,
CONSTRAINT student_id_fk FOREIGN KEY(student_id) REFERENCES parents(parent_id)	
);


