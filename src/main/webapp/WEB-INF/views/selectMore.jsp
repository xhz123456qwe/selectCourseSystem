<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>select More</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/selectMore.css"/> ">
</head>
<body>
<div class="container-fluid side" style="height: 600px;top: 100px;left: 200px;width: 1100px;">
  <div class="smt">
    <div class="smt1">选课信息管理/</div>
    <div style="float:left;padding-top: 3px">
      <c:out value="${selCourse.cName}"/>
    </div>
    <div style="float:right;margin-right: 50px;padding: 2px 20px;background-color:#2b669a;">
      <a href="<c:url value="/manager/selectInfo/1"/>" style="color:white; text-decoration: none">返回</a>
    </div>
  </div>
  <div class="smt">
    <div class="smt1">未超额学生</div>
    <div class="smt1" style="margin-left: 400px">超额学生</div>
  </div>
  <div class="smtit" style="margin-right: 60px;">
    <table>
      <thead>
      <tr>
        <th>学生姓名</th>
        <th>学生学号</th>
        <th>选课顺序</th>
        <th>操作</th>
      </tr>
      </thead>
      <c:if test="${not empty stuL}">
        <tbody>
        <c:set var="L" value="1"/>
        <c:forEach var="s" items="${stuL}">
          <tr>
            <td><c:out value="${s.sName}"/></td>
            <td><c:out value="${s.sNumber}"/></td>
            <td><c:out value="${L}"/></td>
            <c:set var="L" value="${L+1}"/>
            <td>
              <form action="${pageContext.request.contextPath}/manager/backCourse" method="post">
                <input type="hidden" name="sid" value="${s.sId}"/>
                <input type="hidden" name="cid" value="${selCourse.cId}"/>
                <input type="hidden" name="nowL" value="${nowL}"/>
                <input type="hidden" name="nowR" value="${nowR}"/>
                <input type="submit" value="退课"/>
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </c:if>
    </table>
  </div>
  <div class="smtit">
    <table>
      <thead>
      <tr>
        <th>学生姓名</th>
        <th>学生学号</th>
        <th>超额位次</th>
        <th>操作</th>
      </tr>
      </thead>
      <c:if test="${not empty stuR}">
        <tbody>
        <c:set var="R" value="1"/>
        <c:forEach var="so" items="${stuR}">
          <tr>
            <td><c:out value="${so.sName}"/></td>
            <td><c:out value="${so.sNumber}"/></td>
            <td>超额<c:out value="${R}"/>位</td>
            <c:set var="R" value="${R+1}"/>
            <td>
              <form action="${pageContext.request.contextPath}/manager/backCourse" method="post">
                  <input type="hidden" name="sid" value="${so.sId}"/>
                  <input type="hidden" name="cid" value="${selCourse.cId}"/>
                  <input type="hidden" name="nowL" value="${nowL}"/>
                  <input type="hidden" name="nowR" value="${nowR}"/>
                  <input type="submit" value="退课"/>
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </c:if>
    </table>
  </div>
  <div class="smpage">
    <c:if test="${nowL > 1}">
      <a href="${pageContext.request.contextPath}/manager/selectInfo/select/${selCourse.cId}/${nowL - 1}/${nowR}"
         class="a_border">上一页</a>
    </c:if>

    当前页: ${nowL} / 共 ${totalL} 页

    <c:if test="${nowL < totalL}">
      <a href="${pageContext.request.contextPath}/manager/selectInfo/select/${selCourse.cId}/${nowL + 1}/${nowR}"
         class="a_border">下一页</a>
    </c:if>
  </div>
  <div class="smpage">
    <c:if test="${nowR > 1}">
      <a href="${pageContext.request.contextPath}/manager/selectInfo/select/${selCourse.cId}/${nowL}/${nowR - 1}"
         class="a_border">上一页</a>
    </c:if>

    当前页: ${nowR} / 共 ${totalR} 页

    <c:if test="${nowR < totalR}">
      <a href="${pageContext.request.contextPath}/manager/selectInfo/select/${selCourse.cId}/${nowL}/${nowR + 1}"
         class="a_border">下一页</a>
    </c:if>
  </div>
</div>
</body>
</html>
