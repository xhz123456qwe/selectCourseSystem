<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>添加管理员</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/addMag.css"/> ">
</head>
<body>
<div class="container-fluid side">
  <div class="addTit">
    新增管理员
  </div>
  <div class="addB">
    <form action="${pageContext.request.contextPath}/manager/managerInfo/add" method="post">
      <div class="addB0">

      </div>
      <div class="addB0">
        <label>管理姓名</label>
        <input type="text" name="mname"/><br>
      </div>
      <div class="addB0">
        <label>账号密码</label>
        <input type="text" name="password"/><br>
      </div>
      <div class="addB0">
        <label>账号名称</label>
        <input type="text" name="mnumber"/><br>
      </div>
      <div class="addB0">
        <label>账号邮箱</label>
        <input type="text" name="email"/><br>
      </div>
      <input type="submit" value="提交" style="float:right;margin-top: 50px;padding-right: 20px;
padding-left: 20px;border: 0;background-color:#2b669a;color:white;">
    </form>
  </div>
  <div class="addB1">
    <img src="<c:url value="/static/imgs/addMag.png"/>" alt="dec"/>
  </div>
  <div class="addB3">
    <a href="<c:url value="/manager/managerInfo/1"/>" class="a3">返回</a>
  </div>
</div>
</body>
</html>
