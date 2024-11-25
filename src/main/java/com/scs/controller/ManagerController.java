package com.scs.controller;

import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;
import com.scs.bean.Course;
import com.scs.bean.Manager;
import com.scs.bean.Stu_course;
import com.scs.bean.Student;
import com.scs.service.CourseService;
import com.scs.service.ManagerService;
import com.scs.service.Stu_courseService;
import com.scs.service.StudentService;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
/**
 *
 * @author 徐豪智
 * @description   管理员管理系统
 */
@Controller
@RequestMapping("/manager")
public class ManagerController
{
    @Autowired
    private ManagerService managerService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private Stu_courseService stu_courseService;

    /**
     * 判断管理员是否存在，若存在则加入，同时实现10天内免登录
     * @param username  账号编号
     * @param password  密码
     * @param remember  是否10天免登录
     * @param session   会话记忆，传递参数
     * @param model     传递参数
     * @param request   请求
     * @param response  响应
     * @return JSP页面
     */
    @RequestMapping(method = RequestMethod.POST)
    public String judgeManager(
            @RequestParam(value = "username")
            String username,
            @RequestParam(value = "password")
            String password,
            @RequestParam(value = "remember",required = false)
            String remember,
            HttpSession session,
            Model model,
            HttpServletRequest request,
            HttpServletResponse response
    )
    {
        Manager manager = managerService.getByNumberAndPwd(username, password);
        if (manager == null)
        {
            model.addAttribute("magLoginError", 1);
            return "error";
        } else
        {
            //用户登陆成功
            session.setAttribute("manager", manager);
            if (remember!=null){
                //十天内免登录
                Cookie cookie1 = new Cookie("username",username);
                Cookie cookie2 = new Cookie("password", password);
                cookie1.setMaxAge(60*60*24*10);//十天
                cookie2.setMaxAge(60*60*24*10);
                response.addCookie(cookie1);
                response.addCookie(cookie2);
                System.out.println(cookie2.getValue());
            }
            return "redirect:/manager/mainPage";
        }
    }

    /**
     * 跳转到管理员主页
     * @param model
     * @return stuMainPage
     */
    @RequestMapping(value = "/mainPage", method = RequestMethod.GET)
    public String showManagerMainPage(Model model)
    {
        List<Student> students = studentService.getAll();
        List<Course> allCourse = courseService.getAllCourse();
        List<Manager> managers = managerService.getAll();
        int stuNum = students.size();
        int couNum = allCourse.size();
        int magNum = managers.size();
        int delMag = 0;
        for (int i = 0; i < magNum; i++)
        {
            if (managers.get(i).getState().equals("1"))
            {
                delMag++;
            }
        }
        int delStu = 0;
        for (int i = 0; i < stuNum; i++)
        {
            Long sid = students.get(i).getsId();
            if (stu_courseService.getByState(sid, "已选择").isEmpty()
                    && stu_courseService.getByState(sid, "超额选择").isEmpty())
            {
                delStu++;
            }
        }
        int overCou = 0;
        for (int i = 0; i < couNum; i++)
        {
            if (allCourse.get(i).getNowNum() > allCourse.get(i).getMaxNumber())
            {
                overCou++;
            }
        }
        int zeroCou = 0;
        for (int i = 0; i < couNum; i++)
        {
            if (allCourse.get(i).getNowNum() == 0)
            {
                zeroCou++;
            }
        }
        model.addAttribute("stuNum", stuNum);
        model.addAttribute("couNum", couNum);
        model.addAttribute("magNum", magNum);
        model.addAttribute("delMag", delMag);
        model.addAttribute("delStu", delStu);
        model.addAttribute("overCou", overCou);
        model.addAttribute("zeroCou", zeroCou);
        return "managerMainPage";
    }

