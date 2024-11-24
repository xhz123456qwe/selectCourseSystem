<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ndc" uri="/WEB-INF/tld/nowDayCourse.tld" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>stuMainPage</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/head.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/stuMainPage.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css"/>">
</head>
<body>
<c:set var="stu" scope="session" value="${sessionScope.student}"/>
<header class="top">
  <div class="w">
    <div class="logo">
      <img src="<c:url value="/static/imgs/logo.png" />" alt="logo">
    </div>
    <div class="name">
      校园选课系统
    </div>
    <div class="navitems">
      <div class="navitems_in">
        <ul>
          <li>
            <a href="#" class="choose">首页</a>
          </li>
          <li><a href="<c:url value="/student/selectCourse"/>">选择课程</a></li>
          <li><a href="<c:url value="/student/showCourse"/>">已选课程</a></li>
          <li><a href="<c:url value="/student/stuCourseTable"/>">课程表</a></li>
        </ul>
      </div>
    </div>
    <div class="welcome">
      欢迎登陆,<c:out value="${stu.sName}"/>
    </div>
    <div class="back">
      <div class="backPic">
        <img src="<c:url value="/static/imgs/back.png" />" alt="back"/>
      </div>
      <a href="<c:url value="/student/back"/>" class="backWords">退出</a>
    </div>
  </div>
</header>
<br><br><br><br><br><br>
<div class="w" style="height: 826px;">
  <div class="ml">
    <div class="mlt">
      <div class="headPic">
        <img src="<c:url value="/static/imgs/pic2.png" />" alt="head2"/>
      </div>
      <div class="stuInfo">
        <div class="stuName">&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${stu.sName}"/></div>
        <div class="stuDep">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${stu.department}"/></div>
      </div>
      <div class="stuMine">&nbsp;&nbsp;&nbsp;&nbsp;个人主页</div>
    </div>
    <div class="stuRemind">
      <div class="inform">
        <div class="same">
          <img src="<c:url value="/static/imgs/inform.png" />" alt="inform"/>
        </div>
        <div class="same1">选课通知</div>
      </div>
      <div class="doing">
        <div class="same">
          <img src="<c:url value="/static/imgs/do.png" />" alt="do"/>
        </div>
        <div class="same1">我的待办</div>
      </div>
      <div class="xiaoXi">
        <div class="same">
          <img src="<c:url value="/static/imgs/msg.png" />" alt="msg"/>
        </div>
        <div class="same1">我的消息</div>
      </div>
    </div>
  </div>
  <div class="mr">
    <div class="box">
      学生基本信息
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/name.png" />" alt="name"/>
      </div>
      <div class="tit">
        学生姓名
      </div>
      <div class="cont">
        <c:out value="${stu.sName}"/>
      </div>
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/number.png" />" alt="number"/>
      </div>
      <div class="tit">
        学号
      </div>
      <div class="cont">
        <c:out value="${stu.sNumber}"/>
      </div>
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/pwd.png" />" alt="pwd"/>
      </div>
      <div class="tit">
        账号密码
      </div>
      <div class="cont">
        <c:out value="${stu.password}"/>
      </div>
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/grade.png" />" alt="grade"/>
      </div>
      <div class="tit">
        所属年级
      </div>
      <div class="cont">
        <c:out value="${stu.grade}"/>
      </div>
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/department.png" />" alt="department"/>
      </div>
      <div class="tit">
        所属学院
      </div>
      <div class="cont">
        <c:out value="${stu.department}"/>
      </div>
    </div>
    <div class="box1">
      <div class="pic">
        <img src="<c:url value="/static/imgs/mail.png" />" alt="mail"/>
      </div>
      <div class="tit">
        邮箱
      </div>
      <div class="cont">
        <c:out value="${stu.email}"/>
      </div>
    </div>
  </div>
  <div class="ml" style="height: 500px !important;">
    <div class="date">
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(3).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(3).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(2).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(2).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(1).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(1).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1" style="background-color:#2b669a; color:#ffffff;">
        <div class="day">
          <c:out value="${(nowDate.toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(-1).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(-1).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(-2).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(-2).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
      <div class="day1">
        <div class="day">
          <c:out value="${(nowDate.minusDays(-3).toString().split('-'))[2]}"/>
        </div>
        <div class="week">
          <c:out value="${(nowDate.minusDays(-3).dayOfWeek.toString()).substring(0,3)}"/>
        </div>
      </div>
    </div>
    <div class="nowDate">
      <c:out value="${nowDate.toString()}"/>&nbsp;&nbsp;&nbsp;
      <c:if test="${nowDate.month.value>=9&&nowDate.month.value<=12}">
        秋季学期
        <c:out value="${begin}"/>
      </c:if>
      <c:if test="${nowDate.month.value>=6&&nowDate.month.value<9}">
        夏季学期
      </c:if>
      <c:if test="${nowDate.month.value>=3&&nowDate.month.value<6}">
        春季学期
      </c:if>
      <c:if test="${nowDate.month.value>=1&&nowDate.month.value<3}">
        冬季学期
      </c:if>&nbsp;
      第<c:out value="${whichWeek}"/>周&nbsp;
    </div>
    <div class="course">
      <ndc:nowDayCourses courseList="${courses}" contextPath="${sessionScope.contextPath}"/>
    </div>
  </div>
  <div class="mr" style="height: 500px !important;">
    <div class="box">
      帐号状态
    </div>
    <div class="status">
      <table>
        <thead>
          <tr>
            <th>学号</th>
            <th>姓名</th>
            <th>所属学院</th>
            <th>账号失效期</th>
            <th>是否激活</th>
            <th>状态</th>
          </tr>
        </thead>
        <tbody>
          <tr class="tr1">
            <td><c:out value="${stu.sNumber}"/></td>
            <td><c:out value="${stu.sName}"/></td>
            <td><c:out value="${stu.department}"/></td>
            <td>2026年</td>
            <td>已激活</td>
            <td>正常</td>
          </tr>
        </tbody>
      </table>
    </div><br/>
    <div class="box" style="margin-top: 30px">
      密码与安全设置
    </div>
    <div class="status" style="height: 140px !important;margin-left: 10px">
      <div class="safe">
        <div class="pic1">
          <img src="<c:url value="/static/imgs/safe1.png"/>" alt="safe1"/>
        </div>
        <div class="tit2">修改密码</div>
        <div class="cont2">建议您定期更换密码，安全密码组合为含有数字、字母、特殊字符的8~20位组合</div>
        <div class="submit" style="top: 730px;">
          <input type="submit" value="修改" style="margin-top: 30px"/>
        </div>
      </div>
      <div class="safe">
        <div class="pic1">
          <img src="<c:url value="/static/imgs/safe2.png" />" alt="safe2"/>
        </div>
        <div class="tit2">
          安全邮箱
          <c:if test="${stu.email!=null}">
            :<c:out value="${stu.email}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(已设置)
          </c:if>
        </div>
        <div class="cont2">设置安全邮箱可以用来登录和找回密码</div>
        <div class="submit" style="top: 800px;">
          <input type="submit" value="修改" style="margin-top: 30px"/>
        </div>
      </div>
    </div>
  </div>
