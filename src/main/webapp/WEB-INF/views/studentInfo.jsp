<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生信息</title>
    <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/headManager.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/stuInfo.css"/> ">
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
                    <li><a href="#" class="choose">学生管理</a></li>
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
    <div class="bod1">
        <div class="bod11" style="background-color:#2b669a;padding: 30px">
            <div class="stit2" style="font-weight: bold;font-family: STXinwei;">
                学生预警
            </div>
            <div class="body2">
                <div style="float:left;color:black;">当前学生总数为:</div>
                <c:out value="${sessionScope.studentList.size()}"/>
            </div>
            <div class="body2" style="color: red">
                <div style="float:left;color:black;">未选课的学生数量为：</div><c:out value="${sessionScope.zeroStu}"/>
            </div>
            <div class="body2" style="color: red">
                <div style="float:left;color:black;">选课未满15学分的学生数量为：</div><c:out value="${sessionScope.lowFifteen}"/>
            </div>
        </div>
        <div class="bod12">
            <div class="stit2" style="font-weight: bold;font-family: STXinwei">
                学生信息查询
            </div>
            <form action="${pageContext.request.contextPath}/manager/stuInfo2" method="post">
                <div class="b2">
                    学生名称:<input type="text" name="sname">
                </div>
                <div class="b2">
                    学生学号:<input type="text" name="snumber">
                </div>
                <div class="b2">
                    所属年级:<input type="text" name="grade">
                </div>
                <div class="b2">
                    所属学院:<input type="text" name="department">
                </div>
                <input type="submit" value="查询" style="padding: 2px 20px;margin-left: 200px;
                background-color:#2b669a;color:white;border: 0;">
                <a href="<c:url value="/manager/stuInfo?page=1"/>" style="padding: 4px 20px;
                margin-left: 100px;background-color:#2b669a;color:white;">重置</a>
            </form>
        </div>
    </div>
    <div class="bod1" style="height: 550px;">
        <div class="stit2">
            学生信息列表
            <a href="<c:url value="/manager/stuInfo/toAddStu"/>" class="a1">+ 添加学生</a>
        </div>
        <div class="cont3">
            <table>
                <thead>
                <tr>
                    <th>学生姓名</th>
                    <th>学号</th>
                    <th>密码</th>
                    <th>年级</th>
                    <th>所属学院</th>
                    <th>邮箱</th>
                    <th>操作</th>
                </tr>
                </thead>
                <c:if test="${not empty showStu}">
                    <tbody>
                    <c:forEach var="stu" items="${showStu}">
                        <tr>
                            <td><c:out value="${stu.sName}"/></td>
                            <td><c:out value="${stu.sNumber}"/></td>
                            <td><c:out value="${stu.password}"/></td>
                            <td><c:out value="${stu.grade}"/></td>
                            <td><c:out value="${stu.department}"/></td>
                            <td><c:out value="${stu.email}"/></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/manager/stuInfo/delete/${stu.sId}/${pg}"
                                      method="post" class="f1" style="margin-left: 26px;color:red;border:red">
                                    <input type="submit" value="删除"/>
                                </form>
                                <form action="${pageContext.request.contextPath}/manager/stuInfo/update/${stu.sId}/${pg}"
                                      method="post" class="f1" style="color:green;border: green">
                                    <input type="submit" value="修改" />
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </c:if>
            </table>
        </div>

        <c:if test="${not empty uri}">
            <div class="spage">
                <c:if test="${pg > 1}">
                    <a href="${pageContext.request.contextPath}/manager/stuInfo2?page=${pg - 1}"
                       >上一页</a>
                </c:if>

                当前页: ${pg} / 共 ${totalPg} 页

                <c:if test="${pg < totalPg}">
                    <a href="${pageContext.request.contextPath}/manager/stuInfo2?page=${pg + 1}"
                       >下一页</a>
                </c:if>
            </div>
        </c:if>
        <c:if test="${empty uri}">
            <div class="spage">
                <c:if test="${pg > 1}">
                    <a href="${pageContext.request.contextPath}/manager/stuInfo?page=${pg - 1}"
                       class="a_border">上一页</a>
                </c:if>

                当前页: ${pg} / 共 ${totalPg} 页

                <c:if test="${pg < totalPg}">
                    <a href="${pageContext.request.contextPath}/manager/stuInfo?page=${pg + 1}"
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