    /**
     * 更新管理员信息
     * @param mid
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateMag/{mid}", method = RequestMethod.GET)
    public String updateManager(
            @PathVariable("mid")
            Long mid,
            Model model
    )
    {
        Manager byMid = managerService.getByMid(mid);
        model.addAttribute("mag", byMid);
        return "updateMag";
    }

    @RequestMapping(value = "/updateMagInfo", method = RequestMethod.POST)
    public String updateMagInfo(
            @RequestParam(value = "mid")
            Long mid,
            @RequestParam(value = "mnumber")
            String mnumber,
            @RequestParam(value = "password")
            String password,
            @RequestParam(value = "mname")
            String mname,
            @RequestParam(value = "email")
            String email,
            Model model,
            HttpSession session
    )
    {
        managerService.updateManagerInfo(mid, mname, mnumber, password, email);
        session.setAttribute("manager", managerService.getByMid(mid));
        return "redirect:/manager/mainPage";
    }

    /**
     * 显示学生信息
     * @param page
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/stuInfo", method = RequestMethod.GET)
    public String showStudentInfo(
            @RequestParam(value = "page")
            String page,
            HttpSession session, Model model
    )
    {
        List<Student> students = studentService.getAll();
        session.setAttribute("studentList", students);
        List<Student> showStu = new ArrayList<>();
        if (page == null || Integer.parseInt(page) == 1)
        {
            if (students.size() > 5)
            {
                for (int i = 0; i < 5; i++)
                {
                    showStu.add(students.get(i));
                }
            } else
            {
                showStu.addAll(students);
            }
            model.addAttribute("showStu", showStu);
            model.addAttribute("pg", 1);
            model.addAttribute("totalPg", (int) Math.ceil(students.size() / 5.0));
        } else
        {
            int pageI = Integer.parseInt(page);
            for (int i = 5 * (pageI - 1); i < 5 * pageI; i++)
            {
                if (i > studentService.getAll().size() - 1)
                {
                    break;
                }
                showStu.add(studentService.getAll().get(i));
            }
            model.addAttribute("showStu", showStu);
            model.addAttribute("pg", pageI);
            model.addAttribute("totalPg", (int) Math.ceil(studentService.getAll().size() / 5.0));
        }
        int delStu = 0;
        for (int i = 0; i < students.size(); i++)
        {
            if (stu_courseService.getByState(students.get(i).getsId(), "已选择").isEmpty() &&
                    stu_courseService.getByState(students.get(i).getsId(), "超额选择").isEmpty())
            {
                delStu++;
            }
        }
        session.setAttribute("zeroStu", delStu);

        int lowerFifteen = 0;
        List<Course> allCourse = courseService.getAllCourse();
        for (int i = 0; i < students.size(); i++)
        {
            List<Stu_course> byState = stu_courseService.getByState(students.get(i).getsId(), "已选择");
            byState.addAll(stu_courseService.getByState(students.get(i).getsId(), "超额选择"));
            int sum = 0;
            for (int j = 0; j < byState.size(); j++)
            {
                for (int k = 0; k < allCourse.size(); k++)
                {
                    if (Objects.equals(allCourse.get(k).getcId(), byState.get(j).getcId()))
                    {
                        sum += allCourse.get(k).getCredit();
                    }
                }
            }
            if (sum < 15)
            {
                lowerFifteen++;
            }
        }
        session.setAttribute("lowFifteen", lowerFifteen);
        return "studentInfo";
    }

    /**
     * 也是显示学生信息，此处主要处理查询后分页的bug
     * @param page
     * @param session
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/stuInfo2", method = RequestMethod.GET)
    public String showStuInfoBySearchAndGet(
            @RequestParam("page")
            String page,
            HttpSession session,
            Model model,
            HttpServletRequest request
    ){
        int pages=Integer.parseInt(page);
        List<Student> checkedStu = (List<Student>)session.getAttribute("CheckedStu");
        List<Student> studentList1=new ArrayList<>();
        for(int i=5*(pages-1);i<5*pages;i++){
            if (i>checkedStu.size()-1){
                break;
            }
            studentList1.add(checkedStu.get(i));
        }
        model.addAttribute("showStu",studentList1);
        model.addAttribute("pg", pages);
        model.addAttribute("uri",request.getServletPath());
        model.addAttribute("totalPg", (int) Math.ceil(checkedStu.size() / 5.0));
        return "studentInfo";
    }

    @RequestMapping(value = "/stuInfo2", method = RequestMethod.POST)
    public String showStuInfoBySearch(
            @RequestParam("sname")
            String sname,
            @RequestParam("snumber")
            String snumber,
            @RequestParam("grade")
            String grade,
            @RequestParam("department")
            String department,
            Model model,
            HttpServletRequest request,
            HttpSession session
    )
    {
        List<Student> students = studentService.getAll();
        List<Student> studentList1 = new ArrayList<>();
        List<Student> studentList2 = new ArrayList<>();
        if (sname.equals(""))
        {
            studentList1.addAll(students);
        } else
        {
            for (int i = 0; i < students.size(); i++)
            {
                if (students.get(i).getsName().contains(sname))
                {
                    studentList1.add(students.get(i));
                }
            }
        }
        if (snumber.equals(""))
        {
            studentList2.addAll(studentList1);
        } else
        {
            for (int i = 0; i < studentList1.size(); i++)
            {
                if (studentList1.get(i).getsNumber().contains(snumber))
                {
                    studentList2.add(studentList1.get(i));
                }
            }
        }
        studentList1.clear();
        if (grade.equals(""))
        {
            studentList1.addAll(studentList2);
        } else
        {
            for (int i = 0; i < studentList2.size(); i++)
            {
                if (studentList2.get(i).getGrade().contains(grade))
                {
                    studentList1.add(studentList2.get(i));
                }
            }
        }
        studentList2.clear();
        if (department.equals(""))
        {
            studentList2.addAll(studentList1);
        } else
        {
            for (int i = 0; i < studentList1.size(); i++)
            {
                if (studentList1.get(i).getDepartment().contains(department))
                {
                    studentList2.add(studentList1.get(i));
                }
            }
        }
        session.setAttribute("CheckedStu",studentList2);
        model.addAttribute("totalPg", (int) Math.ceil(studentList2.size() / 5.0));
        if (studentList2.size()>5){
            studentList2 = studentList2.subList(0, 5);
        }
        model.addAttribute("showStu", studentList2);
        model.addAttribute("pg", 1);
        model.addAttribute("uri",request.getServletPath());
        System.out.println("  1:  "+request.getServletPath());
        return "studentInfo";
    }


    /**
     * 删除学生信息
     * @param sid
     * @param pg
     * @param model
     * @return
     */
    @RequestMapping(value = "/stuInfo/delete/{sid}/{pg}")
    public String deleteStu(
            @PathVariable(value = "sid")
            Long sid,
            @PathVariable(value = "pg")
            int pg,
            Model model
    )
    {
        Student studentBySid = studentService.getStudentBySid(sid);
        if (studentBySid == null)
        {
            model.addAttribute("error2", "dont has stu");
            return "error";
        } else
        {
            studentService.deleteBySid(sid);
            List<Stu_course> courseServiceByState = stu_courseService.getByState(sid, "已选择");
            if (!courseServiceByState.isEmpty())
            {
                for (int i = 0; i < courseServiceByState.size(); i++)
                {
                    courseService.updateCourseNowNum(courseServiceByState.get(i).getcId(), -1);
                }
            }
            stu_courseService.deleteByStuid(sid);
            List<Student> students = studentService.getAll();
            if ((int) Math.ceil(students.size() / 5.0) < pg && pg != 1)
            {
                pg--;
            }
            return "redirect:/manager/stuInfo?page=" + pg;
        }
    }

