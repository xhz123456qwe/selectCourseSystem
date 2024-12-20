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
    修改学生信息
  </div>
  <div class="addB">
    <form action="${pageContext.request.contextPath}/manager/stuInfo/updateStu/${page}" method="post">
      <div class="bol">
        <div class="bol1">
          <label>学生姓名</label>
          <input type="text" name="sname" value="${updateStu.sName}"/><br>
        </div>
        <div class="bol1">
          <label>学&emsp;&emsp;号</label>
          <input type="text" name="snumber" value="${updateStu.sNumber}" readonly/><br>
        </div>
        <div class="bol1">
          <label>账号密码</label>
          <input type="text" name="password" value="${updateStu.password}"/><br>
        </div>
        <div class="bol1">
          <label>所属学院</label>
          <input type="text" name="department" value="${updateStu.department}"/><br>
        </div>
        <div class="bol1">
          <label>邮&emsp;&emsp;箱</label>
          <input type="text" name="email" value="${updateStu.email}"/><br>
        </div>
      </div>
      <div class="bol" style="margin-left: 30px;padding-top:100px;width: 250px;">
        <fieldset>
          <legend>年&emsp;&emsp;级</legend>
          <div>
            <input type="radio" id="grade1" name="grade" value="大一" checked/>
            <label for="grade1">大一</label>
          </div>
          <div>
            <input type="radio" id="grade2" name="grade" value="大二" />
            <label for="grade2">大二</label>
          </div>
          <div>
            <input type="radio" id="grade3" name="grade" value="大三" />
            <label for="grade3">大三</label>
          </div>
          <div>
            <input type="radio" id="grade4" name="grade" value="大四" />
            <label for="grade4">大四</label>
          </div>
        </fieldset>
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
