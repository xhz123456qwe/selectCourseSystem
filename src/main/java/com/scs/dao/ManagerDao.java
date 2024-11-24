package com.scs.dao;

import com.scs.bean.Manager;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface ManagerDao
{

    @Select("select * from manager")
    @ResultType(Manager.class)
    List<Manager> getAll();

    @Select("select * from manager where mid=#{mid}")
    Manager getByMid(@Param("mid") Long mid);

    @Select("select * from manager where mnumber=#{mnumber} and password=#{password}")
    Manager getByNumberAndPwd(@Param("mnumber") String mnumber, @Param("password") String password);

    @Insert("insert into manager(mname,password,email,mnumber,state) values (#{mname},#{password}" +
            ",#{email},#{mnumber},0)")
    int addManager(@Param("mname") String mname, @Param("password") String password, @Param("email") String email,
                   @Param("mnumber") String mnumber);

    @Update("update manager set state='1' where mid=#{mid}")
    void deleteManager(@Param("mid") Long mid);

    @Update("update manager set mname=#{mname},mnumber=#{mnumber},password=#{password},email=#{email} where mid=#{mid}")
    void updateMagInfo(@Param("mid") Long mid, @Param("mname") String mname, @Param("mnumber") String mnumber,
                       @Param("password") String password, @Param("email") String email);
}