    /**
     * 更新学生信息
     * @param sid
     * @param pg
     * @param model
     * @return
     */
    @RequestMapping(value = "/stuInfo/update/{sid}/{pg}", method = RequestMethod.POST)
    public String toUpdateStu(
            @PathVariable(value = "sid")
            Long sid,
            @PathVariable(value = "pg")
            Long pg,
            Model model
    )
    {
        Student studentBySid = studentService.getStudentBySid(sid);
        if (studentBySid == null)
        {
            model.addAttribute("error2", "no stu");
            return "error";
        } else
        {
            model.addAttribute("updateStu", studentBySid);
            model.addAttribute("page", pg);
            return "updateStu";
        }
    }

    @RequestMapping(value = "/stuInfo/updateStu/{page}", method = RequestMethod.POST)
    public String updateStu(
            @PathVariable(value = "page")
            int page,
            @RequestParam("snumber")
            String snumber,
            @RequestParam("sname")
            String sname,
            @RequestParam("password")
            String password,
            @RequestParam("grade")
            String grade,
            @RequestParam("department")
            String department,
            @RequestParam("email")
            String email,
            Model model
    )
    {
        Student studentBySnumber = studentService.getStudentBySnumber(snumber);
        int count = studentService.updateStu(studentBySnumber.getsId(), sname, password, grade, department, email);
        if (count != 1)
        {
            model.addAttribute("error3", "false");
            return "error";
        } else
        {
            return "redirect:/manager/stuInfo?page=" + page;
        }

    }

    /**
     * 增加学生信息
     * @return
     */
    @RequestMapping(value = "/stuInfo/toAddStu")
    public String toAddStu()
    {
        return "addStu";
    }

    @RequestMapping(value = "/stuInfo/add")
    public String addStu(
            @RequestParam("sname")
            String sname,
            @RequestParam("snumber")
            String snumber,
            @RequestParam("password")
            String password,
            @RequestParam("grade")
            String grade,
            @RequestParam("department")
            String department,
            @RequestParam("email")
            String email,
            Model model
    )
    {
        System.out.println("sname:" + sname);
        System.out.println("snumber:" + snumber);
        System.out.println("password:" + password);
        System.out.println("grade:" + grade);
        System.out.println("department:" + department);
        System.out.println("email:" + email);
        Student stu = studentService.getStudentBySnumber(snumber);
        if (stu == null)
        {
            studentService.addOne(sname, snumber, password, email, grade, department);
            return "redirect:/manager/stuInfo?page=1";
        } else
        {
            model.addAttribute("error1", "HadStuError");
            return "error";
        }
    }

