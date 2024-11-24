package com.scs.service.impl;

import com.scs.bean.Stu_course;
import com.scs.dao.Stu_courseDao;
import com.scs.service.Stu_courseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Stu_CourseServiceImpl implements Stu_courseService
{

    @Autowired
    private Stu_courseDao stuCourseDao;

    @Override
    public List<Stu_course> getCourseByStuid(Long stuid)
    {
        return stuCourseDao.selectByStuid(stuid);
    }

    @Override
    public void addSc(Long stuid, Long cid, String status)
    {
        stuCourseDao.insert(stuid, cid, status);
    }

    @Override
    public Stu_course getCourse(Long stuid, Long cid)
    {
        return stuCourseDao.selectOne(stuid, cid);
    }

    @Override
    public List<Stu_course> getByState(Long stuid, String state)
    {
        return stuCourseDao.selectByState(stuid, state);
    }

    @Override
    public List<Stu_course> getByCidAndState(Long cid, String state)
    {
        return stuCourseDao.selectByCidAndState(cid, state);
    }

    @Override
    public int updateState(Long stuid, Long cid, String state)
    {
        return stuCourseDao.updateOne(stuid, cid, state);
    }

    @Override
    public void deleteByCid(Long cid)
    {
        stuCourseDao.deleteByCid(cid);
    }

    @Override
    public void deleteByStuid(Long stuid)
    {
        stuCourseDao.deleteByStuid(stuid);
    }


}
