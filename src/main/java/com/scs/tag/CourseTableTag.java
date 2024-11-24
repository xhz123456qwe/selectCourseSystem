package com.scs.tag;

import com.scs.bean.Course;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.io.IOException;
import java.util.Random;

public class CourseTableTag extends SimpleTagSupport
{
    private List<Course> courseChosen;
    private String time;

    public void setCourseChosen(List<Course> courseChosen)
    {
        this.courseChosen = courseChosen;
    }

    public void setTime(String time)
    {
        this.time = time;
    }

    @Override
    public void doTag() throws JspException, IOException
    {
        JspWriter out = getJspContext().getOut();
        String[] day = {"星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"};
        String[] colors = {"#f5ecfc", "#e6eaf4", "#fae8e0", "#eff5ea", "#f6f6f6", "#e5effc",
                "#ebedf2", "#fce3e4", "#ebedf2", "#fdeeeb", "#dbe4dc", "#f5f7d3", "#d8d4d4", "#d9d4d4", "#d7d4d4"
                , "#d3d4d4", "#d1d4d4", "#d2d4d4"};
        ArrayList<String> colorList = new ArrayList<>(Arrays.asList(colors));
        for (int i = 0; i <= 6; i++)
        {
            out.write("<td>");
            List<Course> course = new ArrayList<>();
            if (courseChosen != null)
            {
                for (int j = 0; j < courseChosen.size(); j++)
                {
                    if (courseChosen.get(j).getcTime().equals(time) && courseChosen.get(j).getcDay().contains(day[i]))
                    {
                        course.add(courseChosen.get(j));
                    }
                }
            }
            if (!course.isEmpty())
            {
                //随机颜色
                Random random = new Random();
                int colorIndex = random.nextInt(colorList.size()) + 1;  //1 ~ length
                String color = colorList.get(colorIndex - 1);
                colorList.remove(colorIndex - 1);
                int max = getMaxLength() * 100;
                if (course.size() == 1)
                {
                    out.write("<div class='div1'  style='background-color:" + color + "; height:" + max + "px;'><div class='div2'>" + course.getFirst().getcName() + "</div>" +
                            "<div class='div3'>" + course.getFirst().getcTime() + "</div>" +
                            "<div class='div3'>" + course.getFirst().getLocation() + "</div></div>");
                } else
                {
                    for (int k = 0; k < course.size(); k++)
                    {
                        out.write("<div class='div1 div_many' style='background-color:" + color + "; height:" + max / course.size() + "px;'><div class='div2'>" + course.get(k).getcName() + "</div>" +
                                "<div class='div3'>" + course.get(k).getcTime() + "</div>" +
                                "<div class='div3'>" + course.get(k).getLocation() + "</div></div>");
                    }
                }
            }
            out.write("</td>");
        }
    }

    public int getMaxLength()
    {
        String[] day = {"星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"};
        int max = 0;
        for (int i = 0; i <= 6; i++)
        {
            int index = 0;
            for (int j = 0; j < courseChosen.size(); j++)
            {
                if (courseChosen.get(j).getcTime().equals(time) && courseChosen.get(j).getcDay().contains(day[i]))
                {
                    index++;
                }
            }
            max = Math.max(max, index);
        }
        return max;
    }
}