    /**
     * 管理员账号管理
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/managerInfo/{mPage}", method = RequestMethod.GET)
    public String managerInfo(
            @PathVariable(value = "mPage")
            int page,
            Model model
    )
    {
        List<Manager> managers = managerService.getAll();
        model.addAttribute("managers", managers);
        List<Manager> managerList = new ArrayList<>();
        for (int i = 5 * (page - 1); i < 5 * page; i++)
        {
            if (i > managers.size() - 1)
            {
                break;
            }
            managerList.add(managers.get(i));
        }
        model.addAttribute("managerList", managerList);
        model.addAttribute("nowPage", page);
        model.addAttribute("totalPage", (int) Math.ceil(managers.size() / 5.0));
        return "managerInfo";
    }

    /**
     * 处理管理员界面翻页后信息的获取与展示
     * @param page
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/managerInfo2/{page}",method = RequestMethod.GET)
    public String managerInfoBySearchAndGet(
            @PathVariable(value = "page")
            int page,
            Model model,
            HttpSession session,
            HttpServletRequest request
    ){
        List<Manager> checkedMag = (List<Manager>)session.getAttribute("CheckedMag");
        List<Manager> managerList1=new ArrayList<>();
        for (int i=5*(page-1);i<5*page;i++){
            if (i>checkedMag.size()-1){
                break;
            }
            managerList1.add(checkedMag.get(i));
        }
        model.addAttribute("uri",request.getServletPath());
        model.addAttribute("totalPage", (int) Math.ceil(checkedMag.size() / 5.0));
        model.addAttribute("managerList", managerList1);
        model.addAttribute("nowPage", page);
        return "managerInfo";
    }

    /**
     * 处理查询后分页的bug
     * @param mname
     * @param mnumber
     * @param state
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/managerInfo2", method = RequestMethod.POST)
    public String managerInfoBySearch(
            @RequestParam("mname")
            String mname,
            @RequestParam("mnumber")
            String mnumber,
            @RequestParam("state")
            String state,
            Model model,
            HttpSession session,
            HttpServletRequest request
    )
    {
        List<Manager> managers = managerService.getAll();
        List<Manager> managerList1 = new ArrayList<>();
        List<Manager> managerList2 = new ArrayList<>();
        if (mname.equals(""))
        {
            managerList1.addAll(managers);
        } else
        {
            for (int i = 0; i < managers.size(); i++)
            {
                if (managers.get(i).getmName().contains(mname))
                {
                    managerList1.add(managers.get(i));
                }
            }
        }
        if (mnumber.equals(""))
        {
            managerList2.addAll(managerList1);
        } else
        {
            for (int i = 0; i < managerList1.size(); i++)
            {
                if (managerList1.get(i).getmNumber().contains(mnumber))
                {
                    managerList2.add(managerList1.get(i));
                }
            }
        }
        managerList1.clear();
        if (state.equals(""))
        {
            managerList1.addAll(managerList2);
        } else if (state.equals("未删除"))
        {
            for (int i = 0; i < managerList2.size(); i++)
            {
                if (managerList2.get(i).getState().contains("0"))
                {
                    managerList1.add(managerList2.get(i));
                }
            }
        } else if (state.equals("已删除"))
        {
            for (int i = 0; i < managerList2.size(); i++)
            {
                if (managerList2.get(i).getState().contains("1"))
                {
                    managerList1.add(managerList2.get(i));
                }
            }
        }
        session.setAttribute("CheckedMag",managerList1);
        model.addAttribute("uri",request.getServletPath());
        model.addAttribute("totalPage", (int) Math.ceil(managerList1.size() / 5.0));
        if (managerList1.size()>5){
            managerList1 = managerList1.subList(0, 5);
        }
        model.addAttribute("managerList", managerList1);
        model.addAttribute("nowPage", 1);

        return "managerInfo";
    }

    /**
     * 管理员信息的删除
     * @param mid
     * @param nowPage
     * @return
     */
    @RequestMapping(value = "/managerInfo/delete/{mid}/{nowPage}")
    public String managerDelete(
            @PathVariable("mid")
            Long mid,
            @PathVariable(value = "nowPage")
            int nowPage
    )
    {
        managerService.deleteManager(mid);
        return "redirect:/manager/managerInfo/" + nowPage;
    }

