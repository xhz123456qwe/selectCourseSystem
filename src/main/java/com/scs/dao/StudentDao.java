package com.scs.dao;

import com.scs.bean.Student;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface StudentDao
{

    @Select("select * from student")
    @ResultType(Student.class)
    List<Student> selectAll();

    @Select("select  * from student where snumber=#{snumber}")
    Student selectBySnumber(String snumber);

    @Select("select * from student where sid =#{sid}")
    Student selectBySid(Long sid);

    @Select("select * from student where snumber=#{snumber} and password=#{password}")
    Student selectBySnumberAndPassword(@Param("snumber") String snumber, @Param("password") String password);

    @Select("insert into student(sname,snumber,password,email,grade,department) " +
            "values (#{sname},#{snumber},#{password},#{email},#{grade},#{department})")
    void addOne(@Param("sname") String sname, @Param("snumber") String snumber,
                @Param("password") String password, @Param("email") String email,
                @Param("grade") String grade, @Param("department") String department);

    @Delete("delete from student where sid=#{sid}")
    void deleteBySid(@Param("sid") Long sid);

    @Update("update student set sname=#{sname},password=#{password},grade=#{grade}," +
            " department=#{department},email=#{email} where sid=#{sid}")
    int updateStu(@Param("sid") Long sid, @Param("sname") String sname, @Param("password") String password, @Param("grade") String grade,
                  @Param("department") String department, @Param("email") String email);
}
