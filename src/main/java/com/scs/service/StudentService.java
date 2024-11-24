package com.scs.service;

import com.scs.bean.Student;

import java.util.List;

public interface StudentService
{

    List<Student> getAll();

    Student getStudentBySid(Long sid);

    Student getStudentBySnumber(String snumber);

    Student getStudentBySnumberAndPassword(String snumber, String password);

    void addOne(String sname, String snumber, String password, String email,
                String grade, String department);

    void deleteBySid(Long sid);

    int updateStu(Long sid, String sname, String password, String grade, String department, String email);
}