    @RequestMapping(value = "/managerInfo/toAddStu", method = RequestMethod.GET)
    public String toAddManager()
    {
        return "addMag";
    }

    @RequestMapping(value = "/managerInfo/add", method = RequestMethod.POST)
    public String addManager(
            @RequestParam("mname")
            String mname,
            @RequestParam("password")
            String password,
            @RequestParam("email")
            String email,
            @RequestParam("mnumber")
            String mnumber
    )
    {
        System.out.println(mnumber);
        managerService.addOne(mname, password, email, mnumber);
        return "redirect:/manager/managerInfo/1";
    }

    /**
     * 课程管理
     *
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/courseInfo/{page}", method = RequestMethod.GET)
    public String showCourse(
            @PathVariable(value = "page")
            int page,
            HttpSession session, Model model)
    {
        List<Course> allCourse = courseService.getAllCourse();
        session.setAttribute("courses", allCourse);
        List<Course> courseList = new ArrayList<>();
        for (int i = 5 * (page - 1); i < 5 * page; i++)
        {
            if (i > allCourse.size() - 1)
            {
                break;
            }
            courseList.add(allCourse.get(i));
        }
        model.addAttribute("showC", courseList);
        model.addAttribute("nowPage", page);
        model.addAttribute("totalPage", (int) Math.ceil(allCourse.size() / 5.0));
        return "courseInfo";
    }

    @RequestMapping(value = "/courseInfo2", method = RequestMethod.POST)
    public String showCourseBySearch(
            @RequestParam("cname")
            String cname,
            @RequestParam("cnumber")
            String cnumber,
            @RequestParam("teacher")
            String teacher,
            @RequestParam("location")
            String location,
            @RequestParam("ctime")
            String ctime,
            Model model,
            HttpSession session,
            HttpServletRequest request
    )
    {
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
        if (location.equals(""))
        {
            courseList2.addAll(courseList1);
        } else
        {
            for (int i = 0; i < courseList1.size(); i++)
            {
                if (courseList1.get(i).getLocation().contains(location))
                {
                    courseList2.add(courseList1.get(i));
                }
            }
        }
        courseList1.clear();
        if (ctime.equals(""))
        {
            courseList1.addAll(courseList2);
        } else
        {
            for (int i = 0; i < courseList2.size(); i++)
            {
                if (courseList2.get(i).getcDay().contains(ctime))
                {
                    courseList1.add(courseList2.get(i));
                }
            }
        }
        //courseList1  所有符合条件的课程
        model.addAttribute("totalPage", (int) Math.ceil(courseList1.size() / 5.0));
        model.addAttribute("uri",request.getServletPath());
        session.setAttribute("CheckedCourse",courseList1);
        if (courseList1.size()>5){
            courseList1 = courseList1.subList(0, 5);
        }
        model.addAttribute("showC", courseList1);
        model.addAttribute("nowPage", 1);

        return "courseInfo";
    }

    /**
     * 处理课程管理翻页的信息的筛选与展示
     * @param page
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/courseInfo2/{page}",method = RequestMethod.GET)
    public String showCourseBySearchAndGet(
            @PathVariable(value = "page")
            int page,
            Model model,
            HttpSession session,
            HttpServletRequest request
    ){
        List<Course> checkedCourse = (List<Course>)session.getAttribute("CheckedCourse");
        List<Course> courseList1=new ArrayList<>();
        for(int i=5*(page-1);i<5*page;i++){
            if (i>checkedCourse.size()-1){
                break;
            }
            courseList1.add(checkedCourse.get(i));
        }
        //checkedCourse  所有符合条件的课程
        model.addAttribute("totalPage", (int) Math.ceil(checkedCourse.size() / 5.0));
        model.addAttribute("uri",request.getServletPath());

        model.addAttribute("showC", courseList1);
        model.addAttribute("nowPage", page);
        return "courseInfo";
    }

    /**
     * 显示课程的详细信息
     * @param cid
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "/courseInfo/more/{cid}/{page}", method = RequestMethod.POST)
    public String showMore(
            @PathVariable("cid")
            Long cid,
            @PathVariable("page")
            int page,
            Model model)
    {
        System.out.println(cid);
        Course courseByCid = courseService.getCourseByCid(cid);
        System.out.println(courseByCid);
        model.addAttribute("course", courseByCid);
        model.addAttribute("page", page);
        return "courseMore";
    }

    /**
     * 课程的删除操作
     * @param cid
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "/courseInfo/delete/{cid}/{nowPage}", method = RequestMethod.POST)
    public String deleteCourse(
            @PathVariable("cid")
            Long cid,
            @PathVariable("nowPage")
            int page,
            Model model)
    {
        courseService.deleteByCid(cid);
        stu_courseService.deleteByCid(cid);
        List<Course> allCourse = courseService.getAllCourse();
        if ((int) Math.ceil(allCourse.size() / 5.0) < page)
        {
            page--;
        }
        return "redirect:/manager/courseInfo/" + page;
    }

    /**
     * 课程的添加操作
     * @return
     */
    @RequestMapping(value = "/courseInfo/toAdd", method = RequestMethod.GET)
    public String toAddCourse()
    {
        return "addCourse";
    }


