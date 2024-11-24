package com.scs.controller;

import com.scs.bean.Course;
import com.scs.bean.Stu_course;
import com.scs.bean.Student;
import com.scs.service.CourseService;
import com.scs.service.Stu_courseService;
import com.scs.service.StudentService;
import com.sun.net.httpserver.Request;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.http.HttpRequest;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/student")
public class StudentController
{
    @Autowired
    private StudentService studentService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private Stu_courseService stu_courseService;


    @PostMapping()
    public String judgeStudent(
            @RequestParam("username")
            String username,
            @RequestParam("password")
            String password,
            @RequestParam(value = "remember",required = false)
            String remember,
            HttpSession session,
            Model model,
            HttpServletRequest request,
            HttpServletResponse response
    )
    {
        Student stu = studentService.getStudentBySnumberAndPassword(username, password);
        if (stu == null)
        {
            model.addAttribute("stuLoginError", 1);
            return "error";
        } else
        {
            session.setAttribute("student", stu);
            if(remember!=null){
                //十天内免登录
                Cookie cookie1 = new Cookie("stuName",username);
                Cookie cookie2 = new Cookie("stuPassword", password);
                cookie1.setMaxAge(60*60*24*10);//十天
                cookie2.setMaxAge(60*60*24*10);
                response.addCookie(cookie1);
                response.addCookie(cookie2);
                System.out.println(cookie2.getValue());
            }
            return "redirect:/student/mainPage";
        }
    }

    @RequestMapping("/mainPage")
    public String showMainPage(Model model, HttpSession session, HttpServletRequest request)
    {
        LocalDate nowDate = LocalDate.now();
        if (nowDate.getMonth().getValue() >= 9)
        {
            LocalDate localDate = LocalDate.of(nowDate.getYear(), 9, 1);
            long days = ChronoUnit.DAYS.between(localDate, nowDate);
            long whichWeek = (long) Math.ceil(days / 7.0);
            model.addAttribute("whichWeek", whichWeek);
        } else if (nowDate.getMonth().getValue() >= 6)
        {
            LocalDate localDate = LocalDate.of(nowDate.getYear(), 6, 1);
            long days = ChronoUnit.DAYS.between(localDate, nowDate);
            long whichWeek = (long) Math.ceil(days / 7.0);
            model.addAttribute("whichWeek", whichWeek);
        } else if (nowDate.getMonth().getValue() >= 3)
        {
            LocalDate localDate = LocalDate.of(nowDate.getYear(), 3, 1);
            long days = ChronoUnit.DAYS.between(localDate, nowDate);
            long whichWeek = (long) Math.ceil(days / 7.0);
            model.addAttribute("whichWeek", whichWeek);
        } else
        {
            LocalDate localDate = LocalDate.of(nowDate.getYear(), 1, 1);
            long days = ChronoUnit.DAYS.between(localDate, nowDate);
            long whichWeek = (long) Math.ceil(days / 7.0);
            model.addAttribute("whichWeek", whichWeek);
        }
        model.addAttribute("nowDate", nowDate);
        Student student = (Student) session.getAttribute("student");
        List<Stu_course> courseBy = stu_courseService.getByState(student.getsId(), "已选择");
        courseBy.addAll(stu_courseService.getByCidAndState(student.getsId(), "超额选择"));
        List<Course> courseHad = new ArrayList<>();
        if (!courseBy.isEmpty())
        {
            List<Course> allCourses = courseService.getAllCourse();
            for (int i = 0; i < courseBy.size(); i++)
            {
                if (allCourses.isEmpty())
                {
                    break;
                }
                for (int j = 0; j < allCourses.size(); j++)
                {
                    if (allCourses.get(j).getcId().equals(courseBy.get(i).getcId()))
                    {
                        courseHad.add(allCourses.get(j));
                    }
                }
            }
        }
        model.addAttribute("courses", courseHad);

        //存储虚拟目录
        String contextPath = request.getContextPath();
        session.setAttribute("contextPath",contextPath);
        return "stuMainPage";
    }

