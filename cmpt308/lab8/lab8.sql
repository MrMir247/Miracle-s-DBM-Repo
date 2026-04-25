DROP TABLE IF EXISTS lab8_enrollment_audit;
DROP TABLE IF EXISTS lab8_enrollments;
DROP TABLE IF EXISTS lab8_courses;
DROP TABLE IF EXISTS lab8_students;

CREATE TABLE lab8_students (
  student_id INT PRIMARY KEY,
  student_name TEXT NOT NULL
);

CREATE TABLE lab8_courses (
  course_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  capacity INT NOT NULL CHECK (capacity > 0),
  enrolled_count INT NOT NULL DEFAULT 0 CHECK (enrolled_count >= 0 AND enrolled_count <= capacity)
);

CREATE TABLE lab8_enrollments (
  student_id INT NOT NULL REFERENCES lab8_students(student_id),
  course_id TEXT NOT NULL REFERENCES lab8_courses(course_id),
  enrolled_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, course_id)
);

CREATE TABLE lab8_enrollment_audit (
  audit_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  action_type TEXT NOT NULL,
  student_id INT NOT NULL,
  course_id TEXT NOT NULL,
  action_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lab8_students (student_id, student_name) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'Diana Evans');

INSERT INTO lab8_courses (course_id, title, capacity, enrolled_count) VALUES
('CS101', 'Intro to Programming', 30, 0),
('CS102', 'Database Systems', 20, 0),
('CS103', 'Advanced Algorithms', 1, 0);

INSERT INTO lab8_enrollments (student_id, course_id) VALUES
(1, 'CS101'),
(2, 'CS102'),
(3, 'CS103');

UPDATE lab8_courses SET enrolled_count = 1 WHERE course_id = 'CS103';
UPDATE lab8_courses SET enrolled_count = 1 WHERE course_id IN ('CS101', 'CS102');

GRANT SELECT ON lab8_courses TO advisor_role;
GRANT SELECT ON lab8_enrollments TO advisor_role;
GRANT SELECT ON lab8_enrollment_audit TO advisor_role;

GRANT SELECT ON lab8_courses TO registrar_role;
GRANT SELECT ON lab8_enrollments TO registrar_role;
GRANT SELECT ON lab8_enrollment_audit TO registrar_role;

GRANT INSERT ON lab8_enrollments TO registrar_role;
GRANT UPDATE ON lab8_courses TO registrar_role;
REVOKE DELETE ON lab8_enrollments FROM registrar_role;

SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('advisor_role', 'registrar_role')
  AND table_name IN ('lab8_students', 'lab8_courses', 'lab8_enrollments')
ORDER BY grantee, table_name, privilege_type;

CREATE OR REPLACE PROCEDURE register_student(
    p_student_id INT,
    p_course_id VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS(
		--IF statment expects one row and column to evaluate the boolean, so we do select one to satisfy it
		SELECT 1 FROM lab8_students s
		WHERE s.student_id = p_student_id
	) THEN
		RAISE EXCEPTION 'Student with this ID does not exist';
	END IF;

	IF NOT EXISTS(
		SELECT 1 FROM lab8_courses c
		WHERE c.course_id = p_course_id
	) THEN
		RAISE EXCEPTION 'Course with this ID does not exist';
	END IF;
	
	-- This function is used to check and see if the student is already in this class
	IF EXISTS(
		select 1 from lab8_enrollments e
		WHERE p_student_id = e.student_id and p_course_id = e.course_id
	) THEN
		Raise Exception 'Student is already registered in this class';
	END IF;

	IF (
		SELECT 1 FROM lab8_courses c 
		WHERE c.course_id = p_course_id AND c.capacity = c.enrolled_count
	)
	THEN
		RAISE EXCEPTION 'This course has no more seats left';
	END IF;

	INSERT INTO lab8_enrollments(student_id, course_id) VALUES
	(p_student_id, p_course_id);
	UPDATE lab8_courses SET enrolled_count = enrolled_count + 1 WHERE course_id = p_course_id; --This will update our enrolled count everytime somebody gets added to the class
END;
$$;

CREATE OR REPLACE FUNCTION audit_enrollment_func() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO lab8_enrollment_audit (audit_id, action_type, student_id, course_id)
    VALUES (
        (SELECT COALESCE(MAX(audit_id), 0) + 1 FROM lab8_enrollment_audit), 
        'INSERT', 
        NEW.student_id, 
        NEW.course_id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollment_audit
AFTER INSERT ON lab8_enrollments
FOR EACH ROW
EXECUTE FUNCTION audit_enrollment_func();

select s.student_name, c.course_id, c.title, e.enrolled_at from lab8_students s
INNER JOIN lab8_enrollments e on s.student_id = e.student_id
INNER JOIN lab8_courses c on e.course_id = c.course_id;

select capacity, enrolled_count, (capacity - enrolled_count) AS seats_remaining

SELECT * from lab8_enrollment_audit
Order by action_time

SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('advisor_role', 'registrar_role')
  AND table_name IN ('lab8_students', 'lab8_courses', 'lab8_enrollments')
ORDER BY grantee, table_name, privilege_type;

