Name: Miracle Okoli 
Date: 02/26/2026

I reused my sql code but I also made some edits and changes as well

update Enrollments
set term = '2026SP'
Where student_id < 6;

update Enrollments
set term = '2026SM'
Where student_id = 6;

Insert into students 
Values
(21, 'George Mason', 'CS', '2026'),
(22, 'Matthew Goner', 'DS', '2028'),
(23, 'Matthew Goner', 'CS', '2027'),
(24, 'Matthew Goner', 'DS', '2028'),
(25, 'Matthew Goner', 'DS', '2026')

insert into courses
values(208, 'CMPT308', 4)

insert into enrollments
values(22, 208, 95, '2026SP'),
(23, 208, 90, '2026SP'),
(25, 208, 86, '2026SP')

select s.name, e.course_id from Students s
INNER JOIN enrollments e ON (s.student_id = e.student_id)
where e.term = '2026SP'

select s.name, c.title from Students s
INNER JOIN enrollments e ON (s.student_id = e.student_id)
INNER JOIN courses c ON (e.course_id = c.course_id)
where e.term = '2026SP'

Select c.course_id, c.title, e.term from courses c
LEFT JOIN enrollments e ON (e.course_id = c.course_id AND e.term = '2026SP') 

select c.course_id, c.title, count(*) from courses c
INNER JOIN enrollments e ON (e.course_id = c.course_id AND e.term = '2026SP')
GROUP BY c.course_id

select s.student_id, count(s.student_id) from students s
where s.student_id IN (select e.student_id from enrollments e where e.term = '2026SP')
GROUP BY s.student_id
Having count(s.student_id) >= 2

select s.name from Students s
where s.student_id in (select e.student_id from enrollments e
inner join courses c ON (e.course_id = c.course_id and c.title = 'CMPT308')
where e.term = '2026SP')

select c.course_id, c.title from courses c
where exists (select e.course_id from enrollments e where
e.term = '2026SP')

select s.student_id, count(s.student_id) from students s
where s.student_id IN (select e.student_id from enrollments e
where e.term = '2026SP')
Group By s.student_id
Having count(s.student_id) >= 2

select s.student_id, s.name from students s
where s.major = 'CS'
UNION
select s.student_id, s.name from students s
where s.major = 'DS'

select s.student_id, s.name from Students s
inner Join enrollments e ON (s.student_id = e.student_id)
where e.term = '2026SP'
EXCEPT 
select s.student_id, s.name from Students s
inner Join enrollments e ON (s.student_id = e.student_id)
inner Join courses c ON (c.course_id = e.course_id and c.title = 'CMPT308')

SELECT 
    c.course_id,
    c.title,
    COUNT(DISTINCT e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
    AND e.term = '2026SP'
GROUP BY 
    c.course_id,
    c.title
ORDER BY 
    student_count DESC,
    c.course_id;

SELECT
  c.course_id,
  c.title,
  COUNT(DISTINCT e.student_id) AS student_count
FROM Courses AS c
LEFT JOIN Enrollments AS e
  ON c.course_id = e.course_id
  AND e.term = '2026SP'
GROUP BY c.course_id, c.title
ORDER BY student_count DESC, c.course_id;

