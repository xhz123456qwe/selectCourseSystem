<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/updateMag.css"/>">
</head>
<body>
<div class="container-fluid side" style="height: 350px">
  <div class="t1">
    修改管理员信息
  </div>
  <div class="b1">
    <form method="post" action="${pageContext.request.contextPath}/manager/updateMagInfo">
      <div class="b11" style="margin-right: 20px">
        <label>账号ID&nbsp;&nbsp;</label>
        <input type="text" name="mnumber" value="${mag.mNumber}" readonly>
      </div>
      <div class="b11">
        <label>账号密码</label>
        <input type="text" name="password" value="${mag.password}">
      </div>
      <div class="b11" style="margin-right: 20px">
        <label>管理员姓名</label>
        <input type="text" name="mname" value="${mag.mName}">
      </div>
      <div class="b11">
        <label>账号邮箱</label>
        <input type="text" name="email" value="${mag.email}"/>
      </div>
      <div style="height: 30px;width: 100%;float:left;text-align: center;margin-top: 30px">
        <input type="hidden" name="mid" value="${mag.mId}"/>
        <input type="submit" value="修改"/>
      </div>
    </form>
  </div>
</div>
</body>
</html>
