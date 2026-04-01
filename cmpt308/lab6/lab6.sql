EXPLAIN
SELECT *
FROM Enrollments
WHERE term = '2026SP' AND course_id = '208';

EXPLAIN
SELECT *
FROM Enrollments
WHERE term = '2026SP' AND student_id = 1001;

EXPLAIN
SELECT s.name, c.title, e.term
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON c.course_id = e.course_id
WHERE e.term = '2026SP';

create index course_catalog on enrollments(term, course_id)

create index student_catalog on enrollments(term, student_id)

create index courses_and_students on enrollments(term, student_id, course_id)

EXPLAIN
SELECT *
FROM Students
WHERE major = 'CS';


