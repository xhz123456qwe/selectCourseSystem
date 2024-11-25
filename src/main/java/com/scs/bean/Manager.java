package com.scs.bean;
/**
 *
 * @author 徐豪智
 * @description   管理员类
 *
 */
public class Manager
{
    private Long mId;
    private String mName;
    private String mNumber;
    private String password;
    private String email;
    private String state;

    public Manager()
    {
    }

    public Manager(Long mId, String mName, String mNumber, String password, String email)
    {
        this.mId = mId;
        this.mName = mName;
        this.mNumber = mNumber;
        this.password = password;
        this.email = email;
        this.state = "0";
    }

    @Override
    public String toString()
    {
        return "Manager{" +
                "mid=" + mId +
                ", mname='" + mName + '\'' +
                ", mnumber='" + mNumber + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", state='" + state + '\'' +
                '}';
    }

    public String getState()
    {
        return state;
    }

    public void setState(String state)
    {
        this.state = state;
    }

    public String getmNumber()
    {
        return mNumber;
    }

    public void setmNumber(String mNumber)
    {
        this.mNumber = mNumber;
    }

    public Long getmId()
    {
        return mId;
    }

    public void setmId(Long mId)
    {
        this.mId = mId;
    }

    public String getmName()
    {
        return mName;
    }

    public void setmName(String mName)
    {
        this.mName = mName;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }
}
