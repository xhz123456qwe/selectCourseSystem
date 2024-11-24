package com.scs.service.impl;

import com.scs.bean.Course;
import com.scs.dao.CourseDao;
import com.scs.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService
{

    @Autowired
    private CourseDao courseDao;

    @Override
    public List<Course> getAllCourse()
    {
        return courseDao.selectAll();
    }

    @Override
    public Course getCourseByCid(Long cid)
    {
        return courseDao.selectByCid(cid);
    }

    @Override
    public int updateCourseNowNum(Long cid, Integer nowNum)
    {
        return courseDao.updateNowNum(cid, nowNum);
    }

    @Override
    public void deleteByCid(Long cid)
    {
        courseDao.deleteByCid(cid);
    }

    @Override
    public void addOne(String cnumber, String cname, String teacher, String department, Integer maxNumber,
                       String cStart, String cEnd, String cDay, String cTime, String description, String location, Double credit)
    {
        courseDao.insertOne(cnumber, cname, teacher, department, maxNumber, cStart, cEnd, cDay
                , cTime, description, location, credit);
    }

    @Override
    public void updateOne(Long cid, String cnumber, String cname, String teacher, String department,
                          Integer maxNumber, String cStart, String cEnd, String cDay, String cTime,
                          String description, String location, Double credit)
    {
        courseDao.updateOne(cnumber, cname, teacher, department, maxNumber, cStart, cEnd, cDay, cTime, description,
                location, credit, cid);
    }
}
