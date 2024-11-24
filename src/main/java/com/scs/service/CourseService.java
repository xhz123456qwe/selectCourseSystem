package com.scs.service;

import com.scs.bean.Course;

import java.util.List;

public interface CourseService
{
    List<Course> getAllCourse();

    Course getCourseByCid(Long cid);

    int updateCourseNowNum(Long cid, Integer nowNum);

    void deleteByCid(Long cid);

    void addOne(String cnumber, String cname, String teacher, String department,
                Integer maxNumber, String cStart, String cEnd, String cDay, String cTime,
                String description, String location, Double credit);

    void updateOne(Long cid, String cnumber, String cname, String teacher, String department,
                   Integer maxNumber, String cStart, String cEnd, String cDay, String cTime,
                   String description, String location, Double credit);
}