</div><br>
<div class="foot">
  <div class="w">
    <div class="pic2">
      <div class="pic3">FOLLOW</div>
      <div class="pic4">
        <div class="pic5">
          <img src="<c:url value="/static/imgs/github.png" />" alt="github"/>
        </div>
        <div class="pic5">
          <img src="<c:url value="/static/imgs/wechat.png" />" alt="wechat"/>
        </div>
        <div class="pic5">
          <img src="<c:url value="/static/imgs/qq.png" />" alt="qq"/>
        </div>
        <div class="pic5">
          <img src="<c:url value="/static/imgs/x.png" />" alt="x"/>
        </div>
      </div>
    </div>
    <div class="tel">
      <div class="tel1">SUPPORT</div>
      <div class="tel1">PRIVACY</div>
      <div class="tel1">TEAMS</div>
      <div class="tel1">REVIEWS</div>
      <div class="tel1">STOCKISTS</div>
      <div class="footer_info">
        <div class="footer_Info1">
          信息化管理处（信息中心）用户服务电话：029-88491717
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门户技术服务：029-88493092
        </div>
        <div class="footer_Info1">
          友谊校区地址：西安市友谊西路127号 邮编：710072 长安校区地址：西安市长安区东祥路1号
        </div>
        <div class="footer_Info1">
          版权所有 © 西北工业大学 ICP备案号：陕ICP备05010979
        </div>
      </div>
    </div>
  </div>
</div>
<script src="static/jquery/jquery-3.4.1.js"></script>
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
