package com.scs.bean;

public class Course
{
    private Long cId;
    private String cNumber;
    private String cName;
    private String teacher;
    private String department;
    private Integer maxNumber;
    private String cStart;
    private String cEnd;
    private String cDay;
    private String cTime;
    private String description;
    private String location;
    private Double credit;
    private Integer nowNum;

    public Course()
    {
    }

    public Course(Long cId, String cNumber, String cName, String teacher, String department,
                  Integer maxNumber, String cStart, String cEnd, String cDay, String cTime,
                  String description, String location, Double credit)
    {
        this.cId = cId;
        this.cNumber = cNumber;
        this.cName = cName;
        this.teacher = teacher;
        this.department = department;
        this.maxNumber = maxNumber;
        this.cStart = cStart;
        this.cEnd = cEnd;
        this.cDay = cDay;
        this.cTime = cTime;
        this.description = description;
        this.location = location;
        this.credit = credit;
        this.nowNum = 0;
    }

    public Course(Long cId, String cNumber, String cName, String teacher, String department,
                  Integer maxNumber, String cStart, String cEnd, String cDay, String cTime,
                  String description, String location, Double credit, Integer nowNum)
    {
        this.cId = cId;
        this.cNumber = cNumber;
        this.cName = cName;
        this.teacher = teacher;
        this.department = department;
        this.maxNumber = maxNumber;
        this.cStart = cStart;
        this.cEnd = cEnd;
        this.cDay = cDay;
        this.cTime = cTime;
        this.description = description;
        this.location = location;
        this.credit = credit;
        this.nowNum = nowNum;
    }

    public Integer getNowNum()
    {
        return nowNum;
    }

    public void setNowNum(Integer nowNum)
    {
        this.nowNum = nowNum;
    }

    public String getLocation()
    {
        return location;
    }

    public void setLocation(String location)
    {
        this.location = location;
    }

    public Double getCredit()
    {
        return credit;
    }

    public void setCredit(Double credit)
    {
        this.credit = credit;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public String getcNumber()
    {
        return cNumber;
    }

    public void setcNumber(String cNumber)
    {
        this.cNumber = cNumber;
    }

    public String getcName()
    {
        return cName;
    }

    public void setcName(String cName)
    {
        this.cName = cName;
    }

    public String getTeacher()
    {
        return teacher;
    }

    public void setTeacher(String teacher)
    {
        this.teacher = teacher;
    }

    public String getDepartment()
    {
        return department;
    }

    public void setDepartment(String department)
    {
        this.department = department;
    }

    public Integer getMaxNumber()
    {
        return maxNumber;
    }

    public void setMaxNumber(Integer maxNumber)
    {
        this.maxNumber = maxNumber;
    }

    public String getcStart()
    {
        return cStart;
    }

    public void setcStart(String cStart)
    {
        this.cStart = cStart;
    }

    public String getcEnd()
    {
        return cEnd;
    }

    public void setcEnd(String cEnd)
    {
        this.cEnd = cEnd;
    }

    public String getcDay()
    {
        return cDay;
    }

    public void setcDay(String cDay)
    {
        this.cDay = cDay;
    }

    public String getcTime()
    {
        return cTime;
    }

    public void setcTime(String cTime)
    {
        this.cTime = cTime;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }
}