    @RequestMapping(value = "/courseInfo/add", method = RequestMethod.POST)
    public String addCourse(
            @RequestParam("cname") String cname, @RequestParam("cnumber") String cnumber,
            @RequestParam("teacher") String teacher, @RequestParam("credit") Double credit,
            @RequestParam("department") String department, @RequestParam("location") String location,
            @RequestParam("maxNumber") Integer maxNumber, @RequestParam("cYear1") Integer cYear1,
            @RequestParam("cMonth1") Integer cMonth1, @RequestParam("cDay1") Integer cDay1,
            @RequestParam("time") String time, @RequestParam("day") String day,
            @RequestParam("description") String description, @RequestParam("cYear2") Integer cYear2,
            @RequestParam("cMonth2") Integer cMonth2, @RequestParam("cDay2") Integer cDay2,
            ServletResponse response, ServletRequest request
    )
    {
        String cStart = cYear1.toString() + "年" + cMonth1.toString() + "月" + cDay1.toString() + "日";
        String cEnd = cYear2.toString() + "年" + cMonth2.toString() + "月" + cDay2.toString() + "日";
        String changedDescription = (String) request.getAttribute("changedDescription");
        courseService.addOne(cnumber, cname, teacher, department, maxNumber, cStart,
                cEnd, day, time, changedDescription, location, credit);
        return "redirect:/manager/courseInfo/1";
    }

