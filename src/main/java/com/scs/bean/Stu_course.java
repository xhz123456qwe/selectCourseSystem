package com.scs.bean;
/**
 *
 * @author 徐豪智
 * @description   学生-课程类
 *
 */
public class Stu_course
{
    private Long stUid;
    private Long cId;
    private String state;

    public Stu_course()
    {
    }

    public Stu_course(Long stUid, Long cId, String state)
    {
        this.stUid = stUid;
        this.cId = cId;
        this.state = state;
    }

    @Override
    public String toString()
    {
        return "Stu_course{" +
                "stuid=" + stUid +
                ", cid=" + cId +
                ", state='" + state + '\'' +
                '}';
    }

    public Long getStUid()
    {
        return stUid;
    }

    public void setStUid(Long stUid)
    {
        this.stUid = stUid;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public String getState()
    {
        return state;
    }

    public void setState(String state)
    {
        this.state = state;
    }
}
