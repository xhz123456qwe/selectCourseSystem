package com.scs.bean;

public class Student
{
    private Long sId;
    private String sName;
    private String sNumber;
    private String password;
    private String email;
    private String grade;
    private String department;

    public Student(Long sId)
    {
        this.sId = sId;
    }

    public Student(Long sId, String sName, String sNumber,
                   String password, String email, String grade,
                   String department)
    {
        this.sId = sId;
        this.sName = sName;
        this.sNumber = sNumber;
        this.password = password;
        this.email = email;
        this.grade = grade;
        this.department = department;
    }

    @Override
    public String toString()
    {
        return "Student{" +
                "sid=" + sId +
                ", sname='" + sName + '\'' +
                ", snumber='" + sNumber + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", grade='" + grade + '\'' +
                ", department='" + department + '\'' +
                '}';
    }

    public Long getsId()
    {
        return sId;
    }

    public void setsId(Long sId)
    {
        this.sId = sId;
    }

    public String getsName()
    {
        return sName;
    }

    public void setsName(String sName)
    {
        this.sName = sName;
    }

    public String getsNumber()
    {
        return sNumber;
    }

    public void setsNumber(String sNumber)
    {
        this.sNumber = sNumber;
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

    public String getGrade()
    {
        return grade;
    }

    public void setGrade(String grade)
    {
        this.grade = grade;
    }

    public String getDepartment()
    {
        return department;
    }

    public void setDepartment(String department)
    {
        this.department = department;
    }
}