    @RequestMapping(value = "/selectCourse", method = RequestMethod.GET)
    public String selectCourse(HttpSession session)
    {
        Student student = (Student) session.getAttribute("student");
        List<Course> allCourses = courseService.getAllCourse();
        session.setAttribute("allCourses", allCourses);//所有课
        int totalPages = 1;
        List<Stu_course> stu_courses = stu_courseService.getCourseByStuid(student.getsId());
        //检查数据库是否遗漏
        if (allCourses != null)
        {
            if (stu_courses == null)
            {
                for (int i = 0; i < allCourses.size(); i++)
                {
                    stu_courseService.addSc(student.getsId(), allCourses.get(i).getcId(), "待选择");
                }
            } else
            {
                for (int i = 0; i < allCourses.size(); i++)
                {
                    if (stu_courseService.getCourse(student.getsId(), allCourses.get(i).getcId()) == null)
                    {
                        stu_courseService.addSc(student.getsId(), allCourses.get(i).getcId(), "待选择");
                    }
                }
            }
            //计算页数和当前页面
            totalPages = (int) Math.ceil(allCourses.size() / 5.0);
            session.setAttribute("s_sc_totalPages", totalPages);
            session.setAttribute("s_sc_currentPages", (Integer) 1);
        } else
        {
            //0
            session.setAttribute("s_sc_totalPages", totalPages);
            session.setAttribute("s_sc_currentPages", (Integer) 1);
        }
        List<Stu_course> course = stu_courseService.getCourseByStuid(student.getsId());
        session.setAttribute("courseState", course);

        //分页
        if (allCourses != null && allCourses.size() > 5)
        {
            session.setAttribute("courseNow", allCourses.subList(0, 5));
        } else
        {
            session.setAttribute("courseNow", allCourses);
        }
        return "selectCourse";
    }

    /*
     *       allCourses   session    all course
     *       courseNow    session    5 courses(or less)
     *       courseState     session    course state
     *       s_sc_totalPages   session   total pages
     *       s_sc_currentPages  session   now page
     * */
    @RequestMapping(value = "/selectCourse1", method = RequestMethod.GET)
    public String selectCourseByPage(@RequestParam("page") Integer page, HttpSession session)
    {
        Student student = (Student) session.getAttribute("student");
        //更新选课状态
        List<Stu_course> courseByStuid = stu_courseService.getCourseByStuid(student.getsId());
        session.setAttribute("courseState", courseByStuid);
        //跟新课程信息
        List<Course> allCourses = (List<Course>) session.getAttribute("allCourses");
        //1 0-4   2 5-9
        if (page * 5 <= allCourses.size())
        {
            session.setAttribute("courseNow", allCourses.subList(5 * (page - 1), 5 * page));
        } else
        {
            session.setAttribute("courseNow", allCourses.subList(5 * (page - 1), allCourses.size()));
        }
        session.setAttribute("s_sc_totalPages", (int) Math.ceil(allCourses.size() / 5.0));
        session.setAttribute("s_sc_currentPages", page);
        return "selectCourse";
    }

