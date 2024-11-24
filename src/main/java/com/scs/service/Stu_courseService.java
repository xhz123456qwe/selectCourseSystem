package com.scs.service;

import com.scs.bean.Stu_course;

import java.util.List;

public interface Stu_courseService
{


    List<Stu_course> getCourseByStuid(Long stuid);

    void addSc(Long stuid, Long cid, String status);

    Stu_course getCourse(Long stuid, Long cid);

    List<Stu_course> getByState(Long stuid, String state);

    List<Stu_course> getByCidAndState(Long cid, String state);

    int updateState(Long stuid, Long cid, String state);

    void deleteByCid(Long cid);

    void deleteByStuid(Long stuid);

}
