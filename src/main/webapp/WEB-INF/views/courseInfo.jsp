<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程管理</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/headManager.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/courseInfo.css"/> ">
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
          <li><a href="<c:url value="/manager/stuInfo?page=1"/> ">学生管理</a></li>
          <li><a href="<c:url value="/manager/managerInfo/1"/>">管理员管理</a></li>
          <li><a href="#" class="choose">课程管理</a></li>
          <li><a href="<c:url value="/manager/selectInfo/1"/>">选课管理</a></li>
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
<div class="w">
  <div class="bod2" style="height: 200px;">
    <div class="titc">课程查询</div>
    <form action="${pageContext.request.contextPath}/manager/courseInfo2" method="post">
    <div class="bod22">
      课程名称<input type="text" name="cname">
    </div>
    <div class="bod22">
      课程编号<input type="text" name="cnumber">
    </div>
    <div class="bod22">
      授课教师<input type="text" name="teacher">
    </div>
    <div class="bod22">
      授课地点<input type="text" name="location">
    </div>
    <div class="bod22">
      授课星期<input type="text" name="ctime"/>
    </div>
      <input type="submit" value="查询" style="padding: 3px 20px;background-color:#2b669a;
      color:white;border:0;margin-left: 50px"/>
      <a href="<c:url value="/manager/courseInfo/1"/>" style="padding: 5px 20px;
                margin-left: 10px;background-color:#2b669a;color:white;">重置</a>
    </form>
  </div>
  <div class="bod2" style="height: 650px">
    <div class="ctit">
      课程信息列表<a href="<c:url value="/manager/courseInfo/toAdd"/>" class="a2">添加课程</a>
    </div>
    <div class="cTab">
      <table>
        <thead>
        <tr>
          <th>课程名称</th>
          <th>课程编号</th>
          <th>授课教师</th>
          <th>学分</th>
          <th>授课时间</th>
          <th>授课地点</th>
          <th>已选/人数上限</th>
          <th>操作</th>
        </tr>
        </thead>
        <c:if test="${not empty showC}">
          <tbody>
          <c:forEach var="c" items="${showC}">
            <tr>
              <td class="wi"><c:out value="${c.cName}"/></td>
              <td><c:out value="${c.cNumber}"/></td>
              <td><c:out value="${c.teacher}"/></td>
              <td><c:out value="${c.credit}"/></td>
              <td style="padding-top: 10px;padding-bottom: 10px">
                <c:out value="${c.cStart.concat(' 开课')}"/><br/>
                <c:out value="${c.cEnd.concat(' 结课')}"/><br/>
                <c:out value="${c.cDay.concat('的')}"/><br/>
                <c:out value="${c.cTime.concat('期间')}"/>
              </td>
              <td><c:out value="${c.location}"/></td>

              <c:if test="${c.nowNum>c.maxNumber}">
                <td style="color: crimson"><c:out value="${c.nowNum}"/>/<c:out value="${c.maxNumber}"/></td>
              </c:if>
              <c:if test="${c.nowNum<=c.maxNumber}">
                <td style="color: green"><c:out value="${c.nowNum}"/>/<c:out value="${c.maxNumber}"/></td>
              </c:if>
              <td>
                <form method="post" action="${pageContext.request.contextPath}/manager/courseInfo/more/${c.cId}/${nowPage}">
                  <input type="submit" value="详情" class="inp"/>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/manager/courseInfo/delete/${c.cId}/${nowPage}">
                  <input type="submit" value="删除" class="inp">
                </form>
                <form method="post" action="${pageContext.request.contextPath}/manager/courseInfo/toUpdate/${c.cId}/${nowPage}">
                  <input type="submit" value="修改" class="inp">
                </form>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </c:if>
      </table>
    </div>

    <c:if test="${empty uri}">
      <div class="cpage">
        <c:if test="${nowPage > 1}">
          <a href="${pageContext.request.contextPath}/manager/courseInfo/${nowPage - 1}"
             class="a_border">上一页</a>
        </c:if>

        当前页: ${nowPage} / 共 ${totalPage} 页

        <c:if test="${nowPage < totalPage}">
          <a href="${pageContext.request.contextPath}/manager/courseInfo/${nowPage + 1}"
             class="a_border">下一页</a>
        </c:if>
      </div>
    </c:if>
    <c:if test="${not empty uri}">
      <div class="cpage">
        <c:if test="${nowPage > 1}">
          <a href="${pageContext.request.contextPath}/manager/courseInfo2/${nowPage - 1}"
             class="a_border">上一页</a>
        </c:if>

        当前页: ${nowPage} / 共 ${totalPage} 页

        <c:if test="${nowPage < totalPage}">
          <a href="${pageContext.request.contextPath}/manager/courseInfo2/${nowPage + 1}"
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
