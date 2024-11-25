<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>LoginError</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/login.css"/> ">
</head>
<body>
<div class="container-fluid login" style="padding: 30px;height: 250px;">
  <c:set value="${cause}" var="ca"/>
  <c:if test="${ca.toString().contains('org.springframework.web.HttpRequestMethodNotSupportedException')}">
    <c:if test="${not empty sessionScope.student}">
      <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%">
        不可通过输入URL直接进入
      </div>
      <a href="${pageContext.request.contextPath}/student/mainPage" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回用户界面</a>
    </c:if>

    <c:if test="${not empty sessionScope.manager}">
      <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
        不可通过输入URL直接进入
      </div>
      <a href="${pageContext.request.contextPath}/manager/mainPage" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回管理员界面</a>
    </c:if>
    <c:if test="${empty sessionScope.manager && empty sessionScope.student}">
      <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
        不可通过输入URL直接进入，请从登录界面进入
      </div>
      <a href="${pageContext.request.contextPath}/" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回登录界面</a>
    </c:if>
    <c:if test="${not empty sessionScope.manager &&not empty sessionScope.student}">
      <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
        恶意跳转，请从登录界面重新登录
      </div>
      <a href="${pageContext.request.contextPath}/" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回登录界面</a>
    </c:if>
  </c:if>

  <c:if test="${not empty stuLoginError}">
    <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
      学生密码被修改或错误，请重新登录
    </div>
    <a href="${pageContext.request.contextPath}/" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回登录界面</a>
  </c:if>
  <c:if test="${not empty magLoginError}">
    <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
      管理员密码被修改或失效，请重新登录
    </div>
    <a href="${pageContext.request.contextPath}/" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回登录界面</a>
  </c:if>
  <c:if test="${not empty ca&&!ca.toString().contains('org.springframework.web.HttpRequestMethodNotSupportedException')}">
    <div style="float:left;height: 30px;line-height: 30px;text-align: center;font-size: 25px;
    font-family: STXinwei;font-weight: bold;margin-top: 30px;margin-bottom: 100px;width: 100%;">
      操作错误!原因是:<c:out value="${ca.toString().substring(0,100)}"/>请重新登录
    </div>
    <a href="${pageContext.request.contextPath}/" style="padding: 3px 20px;
    background-color:#2b669a;color:white;text-align: center;width: 100%;height: 30px;margin-left: 360px">返回登录界面</a>
  </c:if>
</div>

</body>
</html>
