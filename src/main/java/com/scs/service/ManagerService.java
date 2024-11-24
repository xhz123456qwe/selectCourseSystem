package com.scs.service;

import com.scs.bean.Manager;


import java.util.List;

public interface ManagerService
{

    List<Manager> getAll();

    Manager getByMid(Long mid);

    Manager getByNumberAndPwd(String mnumber, String password);

    int addOne(String mname, String password, String email, String mnumber);

    void deleteManager(Long mid);

    void updateManagerInfo(Long mid, String mname, String mnumber, String password, String email);
}