    /**
     * 课程信息的更新操作
     * @param cid
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "/courseInfo/toUpdate/{cid}/{nowPage}", method = RequestMethod.POST)
    public String toUpdateCourse(
            @PathVariable("cid")
            Long cid,
            @PathVariable("nowPage")
            int page,
            Model model
    )
    {
        Course courseByCid = courseService.getCourseByCid(cid);
        model.addAttribute("course", courseByCid);
        model.addAttribute("page", page);
        return "updateCourse";
    }

    @RequestMapping(value = "/courseInfo/update/{page}", method = RequestMethod.POST)
    public String updateCourse(@RequestParam("cid") Long cid,
                               @PathVariable("page") int page,
                               @RequestParam("cname") String cname, @RequestParam("cnumber") String cnumber,
                               @RequestParam("teacher") String teacher, @RequestParam("credit") Double credit,
                               @RequestParam("department") String department, @RequestParam("location") String location,
                               @RequestParam("maxNumber") Integer maxNumber, @RequestParam("cYear1") Integer cYear1,
                               @RequestParam("cMonth1") Integer cMonth1, @RequestParam("cDay1") Integer cDay1,
                               @RequestParam("time") String time, @RequestParam("day") String day,
                               @RequestParam("description") String description, @RequestParam("cYear2") Integer cYear2,
                               @RequestParam("cMonth2") Integer cMonth2, @RequestParam("cDay2") Integer cDay2,
                               ServletResponse response, ServletRequest request
    )
    {
        String cStart = cYear1.toString() + "年" + cMonth1.toString() + "月" + cDay1.toString() + "日";
        String cEnd = cYear2.toString() + "年" + cMonth2.toString() + "月" + cDay2.toString() + "日";
        String changedDescription = (String) request.getAttribute("changedDescription");
        courseService.updateOne(cid, cnumber, cname, teacher, department, maxNumber, cStart, cEnd, day, time,
                changedDescription, location, credit);
        return "redirect:/manager/courseInfo/" + page;
    }

    /**
     * 显示分页后的选课信息
     * @param page
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/selectInfo/{page}", method = RequestMethod.GET)
    public String showSelect(
            @PathVariable(value = "page")
            int page,
            HttpSession session,
            Model model
    )
    {
        List<Course> allCourse = courseService.getAllCourse();
        session.setAttribute("selectCourse", allCourse);
        session.setAttribute("allCoursesSize", allCourse.size());
        List<Course> zeroCourseList = new ArrayList<>();
        List<Course> overCourseList = new ArrayList<>();
        for (int i = 0; i < allCourse.size(); i++)
        {
            if (allCourse.get(i).getNowNum() == 0)
            {
                zeroCourseList.add(allCourse.get(i));
            }
            if (allCourse.get(i).getNowNum() > allCourse.get(i).getMaxNumber())
            {
                overCourseList.add(allCourse.get(i));
            }
        }
        session.setAttribute("zeroCoursesSize", zeroCourseList.size());
        session.setAttribute("overCoursesSize", overCourseList.size());
        List<Course> showS = new ArrayList<>();
        for (int i = 5 * (page - 1); i < 5 * page; i++)
        {
            if (i > allCourse.size() - 1)
            {
                break;
            }
            showS.add(allCourse.get(i));
        }
        model.addAttribute("showS", showS);
        model.addAttribute("nowPage", page);
        model.addAttribute("totalPage", (int) Math.ceil(allCourse.size() / 5.0));
        return "selectInfo";
    }

    /**
     * 处理查询后再翻页的BUG
     * @param cname
     * @param cnumber
     * @param over
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectInfo2", method = RequestMethod.POST)
    public String showSelectBySearch(
            @RequestParam("cname")
            String cname,
            @RequestParam("cnumber")
            String cnumber,
            @RequestParam("over")
            String over,
            Model model,
            HttpSession session,
            HttpServletRequest request
    )
    {
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
        if (over.equals(""))
        {
            courseList1.addAll(courseList2);
        } else if (over.equals("是"))
        {
            for (int i = 0; i < courseList2.size(); i++)
            {
                if (courseList2.get(i).getNowNum() > courseList2.get(i).getMaxNumber())
                {
                    courseList1.add(courseList2.get(i));
                }
            }
        } else if (over.equals("否"))
        {
            for (int i = 0; i < courseList2.size(); i++)
            {
                if (courseList2.get(i).getNowNum() <= courseList2.get(i).getMaxNumber())
                {
                    courseList1.add(courseList2.get(i));
                }
            }
        } else
        {
            courseList2.clear();
        }
        model.addAttribute("totalPage", (int) Math.ceil(courseList1.size() / 5.0));
        session.setAttribute("CheckedSelect",courseList1);
        model.addAttribute("uri",request.getServletPath());
        if (courseList1.size()>5){
            courseList1 = courseList1.subList(0, 5);
        }
        model.addAttribute("showS", courseList1);
        model.addAttribute("nowPage", 1);

        return "selectInfo";
    }

    /**
     * 查询后再进行翻页
     * @param page
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectInfo2/{page}",method = RequestMethod.GET)
    public String showSelectBySearchAndGet(
            @PathVariable(value = "page")
            int page,
            Model model,
            HttpSession session,
            HttpServletRequest request
    ){
        List<Course> checkedSelect = (List<Course>)session.getAttribute("CheckedSelect");
        List<Course> selectList1=new ArrayList<>();
        for (int i=5*(page-1);i<5*page;i++){
            if (i>checkedSelect.size()-1){
                break;
            }
            selectList1.add(checkedSelect.get(i));
        }

        model.addAttribute("totalPage", (int) Math.ceil(checkedSelect.size() / 5.0));
        model.addAttribute("uri",request.getServletPath());
        model.addAttribute("showS", selectList1);
        model.addAttribute("nowPage", page);
        return "selectInfo";
    }

    /**
     * 对选课进行选课管理
     * @param cid
     * @param pageL
     * @param pageR
     * @param model
     * @return
     */
    @RequestMapping(value = "/selectInfo/select/{cid}/{pageL}/{pageR}", method = RequestMethod.GET)
    public String selectStuCourse(
            @PathVariable(value = "cid")
            Long cid,
            @PathVariable(value = "pageL")
            int pageL,
            @PathVariable(value = "pageR")
            int pageR,
            Model model
    )
    {
        Course courseByCid = courseService.getCourseByCid(cid);
        List<Stu_course> byCid = stu_courseService.getByCidAndState(cid, "已选择");
        List<Student> stu = new ArrayList<>();
        if (byCid != null)
        {
            for (int i = 0; i < byCid.size(); i++)
            {
                Long stuid1 = byCid.get(i).getStUid();
                Student studentBySid = studentService.getStudentBySid(stuid1);
                stu.add(studentBySid);
            }
        }
        model.addAttribute("selCourse", courseByCid);
        model.addAttribute("stud", stu);//已选择学生
        List<Stu_course> scOut = stu_courseService.getByCidAndState(cid, "超额选择");
        List<Student> studentsOut = new ArrayList<>();
        if (scOut != null)
        {
            for (int i = 0; i < scOut.size(); i++)
            {
                Long stuid = scOut.get(i).getStUid();
                Student studentBySid1 = studentService.getStudentBySid(stuid);
                studentsOut.add(studentBySid1);
            }
        }
        model.addAttribute("studOut", studentsOut);
        List<Student> studentsL = new ArrayList<>();
        List<Student> studentsR = new ArrayList<>();
        for (int i = 5 * (pageL - 1); i < 5 * pageL; i++)
        {
            if (i > stu.size() - 1)
            {
                break;
            }
            studentsL.add(stu.get(i));
        }
        for (int i = 5 * (pageR - 1); i < 5 * pageR; i++)
        {
            if (i > studentsOut.size() - 1)
            {
                break;
            }
            studentsR.add(studentsOut.get(i));
        }
        model.addAttribute("stuL", studentsL);
        model.addAttribute("nowL", pageL);
        model.addAttribute("nowR", pageR);
        model.addAttribute("stuR", studentsR);
        model.addAttribute("totalL", (int) Math.ceil(stu.size() / 5.0) == 0 ? 1 : (int) Math.ceil(stu.size() / 5.0));
        model.addAttribute("totalR", (int) Math.ceil(studentsOut.size() / 5.0) == 0 ? 1 : (int) Math.ceil(studentsOut.size() / 5.0));
        return "selectMore";
    }