    @RequestMapping(value = "/showCourseBySearch/{page}", method = RequestMethod.POST)
    public String getSearchCourse(
            @RequestParam("cname")
            String cname,
            @RequestParam("cnumber")
            String cnumber,
            @RequestParam("teacher")
            String teacher,
            @RequestParam("state")
            String state,
            @PathVariable("page")
            int page,
            Model model,
            HttpSession session
    )
    {
        Student student = (Student) session.getAttribute("student");
        List<Course> allCourse = courseService.getAllCourse();
        List<Course> courseList1 = new ArrayList<>();
        List<Course> courseList2 = new ArrayList<>();
        if (cname.equals(""))
        {
            courseList1.addAll(allCourse);
        } else
        {
            for (int i = 0; i < allCourse.size(); i++)
            {
                if (allCourse.get(i).getcName().contains(cname))
                {
                    courseList1.add(allCourse.get(i));
                }
            }
        }
        if (cnumber.equals(""))
        {
            courseList2.addAll(courseList1);
        } else
        {
            for (int i = 0; i < courseList1.size(); i++)
            {
                if (courseList1.get(i).getcNumber().contains(cnumber))
                {
                    courseList2.add(courseList1.get(i));
                }
            }
        }
        courseList1.clear();
        if (teacher.equals(""))
        {
            courseList1.addAll(courseList2);
        } else
        {
            for (int i = 0; i < courseList2.size(); i++)
            {
                if (courseList2.get(i).getTeacher().contains(teacher))
                {
                    courseList1.add(courseList2.get(i));
                }
            }
        }
        courseList2.clear();
        if (state.equals(""))
        {
            courseList2.addAll(courseList1);
        } else if (state.equals("已选择"))
        {
            for (int i = 0; i < courseList1.size(); i++)
            {
                Stu_course course = stu_courseService.getCourse(student.getsId(), courseList1.get(i).getcId());
                if (course != null)
                {
                    if (course.getState().equals("已选择"))
                    {
                        courseList2.add(courseList1.get(i));
                    }
                }
            }
        } else if (state.equals("超额选择"))
        {
            for (int i = 0; i < courseList1.size(); i++)
            {
                Stu_course course = stu_courseService.getCourse(student.getsId(), courseList1.get(i).getcId());
                if (course != null)
                {
                    if (course.getState().equals("超额选择"))
                    {
                        courseList2.add(courseList1.get(i));
                    }
                }
            }
        } else if (state.equals("未选择"))
        {
            for (int i = 0; i < courseList1.size(); i++)
            {
                Stu_course course = stu_courseService.getCourse(student.getsId(), courseList1.get(i).getcId());
                if (course != null)
                {
                    if (course.getState().equals("未选择"))
                    {
                        courseList2.add(courseList1.get(i));
                    }
                }
            }
        }
        List<Course> allCourses = new ArrayList<>(courseList2);
        session.setAttribute("allCourses", allCourses);
        if (courseList2.size() > 5)
        {
            courseList2 = courseList2.subList(0, 5);
        }
        session.setAttribute("courseNow", courseList2);
        session.setAttribute("s_sc_totalPages", (int) Math.ceil(allCourses.size() / 5.0));
        session.setAttribute("s_sc_currentPages", (Integer) page);
        return "selectCourse";
    }

    @RequestMapping(value = "/select/{cid}/{page}", method = RequestMethod.GET)
    public String selectOrDelete(
            @PathVariable(value = "cid")
            Long cid,
            @PathVariable(value = "page")
            int page,
            HttpSession session
    )
    {
        Student student = (Student) session.getAttribute("student");
        Stu_course course = stu_courseService.getCourse(student.getsId(), cid);
        if (course.getState().equals("待选择"))
        {//选课
            Course courseByCid = courseService.getCourseByCid(cid);
            if (courseByCid.getMaxNumber() > courseByCid.getNowNum())
            {
                stu_courseService.updateState(student.getsId(), cid, "已选择");
            }
            if (courseByCid.getMaxNumber() <= courseByCid.getNowNum())
            {
                stu_courseService.updateState(student.getsId(), cid, "超额选择");
            }
            //已选人数+1
            courseService.updateCourseNowNum(cid, 1);
        } else if (course.getState().equals("已选择"))
        {//退课
            stu_courseService.updateState(student.getsId(), cid, "待选择");
            Course courseByCid2 = courseService.getCourseByCid(cid);
            if (courseByCid2.getMaxNumber() >= courseByCid2.getNowNum())
            {
                //已选人数-1
                courseService.updateCourseNowNum(cid, -1);
            } else
            {
                //max<now
                //选一个超额变成已选择
                List<Stu_course> state = stu_courseService.getByCidAndState(cid, "超额选择");
                if (!state.isEmpty())
                {
                    stu_courseService.updateState(state.getFirst().getStUid(), cid, "已选择");
                }
                //已选人数-1
                courseService.updateCourseNowNum(cid, -1);
            }
        } else if (course.getState().equals("超额选择"))
        {
            stu_courseService.updateState(student.getsId(), cid, "待选择");
            courseService.updateCourseNowNum(cid, -1);
        }
        List<Course> allCourses = (List<Course>) session.getAttribute("allCourses");
        List<Course> newAllCourses = new ArrayList<>();
        for (int i = 0; i < allCourses.size(); i++)
        {
            Course courseByCid = courseService.getCourseByCid(allCourses.get(i).getcId());
            newAllCourses.add(courseByCid);
        }
        session.setAttribute("allCourses", newAllCourses);
        return "redirect:/student/selectCourse1?page=" + page;
    }


