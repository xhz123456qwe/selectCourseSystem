package com.scs.dao;

import com.scs.bean.Stu_course;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface Stu_courseDao
{

    @Select("select * from stu_course where stuid=#{stuid} order by cid ASC")
    @ResultType(Stu_course.class)
    List<Stu_course> selectByStuid(Long stuid);

    @Insert("insert into stu_course values (#{stuid},#{cid},#{status})")
    void insert(@Param("stuid") Long stuid, @Param("cid") Long cid, @Param("status") String status);

    @Select("select * from stu_course where stuid=#{stuid} and cid=#{cid}")
    Stu_course selectOne(@Param("stuid") Long stuid, @Param("cid") Long cid);

    @Select("select * from stu_course where stuid=#{stuid} and state=#{state}")
    List<Stu_course> selectByState(@Param("stuid") Long stuid, @Param("state") String state);

    @Select("select * from stu_course where cid=#{cid} and state=#{state}")
    List<Stu_course> selectByCidAndState(@Param("cid") Long cid, @Param("state") String state);


    @Update("update stu_course set state =#{state} where stuid=#{stuid} and cid=#{cid}")
    int updateOne(@Param("stuid") Long stuid, @Param("cid") Long cid, @Param("state") String state);

    @Delete("delete from stu_course where cid=#{cid}")
    void deleteByCid(@Param("cid") Long cid);

    @Delete("delete from stu_course where stuid=#{stuid}")
    void deleteByStuid(@Param("stuid") Long stuid);


}
