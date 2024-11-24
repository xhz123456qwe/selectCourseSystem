package com.scs.dao;

import com.scs.bean.Course;
import jdk.jfr.Percentage;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface CourseDao
{

    @Select("select * from course order by cid ASC")
    @ResultType(Course.class)
    List<Course> selectAll();

    @Select("select * from course where cid=#{cid}")
    Course selectByCid(@Param("cid") Long cid);

    @Update("update course set nowNum=nowNum+#{nowNum} where cid=#{cid}")
    int updateNowNum(@Param("cid") Long cid, @Param("nowNum") Integer nowNum);

    @Delete("delete from course where cid=#{cid}")
    void deleteByCid(@Param("cid") Long cid);

    @Insert("insert into course(cnumber,cname,teacher,department,maxNumber,cStart,cEnd" +
            ",cDay,cTime,description,location,credit,nowNum) values (#{cnumber},#{cname},#{teacher}" +
            ",#{department},#{maxNumber},#{cStart},#{cEnd},#{cDay},#{cTime},#{description}" +
            ",#{location},#{credit},0)")
    void insertOne(@Param("cnumber") String cnumber, @Param("cname") String cname, @Param("teacher") String teacher,
                   @Param("department") String department, @Param("maxNumber") Integer maxNumber,
                   @Param("cStart") String cStart, @Param("cEnd") String cEnd, @Param("cDay") String cDay,
                   @Param("cTime") String cTime, @Param("description") String description, @Param("location") String location,
                   @Param("credit") Double credit);

    @Update("update course set cnumber=#{cnumber},cname=#{cname},teacher=#{teacher},department=#{department}," +
            "maxNumber=#{maxNumber},cStart=#{cStart},cEnd=#{cEnd},cDay=#{cDay},cTime=#{cTime},description" +
            "=#{description},location=#{location},credit=#{credit} where cid=#{cid}")
    void updateOne(@Param("cnumber") String cnumber, @Param("cname") String cname, @Param("teacher") String teacher,
                   @Param("department") String department, @Param("maxNumber") Integer maxNumber,
                   @Param("cStart") String cStart, @Param("cEnd") String cEnd, @Param("cDay") String cDay,
                   @Param("cTime") String cTime, @Param("description") String description, @Param("location") String location,
                   @Param("credit") Double credit, @Param("cid") Long cid);
}