    @RequestMapping(value = "/showCourse", method = RequestMethod.GET)
    public String mySelectedCourse(HttpSession session)
    {
        Student student = (Student) session.getAttribute("student");
        List<Stu_course> courseByState = stu_courseService.getByState(student.getsId(), "已选择");
        courseByState.addAll(stu_courseService.getByState(student.getsId(), "超额选择"));
        List<Course> allCourse = courseService.getAllCourse();
        session.setAttribute("allCourses", allCourse);
        List<Course> myCourses = new ArrayList<>();
        double score = 0;
        int totalPages = 1;
        if (courseByState == null)
        {
            System.out.println("null");
        } else
        {
            for (int i = 0; i < courseByState.size(); i++)
            {
                Course myCourse = courseService.getCourseByCid(courseByState.get(i).getcId());
                myCourses.add(myCourse);
                score += myCourse.getCredit();
            }
        }
        session.setAttribute("myCourses", myCourses);
        session.setAttribute("myCourses_copy", myCourses);
        List<Course> courseList = new ArrayList<>();
        if (myCourses != null)
        {
            totalPages = (int) Math.ceil(myCourses.size() / 5.0);
            if (myCourses.size() > 5)
            {
                for (int i = 0; i < 5; i++)
                {
                    courseList.add(myCourses.get(i));
                }
            } else
            {
                courseList.addAll(myCourses);
            }
        }
        List<Stu_course> chao1 = stu_courseService.getByState(student.getsId(), "超额选择");
        session.setAttribute("chao", chao1);
        session.setAttribute("score", score);
        session.setAttribute("pgc", courseList);
        session.setAttribute("pgc2", (Integer) 1);
        totalPages = totalPages == 0 ? 1 : totalPages;
        session.setAttribute("curpgc", totalPages);
        return "mySelectedCourse";
    }

    /*
     *       myCourses   session      all course I choose
     *       myCourses_copy   session  copy
     *       chao        session      course which over-selected   \
     *       score       session      credit student choose        \
     *       pgc         session      5 courses(or less)
     *       pgc2        session      now page
     *       curpgc      session      total pages
     * */
    @RequestMapping(value = "/showCourse1", method = RequestMethod.GET)
    public String getShowCourse2(
            @RequestParam(value = "page")
            Integer page,
            HttpSession session
    )
    {
        session.setAttribute("pgc2", page);
        List<Course> courseList = new ArrayList<>();
        List<Course> myCourses = (List<Course>) session.getAttribute("myCourses");
        for (int i = 5 * (page - 1); i < 5 * page; i++)
        {//page:2   5-9
            if (myCourses.size() < i + 1)
            {
                break;
            }
            courseList.add(myCourses.get(i));
        }
        session.setAttribute("pgc", courseList);
        session.setAttribute("curpgc", (int) Math.ceil(myCourses.size() / 5.0));

        return "mySelectedCourse";
    }


