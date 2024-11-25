<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>修改学生</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/addStu.css"/> ">
</head>
<body>
<div class="container-fluid side">
  <div class="addTit">
    修改密码
  </div>
  <div class="addB">
    <form action="${pageContext.request.contextPath}/student/updatePwd" method="post">
      <div class="bol">
        <div class="bol1">
          <label>学生姓名</label>
          <input type="text" name="sname" value="${sessionScope.student.sName}" readonly/><br>
        </div>
        <div class="bol1">
          <label>学&emsp;&emsp;号</label>
          <input type="text" name="snumber" value="${sessionScope.student.sNumber}" readonly/><br>
        </div>
        <div class="bol1">
          <label>账号密码</label>
          <c:if test="${key.equals('1')}">
            <input type="text" name="password" value="${sessionScope.student.password}"/><br>
          </c:if>
          <c:if test="${key.equals('2')}">
            <input type="text" name="password" value="${sessionScope.student.password}" readonly/><br>
          </c:if>
        </div>
        <div class="bol1">
          <label>所属学院</label>
          <input type="text" name="department" value="${sessionScope.student.department}" readonly/><br>
        </div>
        <div class="bol1">
          <label>邮&emsp;&emsp;箱</label>
          <c:if test="${key.equals('1')}">
            <input type="text" name="email" value="${sessionScope.student.email}" readonly/><br>
          </c:if>
          <c:if test="${key.equals('2')}">
            <input type="text" name="email" value="${sessionScope.student.email}"/><br>
          </c:if>
        </div>
      </div>
      <div class="bol" style="margin-left: 30px;padding-bottom:50px;width: 363px;">
        <img src="<c:url value="/static/imgs/addMag.png"/>"/>
      </div>
      <div style="float:left;height: 30px;width: 100%;text-align: center;line-height: 30px">
        <input type="submit" value="提交" style="padding-left: 20px;padding-right: 20px;
          text-align: center;background-color:#2b669a;color: white;border: 0px"/>
      </div>
    </form>
  </div>
</div>
</body>
</html>
