package com.scs.service.impl;

import com.scs.bean.Manager;
import com.scs.dao.ManagerDao;
import com.scs.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService
{
    @Autowired
    private ManagerDao managerDao;

    @Override
    public List<Manager> getAll()
    {
        return managerDao.getAll();
    }

    @Override
    public Manager getByMid(Long mid)
    {
        return managerDao.getByMid(mid);
    }

    @Override
    public Manager getByNumberAndPwd(String mnumber, String password)
    {
        return managerDao.getByNumberAndPwd(mnumber, password);
    }

    @Override
    public int addOne(String mname, String password, String email, String mnumber)
    {
        return managerDao.addManager(mname, password, email, mnumber);
    }

    @Override
    public void deleteManager(Long mid)
    {
        managerDao.deleteManager(mid);
    }

    @Override
    public void updateManagerInfo(Long mid, String mname, String mnumber, String password, String email)
    {
        managerDao.updateMagInfo(mid, mname, mnumber, password, email);
    }
}