    @RequestMapping(value = "/showCourse2", method = RequestMethod.POST)
    public String getShowCourse2(
            @RequestParam(value = "cname")
            String cname,
            @RequestParam(value = "tName")
            String tName,
            @RequestParam(value = "cNum")
            String cNum,
            @RequestParam(value = "cState")
            String state,
            @RequestParam(value = "department")
            String department,
            HttpSession session
    )
    {
//        List<Course> myCourses = (List<Course>)session.getAttribute("myCourses");
        List<Course> myCourses = (List<Course>) session.getAttribute("myCourses_copy");
        List<Course> cTemp = new ArrayList<>();
        List<Course> cTemp2 = new ArrayList<>();
        if (myCourses != null)
        {
            if (!Objects.equals(cname, ""))
            {
                for (int i = 0; i < myCourses.size(); i++)
                {
                    if (myCourses.get(i).getcName().contains(cname))
                    {
                        cTemp.add(myCourses.get(i));
                    }
                }
            } else
            {
                cTemp.addAll(myCourses);
            }
            if (!Objects.equals(tName, "") && (!cTemp.isEmpty()))
            {
                for (int i = 0; i < cTemp.size(); i++)
                {
                    if (cTemp.get(i).getTeacher().contains(tName))
                    {
                        cTemp2.add(cTemp.get(i));
                    }
                }
            } else
            {
                cTemp2.addAll(cTemp);
            }
            cTemp.clear();
            if (!Objects.equals(cNum, "") && (!cTemp2.isEmpty()))
            {
                for (int i = 0; i < cTemp2.size(); i++)
                {
                    if (cTemp2.get(i).getcNumber().contains(cNum))
                    {
                        cTemp.add(cTemp2.get(i));
                    }
                }
            } else
            {
                cTemp.addAll(cTemp2);
            }
            cTemp2.clear();
            if (!Objects.equals(state, "") && (!cTemp.isEmpty()))
            {
                for (int i = 0; i < cTemp.size(); i++)
                {
                    if (cTemp.get(i).getcStart().equals(state))
                    {
                        cTemp2.add(cTemp.get(i));
                    }
                }
            } else
            {
                cTemp2.addAll(cTemp);
            }
            cTemp.clear();
            if (!Objects.equals(department, "") && (!cTemp2.isEmpty()))
            {
                for (int i = 0; i < cTemp2.size(); i++)
                {
                    if (cTemp2.get(i).getDepartment().contains(department))
                    {
                        cTemp.add(cTemp2.get(i));
                    }
                }
            } else
            {
                cTemp.addAll(cTemp2);
            }
            cTemp2.clear();
        }
        int totalPages = 1;
        if (!cTemp.isEmpty())
        {
            totalPages = (int) Math.ceil(cTemp.size() / 5.0);
        }
        List<Course> allC = new ArrayList<>(cTemp);
        session.setAttribute("myCourses", allC);
        if (cTemp.size() > 5)
        {
            cTemp = cTemp.subList(0, 5);
        }
        session.setAttribute("pgc", cTemp);
        session.setAttribute("pgc2", (Integer) 1);
        session.setAttribute("curpgc", totalPages);
        return "mySelectedCourse";
    }

    @RequestMapping(value = "/stuCourseTable", method = RequestMethod.GET)
    public String showCourseTable(HttpSession session, Model model)
    {
        Student student = (Student) session.getAttribute("student");
        List<Stu_course> courseServiceByState = stu_courseService.getByState(student.getsId(), "已选择");
        courseServiceByState.addAll(stu_courseService.getByState(student.getsId(), "超额选择"));
        List<Course> courseList = new ArrayList<>();
        if (courseServiceByState != null)
        {
            for (int i = 0; i < courseServiceByState.size(); i++)
            {
                Course courseByCid = courseService.getCourseByCid(courseServiceByState.get(i).getcId());
                courseList.add(courseByCid);
                System.out.println(courseByCid);
            }
        }
        System.out.println(courseList);
        model.addAttribute("courseChosen", courseList);
        return "stuCourseTable";
    }

    @RequestMapping(value = "/back", method = RequestMethod.GET)
    public String goBackToLogin(HttpSession session)
    {
        session.removeAttribute("student");
        return "redirect:/";
    }
}
