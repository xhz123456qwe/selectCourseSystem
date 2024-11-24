package com.scs.service.impl;

import com.scs.bean.Student;
import com.scs.dao.StudentDao;
import com.scs.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService
{
    @Autowired
    private StudentDao studentDao;

    @Override
    public List<Student> getAll()
    {
        return studentDao.selectAll();
    }

    @Override
    public Student getStudentBySid(Long sid)
    {
        return studentDao.selectBySid(sid);
    }

    @Override
    public Student getStudentBySnumber(String snumber)
    {
        return studentDao.selectBySnumber(snumber);
    }

    @Override
    public Student getStudentBySnumberAndPassword(String snumber, String password)
    {
        return studentDao.selectBySnumberAndPassword(snumber, password);
    }

    @Override
    public void addOne(String sname, String snumber, String password, String email, String grade, String department)
    {
        studentDao.addOne(sname, snumber, password, email, grade, department);
    }

    @Override
    public void deleteBySid(Long sid)
    {
        studentDao.deleteBySid(sid);
    }

    @Override
    public int updateStu(Long sid, String sname, String password, String grade, String department, String email)
    {
        return studentDao.updateStu(sid, sname, password, grade, department, email);
    }
}