    /**
     * 退出选课管理
     * @param sid
     * @param cid
     * @param nowL
     * @param nowR
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/backCourse", method = RequestMethod.POST)
    public String backCourseFromStu(
            @RequestParam("sid")
            Long sid,
            @RequestParam("cid")
            Long cid,
            @RequestParam("nowL")
            int nowL,
            @RequestParam("nowR")
            int nowR,
            HttpSession session,
            Model model
    )
    {
        Stu_course course = stu_courseService.getCourse(sid, cid);
        if (course.getState().equals("超额选择"))
        {
            stu_courseService.updateState(sid, cid, "待选择");
        }
        if (course.getState().equals("已选择"))
        {
            List<Stu_course> state2 = stu_courseService.getByCidAndState(cid, "超额选择");
            if (!state2.isEmpty())
            {
                stu_courseService.updateState(state2.getFirst().getStUid(), cid, "已选择");
            }
            stu_courseService.updateState(sid, cid, "待选择");
        }
        courseService.updateCourseNowNum(cid, -1);

        Course courseByCid = courseService.getCourseByCid(cid);
        model.addAttribute("selCourse", courseByCid);
        List<Stu_course> state1 = stu_courseService.getByCidAndState(cid, "已选择");
        List<Stu_course> state2 = stu_courseService.getByCidAndState(cid, "超额选择");
        List<Student> students1 = new ArrayList<>();
        List<Student> students2 = new ArrayList<>();
        for (int i = 0; i < state1.size(); i++)
        {
            Student studentBySid = studentService.getStudentBySid(state1.get(i).getStUid());
            students1.add(studentBySid);
        }
        for (int i = 0; i < state2.size(); i++)
        {
            Student studentBySid2 = studentService.getStudentBySid(state2.get(i).getStUid());
            students2.add(studentBySid2);
        }
        model.addAttribute("stud", students1);
        model.addAttribute("studOut", students2);
        if (nowL > (int) Math.ceil(students1.size() / 5.0) && nowL != 1)
        {
            nowL--;
        }
        if (nowR > (int) Math.ceil(students2.size() / 5.0) && nowR != 1)
        {
            nowR--;
        }
        List<Student> studentList1 = new ArrayList<>();
        List<Student> studentList2 = new ArrayList<>();
        for (int i = 5 * (nowL - 1); i < 5 * nowL; i++)
        {
            if (i > students1.size() - 1)
            {
                break;
            }
            studentList1.add(students1.get(i));
        }
        for (int i = 5 * (nowR - 1); i < 5 * nowR; i++)
        {
            if (i > students2.size() - 1)
            {
                break;
            }
            studentList2.add(students2.get(i));
        }
        model.addAttribute("stuL", studentList1);
        model.addAttribute("stuR", studentList2);
        model.addAttribute("nowL", nowL);
        model.addAttribute("nowR", nowR);
        model.addAttribute("totalL", (int) Math.ceil(students1.size() / 5.0) == 0 ? 1 : (int) Math.ceil(students1.size() / 5.0));
        model.addAttribute("totalR", (int) Math.ceil(students2.size() / 5.0) == 0 ? 1 : (int) Math.ceil(students2.size() / 5.0));
        return "selectMore";
    }

    /**
     * 退出管理员管理系统到登录界面
     * @param session
     * @return
     */
    @RequestMapping(value = "/back", method = RequestMethod.GET)
    public String goBackToLogin(HttpSession session)
    {
        session.removeAttribute("manager");
        return "redirect:/";
    }
}
