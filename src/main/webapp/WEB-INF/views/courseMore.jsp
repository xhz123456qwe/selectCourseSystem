<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程细节</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/courseMore.css"/> ">
</head>
<body>
<div class="container-fluid side">
  <div class="mtit">课程详情</div>
  <div class="mbod">
    <div class="mbod1" style="margin-top: 10px">
      <div class="mbod2">课程名称:</div><c:out value="${course.cName}"/>
    </div>
    <div class="mbod1">
      <div class="mbod2">课程编号:</div><c:out value="${course.cNumber}"/>
    </div>
    <div class="mbod1">
      <div class="mbod2">课程学分:</div><c:out value="${course.credit}"/>
    </div>
    <div class="mbod1">
      <div class="mbod2">授课教师:</div><c:out value="${course.teacher}"/>
    </div>
    <div class="mbod1">
      <div class="mbod2">授课地点:</div><c:out value="${course.location}"/>
    </div>
    <div class="mbod1" style="height: 50px">
      <div class="mbod2" style="margin-bottom: 50px">授课时间:</div>
      <c:out value="${course.cStart}"/> - <c:out value="${course.cEnd}"/><br>
      每周的 <c:out value="${course.cDay}"/>的<c:out value="${course.cTime}"/>
    </div>
  </div>
  <div class="mbod">
    <div class="mbod1" style="height: 100px;">
      <div class="mbod2" style="width: 200px;height: 30px;">已选/人数上限:</div><br/>
      <c:if test="${course.maxNumber<course.nowNum}">
        <div style="float:right;width: 100px;height:30px;color:red;">
          <c:out value="${course.nowNum}"/>/<c:out value="${course.maxNumber}"/>
        </div>
      </c:if>
      <c:if test="${course.maxNumber>=course.nowNum}">
        <div style="float:right;width: 100px;height:30px;color:#2b669a;">
          <c:out value="${course.nowNum}"/>/<c:out value="${course.maxNumber}"/>
        </div>
      </c:if>
      <div class="m">
        <c:if test="${course.maxNumber<course.nowNum}">
          <div class="m1" style="width: 300px;background-color:red;"></div>
        </c:if>
        <c:if test="${course.maxNumber>=course.nowNum}">
          <div class="m1" style="width: ${300.0*course.nowNum/course.maxNumber}px"></div>
        </c:if>
      </div>
    </div>
    <div class="mbod1" style="height: 100px">
      <div class="mbod2" style="height: 30px">课程描述:</div><br/>
      <textarea name="description" rows="5" cols="49" readonly>${course.description}</textarea>
    </div>
  </div>
  <div style="float:left;width: 100%;height: 30px;text-align: center;line-height: 30px;margin-top: 20px">
    <a href="<c:url value="/manager/courseInfo/${page}"/>" style="padding: 5px 20px;background-color:#2b669a;
color:white;">返回</a>
  </div>
</div>
</body>
</html>
