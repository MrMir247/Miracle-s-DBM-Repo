-- I accidentally identified CMPT308 with a course id value of 208 instead of actually making 
--CMPT308 the actual course id
update students
set name = 'Bob Mcdonald'
where student_id = 23

-- I accidentally identified CMPT308 with a course id value of 208 instead of actually making 
--CMPT308 the actual course id
select s.student_id, s.name from students s
where s.student_id in (select e.student_id from enrollments e where course_id = '208' and term = '2026SP')

select course_id, title from courses
where exists (select course_id from enrollments)

insert into Students(student_id, name, major, class_year)
values(31, 'Jake Stepper', 'CS', 2029),
(38, 'Abby Walker', 'DS', 2027)

-- Safe NOT enrolled: List student_id and name for students who are not enrolled in '2026SP'. 
-- Use NOT EXISTS (not NOT IN).
select student_id, name from Students s
where not exists (
    SELECT 1 
    FROM enrollments e 
    WHERE e.student_id = s.student_id
    AND e.term = '2026SP'
)

insert into courses(course_id, title, credits)
values(301, 'CYBR210', 4)

INSERT INTO enrollments (student_id, course_id, grade, term)
VALUES 
  (2, 301, 92, '2026SP'),
  (3, 301, 88, '2026SP'),
  (21, 301, 95, '2026SM');
  
  --UNION: List student IDs enrolled in 'CMPT308' or 'CYBR210' in '2026SP'. (Return student_id only.)
select s.student_id from Students s
UNION
select e.student_id from enrollments e where course_id = 208 or course_id = 301

  --INTERSECT: List student IDs enrolled in 'CMPT308' and 'CYBR210' in '2026SP'. (Return student_id only.)
select student_id from enrollments where course_id = 301
intersect
select student_id from enrollments where course_id = 208

  




















