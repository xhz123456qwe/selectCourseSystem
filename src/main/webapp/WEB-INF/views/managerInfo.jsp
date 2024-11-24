<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ManagerInfo</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/headManager.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/magInfo.css"/> ">
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
          <li><a href="#" class="choose">管理员管理</a></li>
          <li><a href="<c:url value="/manager/courseInfo/1"/>">课程管理</a></li>
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
<div class="w" style="height: 580px">
  <div class="ct">
    <div class="choose1">
      <div style="float:left;width: 100%;height: 30px;line-height: 30px;font-weight: bold;font-family: STXinwei;font-size: 21px">
        管理员查询
      </div>
      <form action="${pageContext.request.contextPath}/manager/managerInfo2" method="post">
      <div class="g1">
        管理员姓名:<br/><input type="text" name="mname"/>
      </div>
      <div class="g1">
        账号ID:<br/><input type="text" name="mnumber"/>
      </div>
      <div class="g1">
        帐号状态:<br/><input type="text" name="state"/>
      </div>
      <input type="submit" value="查询" style="padding: 3px 20px;background-color:#2b669a;color:white;border:0;margin-left: 50px">
        <a href="<c:url value="/manager/managerInfo/1"/>" style="padding: 5px 20px;
                margin-left: 10px;background-color:#2b669a;color:white;">重置</a>
      </form>
    </div>
    <div class="tab2">
      <div class="tab21">
        管理员账号管理<a href="<c:url value="/manager/managerInfo/toAddStu"/>" class="a2">添加管理员</a>
      </div>
      <div style="height: 480px">
        <table>
          <thead>
          <tr>
            <th>管理员姓名</th>
            <th>账号密码</th>
            <th>账号ID</th>
            <th>邮箱</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <c:if test="${not empty managerList}">
            <tbody>
            <c:forEach var="mag" items="${managerList}">
              <tr>
                <td><c:out value="${mag.mName}"/></td>
                <td><c:out value="${mag.password}"/></td>
                <td><c:out value="${mag.mNumber}"/></td>
                <td><c:out value="${mag.email}"/></td>
                <c:if test="${mag.state.equals('0')}">
                  <td><c:out value="未删除"/></td>
                </c:if>
                <c:if test="${mag.state.equals('1')}">
                  <td><c:out value="已删除"/></td>
                </c:if>
                <td>
                  <c:if test="${mag.state.equals('1')}">
                    <input type="submit" value="已删除" readonly />
                  </c:if>
                  <c:if test="${mag.state.equals('0')}">
                    <form method="post" action="${pageContext.request.contextPath}/manager/managerInfo/delete/${mag.mId}/${nowPage}">
                      <input type="submit" value="删除"/>
                    </form>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </c:if>
        </table>
      </div>
      <c:if test="${not empty uri}">
        <div class="page">
          <c:if test="${nowPage > 1}">
            <a href="${pageContext.request.contextPath}/manager/managerInfo2/${nowPage - 1}"
               >上一页</a>
          </c:if>

          当前页: ${nowPage} / 共 ${totalPage} 页

          <c:if test="${nowPage < totalPage}">
            <a href="${pageContext.request.contextPath}/manager/managerInfo2/${nowPage + 1}"
               >下一页</a>
          </c:if>
        </div>
      </c:if>
      <c:if test="${empty uri}">
        <div class="page">
          <c:if test="${nowPage > 1}">
            <a href="${pageContext.request.contextPath}/manager/managerInfo/${nowPage - 1}"
               class="a_border">上一页</a>
          </c:if>

          当前页: ${nowPage} / 共 ${totalPage} 页

          <c:if test="${nowPage < totalPage}">
            <a href="${pageContext.request.contextPath}/manager/managerInfo/${nowPage + 1}"
               class="a_border">下一页</a>
          </c:if>
        </div>
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
