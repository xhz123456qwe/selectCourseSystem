<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选课管理</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/headManager.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/selectInfo.css"/> ">
</head>
<body>
<c:set var="manager" scope="session" value="${sessionScope.manager}"/>
<header class="top">
  <div class="w">
    <div class="logo">
      <img src="<c:url value="/static/imgs/logo.png" />" alt="logo">
    </div>
    <div class="name">
      选课管理系统
    </div>
    <div class="navitems">
      <div class="navitems_in">
        <ul>
          <li>
            <a href="<c:url value="/manager/mainPage"/>">主页</a>
          </li>
          <li><a href="<c:url value="/manager/stuInfo?page=1"/>">学生管理</a></li>
          <li><a href="<c:url value="/manager/managerInfo/1"/>">管理员管理</a></li>
          <li><a href="<c:url value="/manager/courseInfo/1"/>">课程管理</a></li>
          <li><a href="#" class="choose">选课管理</a></li>
        </ul>
      </div>
    </div>
    <div class="welcome">
      欢迎登陆,<c:out value="${manager.mName}"/>
    </div>
    <div class="back">
      <div class="backPic">
        <img src="<c:url value="/static/imgs/back.png" />" alt="back"/>
      </div>
      <a href="<c:url value="/manager/back"/>" class="backWords">退出</a>
    </div>
  </div>
</header>
<br/><br/><br/><br/><br/>
<div class="w" style="height: 850px;">
  <div class="bod3">
    <div class="bod33" style="color:black;">
      <div class="bod34" style="margin-bottom: 15px">
        选课预警
      </div>
      <div class="bod35">
        当前课程总共有:<c:out value="${sessionScope.allCoursesSize}"/>
      </div>
      <div class="bod35">
        人数为0的课程有:<c:out value="${sessionScope.zeroCoursesSize}"/>
      </div>
      <div class="bod35">
        人数超额的课程有:<c:out value="${sessionScope.overCoursesSize}"/>
      </div>
    </div>
    <div class="bod33" style="margin-left: 100px;background-color:white;width: 350px;height: 270px;">
      <form action="${pageContext.request.contextPath}/manager/selectInfo2" method="post">
      <div class="bod34" style="margin-bottom: 15px">
        选课查询
      </div>
      <div class="bod36" style="font-size: 15px">
        课程名称<input type="text" name="cname">
      </div>
      <div class="bod36" style="font-size: 15px">
        课程编号<input type="text" name="cnumber">
      </div>
      <div class="bod36" style="font-size: 15px">
        是否超额<input type="text" name="over"/>
      </div>
      <input type="submit" value="查询"  style="padding: 3px 20px;
      background-color:#2b669a;color:white;border:0;margin-left: 50px">
        <a href="<c:url value="/manager/selectInfo/1"/>" style="padding: 5px 20px;
                margin-left: 10px;background-color:#2b669a;color:white;">重置</a>
      </form>
    </div>
    <div class="bod33" style="width: 250px;height: 250px;float:left;margin-left: 40px;background-color:white;">
      <img src="<c:url value="/static/imgs/dec1.png" />" alt="dec1">
    </div>
  </div>
  <div class="bod3" style="height: 550px;">
    <div class="stit">
    选课超额情况
    </div>
    <div class="sbod">
    <table>
      <thead>
      <tr>
        <th>课程名称</th>
        <th>课程编号</th>
        <th>已选/人数上线</th>
        <th>是否超额</th>
        <th>超额人数</th>
        <th>操作</th>
      </tr>
      </thead>
      <c:if test="${not empty showS}">
        <tbody>
        <c:forEach var="s" items="${showS}">
          <tr>
            <td style="font-weight: 600;"><c:out value="${s.cName}"/></td>
            <td><c:out value="${s.cNumber}"/></td>
            <c:if test="${s.nowNum>s.maxNumber}">
              <td>
                <span style="float:left;margin-left: 20px;color:red;">
                  <c:out value="${s.nowNum}"/>/<c:out value="${s.maxNumber}"/>
                </span><br/>
                <div class="jdt">
                  <div class="jdtl" style="width:200px;color: red;"></div>
                </div>
              </td>
            </c:if>
            <c:if test="${s.nowNum<=s.maxNumber}">
              <td>
                <span style="float:left;margin-left: 20px;color:green;">
                  <c:out value="${s.nowNum}"/>/<c:out value="${s.maxNumber}"/>
                </span><br/>
                <div class="jdt">
                  <div class="jdtl" style="width:${200.0*s.nowNum/s.maxNumber}px;background-color: #2b669a"></div>
                </div>
              </td>
            </c:if>

            <td>
              <c:if test="${s.nowNum>s.maxNumber}">
                <c:out value="是"/>
              </c:if>
              <c:if test="${s.nowNum<=s.maxNumber}">
                <c:out value="否"/>
              </c:if>
            </td>
            <td>
              <c:if test="${s.nowNum>s.maxNumber}">
                <c:out value="${s.nowNum-s.maxNumber}"/>
              </c:if>
              <c:if test="${s.nowNum<=s.maxNumber}">
                -
              </c:if>
            </td>
            <td>
              <a href="<c:url value="/manager/selectInfo/select/${s.cId}/1/1"/>" style="background-color:#2b669a;
color:white;padding: 4px 20px;">选课管理</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </c:if>
    </table>
    </div>
    <c:if test="${not empty uri}">
      <div class="spage">
        <c:if test="${nowPage > 1}">
          <a href="${pageContext.request.contextPath}/manager/selectInfo2/${nowPage - 1}"
             class="a_border">上一页</a>
        </c:if>

        当前页: ${nowPage} / 共 ${totalPage} 页

        <c:if test="${nowPage < totalPage}">
          <a href="${pageContext.request.contextPath}/manager/selectInfo2/${nowPage + 1}"
             class="a_border">下一页</a>
        </c:if>
      </div>
    </c:if>
    <c:if test="${empty uri}">
      <div class="spage">
        <c:if test="${nowPage > 1}">
          <a href="${pageContext.request.contextPath}/manager/selectInfo/${nowPage - 1}"
             class="a_border">上一页</a>
        </c:if>

        当前页: ${nowPage} / 共 ${totalPage} 页

        <c:if test="${nowPage < totalPage}">
          <a href="${pageContext.request.contextPath}/manager/selectInfo/${nowPage + 1}"
             class="a_border">下一页</a>
        </c:if>
      </div>
    </c:if>
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
