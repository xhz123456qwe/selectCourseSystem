package com.scs.tag;

import com.scs.bean.Course;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
/**
 *
 * @author 徐豪智
 * @description   实现当天课程表的课程的显示的自定义Tag
 */
public class NowDayCourseTag extends SimpleTagSupport
{
    private List<Course> courseList;
    private String contextPath;

    public void setCourseList(List<Course> courseList)
    {
        this.courseList = courseList;
    }

    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    @Override
    public void doTag() throws JspException, IOException
    {
        JspWriter out = getJspContext().getOut();

        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonth().getValue();


        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar calendar = Calendar.getInstance();

        int temp = 0;
        String src = "\"" +contextPath+"/static/imgs/table.png\"";
        System.out.println(src);
        if (courseList.isEmpty())
        {
            out.write("<div class='course2'><div class='c3'>" +
                    " <img src=" + src + "alt=\"table\"/>" +
                    "</div><div class='c4'>今日无课程</div></div>");
        } else
        {
            for (int i = 0; i < courseList.size(); i++)
            {
                try
                {
                    if (isOnThatDayOrNot(courseList.get(i).getcStart(), courseList.get(i).getcEnd(), courseList.get(i).getcDay()))
                    {
                        temp = 1;
                        out.write("<div class='course1'><div class='c1'>" + courseList.get(i).getcName() + "</div>"
                                + "<div class='c2'>" + courseList.get(i).getcTime() + "</div></div>");
                    }
                } catch (ParseException e)
                {
                    throw new RuntimeException(e);
                }
            }
            if (temp == 0)
            {
                out.write("<div class='course2'><div class='c3'>" +
                        " <img src=" + src + "alt=\"table\"/>" +
                        "</div><div class='c4'>今日无课程</div></div>");
            }
        }
    }

    private boolean isOnThatDayOrNot(String beginDate, String endDate, String cDay) throws ParseException
    {
        int bYear = Integer.parseInt((beginDate.split("年"))[0]);
        int bMonth = Integer.parseInt(((beginDate.split("年"))[1].split("月"))[0]);
        int bDay = Integer.parseInt((((beginDate.split("年"))[1].split("月"))[1].split("日"))[0]);
        int eYear = Integer.parseInt((endDate.split("年"))[0]);
        int eMonth = Integer.parseInt(((endDate.split("年"))[1].split("月"))[0]);
        int eDay = Integer.parseInt((((endDate.split("年"))[1].split("月"))[1].split("日"))[0]);
        String start = getDateForm(bYear, bMonth, bDay);
        String end = getDateForm(eYear, eMonth, eDay);
        //判断某个日期是否在两个日期范围之内
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = simpleDateFormat.parse(start);
        Date date2 = simpleDateFormat.parse(end);
        LocalDate now = LocalDate.now();
        Date dateNow = simpleDateFormat.parse(now.toString());
        if (date1.getTime() <= dateNow.getTime() && date2.getTime() >= dateNow.getTime())
        {
            String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
            Calendar calendar = Calendar.getInstance();
            if (cDay.contains(weekDays[calendar.get(Calendar.DAY_OF_WEEK) - 1]))
            {
                System.out.println("在date1和date2日期范围内！");
                return true;
            }
        }
        return false;
    }

    private String getDateForm(int bYear, int bMonth, int bDay)
    {
        String start = "";
        if (bMonth >= 1 && bMonth <= 9)
        {
            start = bYear + "-" + "0" + bMonth;
        } else
        {
            start = bYear + "-" + bMonth;
        }
        if (bDay >= 1 && bDay <= 9)
        {
            start = start + "-" + "0" + bDay;
        } else
        {
            start = start + "-" + bDay;
        }
        return start;
    }
}
