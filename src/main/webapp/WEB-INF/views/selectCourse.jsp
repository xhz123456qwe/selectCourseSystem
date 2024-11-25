<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>selectCourse</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/head.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/selectCourse.css"/>">
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
            <a href="<c:url value="/student/mainPage"/>">首页</a>
          </li>
          <li><a href="#" class="choose">选择课程</a></li>
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
<div class="w" style="height: 576px;">
  <div class="choice">
    <div class="chin">
      查询课程
    </div>
    <div class="chin2">
      <form method="post" action="${pageContext.request.contextPath}/student/showCourseBySearch/1">
        <div class="ch1">
          课程名称:<input type="text" name="cname"/>
        </div>
        <div class="ch1">
          课程编号:<input type="text" name="cnumber"/>
        </div>
        <div class="ch1">
          授课教师:<input type="text" name="teacher"/>
        </div>
        <div class="ch1">
          选课状态:<input type="text" name="state"/>
        </div>
        <input type="submit" value="查询" style="margin-top: 10px;margin-left: 40px"/>
        <a href="<c:url value="/student/selectCourse"/>">重置</a>
      </form>
    </div>
  </div>
  <div class="tab">
    <div class="tab_title" style="margin-bottom: 15px">
      2024-2025秋季选课
    </div>
    <div class="tab_context">
      <table>
        <thead>
          <tr>
            <th>课程名称</th>
            <th>课程编号</th>
            <th>授课教师</th>
            <th>授课时间</th>
            <th>授课地点</th>
            <th>已选/人数上限</th>
            <th>选课状态</th>
            <th>操作</th>
          </tr>
        </thead>
        <c:if test="${not empty sessionScope.courseNow}">
        <tbody>
        <c:forEach var="course" items="${sessionScope.courseNow}">
        <tr>
          <th>${course.cName}</th>
          <td>${course.cNumber}</td>
          <td>${course.teacher}</td>
          <td>${course.cStart}-<br/>${course.cEnd}<br/>${course.cDay}&emsp;${course.cTime}</td>
          <td>${course.location}</td>
          <td>${course.nowNum}/${course.maxNumber}</td>
          <c:forEach var="state" items="${sessionScope.courseState}">
            <c:if test="${state.cId==course.cId}">
              <c:if test="${state.state.equals('待选择')}">
                <td>
                  <c:out value="待选择"/>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/student/select/${course.cId}/${sessionScope.s_sc_currentPages}" class="a_border a_d">选课</a>
                </td>
              </c:if>
              <c:if test="${state.state.equals('超额选择')}">
                <td>
                  <c:out value="超额选择"/>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/student/select/${course.cId}/${sessionScope.s_sc_currentPages}" class="a_border a_d">退课</a>
                </td>
              </c:if>
              <c:if test="${state.state.equals('已选择')}">
                <td>
                  <c:out value="已选择"/>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/student/select/${course.cId}/${sessionScope.s_sc_currentPages}" class="a_border a_d">退课</a>
                </td>
              </c:if>
              <c:if test="${state.state.equals('已选中')}">
                <td>
                  <c:out value="已选中"/>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/student/select/${course.cId}/${sessionScope.s_sc_currentPages}" class="a_border a_d">退课</a>
                </td>
              </c:if>
            </c:if>
          </c:forEach>
        </tr>
        </c:forEach>
        </tbody>
        </c:if>
      </table>
    </div>
    <div class="page">
        <c:if test="${sessionScope.s_sc_currentPages > 1}">
          <a href="${pageContext.request.contextPath}/student/selectCourse1?page=${sessionScope.s_sc_currentPages - 1}"
            class="a_border">上一页</a>
        </c:if>

        当前页: ${sessionScope.s_sc_currentPages} / 共 ${sessionScope.s_sc_totalPages} 页

        <c:if test="${sessionScope.s_sc_currentPages < sessionScope.s_sc_totalPages}">
          <a href="${pageContext.request.contextPath}/student/selectCourse1?page=${sessionScope.s_sc_currentPages + 1}"
            class="a_border">下一页</a>
        </c:if>
    </div>
  </div>
</div>

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

</body>
</html>
