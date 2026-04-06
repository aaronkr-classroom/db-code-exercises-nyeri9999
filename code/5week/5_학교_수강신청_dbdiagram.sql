Table Student {
  student_id int [pk]        // 학번
  name varchar(50)
  major varchar(50)
}

Table Professor {
  employee_id int [pk]       // 사번
  student_id int             // (FK) 지도 학생 (선택적 관계)
  name varchar(50)
  department varchar(50)
}

Table Course {
  course_id int
  section_id int
  name varchar(100)

  Indexes {
    (course_id, section_id) [pk]   // 복합키
  }
}

Table Enrollment {
  student_id int
  course_id int
  section_id int
  grade varchar(2)
  enrolled_at date

  Indexes {
    (student_id, course_id, section_id) [pk]
  }
}