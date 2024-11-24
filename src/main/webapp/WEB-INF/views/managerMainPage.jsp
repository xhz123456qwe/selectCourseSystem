<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>stuMainPage</title>
  <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/headManager.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/managerMainPage.css" />">
  <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css" />">
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
            <a href="#" class="choose">主页</a>
          </li>
          <li><a href="<c:url value="/manager/stuInfo?page=1"/>">学生管理</a></li>
          <li><a href="<c:url value="/manager/managerInfo/1"/>">管理员管理</a></li>
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
<div class="w">
  <div class="body1">
    <div class="my_inf">
      <div class="state">
        当前帐号状态
      </div>
      <div class="state2">
        <table>
          <thead>
          <tr>
            <th>账号</th>
            <th>管理员姓名</th>
            <th>密码</th>
            <th>邮箱</th>
            <th>账号失效期</th>
            <th>是否激活</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <tr class="tr1">
            <td><c:out value="${manager.mNumber}"/></td>
            <td><c:out value="${manager.mName}"/></td>
            <td><c:out value="${manager.password}"/></td>
            <td><c:out value="${manager.email}"/></td>
            <td>2034年</td>
            <td style="text-align: left;color:lightseagreen;"><div class="circle"></div>已激活</td>
            <td style="color:lightseagreen;">正常</td>
            <td>
              <a href="<c:url value="/manager/updateMag/${manager.mId}"/> " rel="" class="a2">修改信息</a>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="basic_inf">
      <div class="state">
        选课系统总概
      </div>
      <div class="sys1">
        <div class="sys2">
          <div class="cir2">管理员数量<br/><c:out value="${magNum}"/></div>
          <div class="word1">
            <div class="word11">注销数量</div>
            <div class="word12"><c:out value="${delMag}"/></div>
          </div>
        </div>
        <div class="sys2">
          <div class="cir2">学生数量<br/><c:out value="${stuNum}"/></div>
          <div class="word1">
            <div class="word11">未选课人数</div>
            <div class="word12"><c:out value="${delStu}"/></div>
          </div>
        </div>
        <div class="sys2">
          <div class="cir2">课程数量<br/><c:out value="${couNum}"/></div>
          <div class="word1">
            <div class="word11">超人数数量</div>
            <div class="word12"><c:out value="${overCou}"/></div>
          </div>
        </div>
        <div class="sys2">
          <div class="cir2">课程数量<br/><c:out value="${couNum}"/></div>
          <div class="word1">
            <div class="word11">选课人数为0的数量</div>
            <div class="word12"><c:out value="${zeroCou}"/></div>
          </div>
        </div>
      </div>
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
