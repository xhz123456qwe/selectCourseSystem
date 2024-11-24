<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>已选课程</title>
    <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/head.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/footer.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/mySelectedCourse.css"/>">
</head>
<body>
<c:set var="stu" scope="session" value="${sessionScope.student}"/>
<header class="top">
    <div class="w">
        <div class="logo">
            <img src="<c:url value="/static/imgs/logo.png" />" alt="logo">
        </div>
        <div class="name">
            校园选课系统
        </div>
        <div class="navitems">
            <div class="navitems_in">
                <ul>
                    <li>
                        <a href="<c:url value="/student/mainPage"/>">首页</a>
                    </li>
                    <li><a href="<c:url value="/student/selectCourse"/>">选择课程</a></li>
                    <li><a href="#" class="choose">已选课程</a></li>
                    <li><a href="<c:url value="/student/stuCourseTable"/>">课程表</a></li>
                </ul>
            </div>
        </div>
        <div class="welcome">
            欢迎登陆,<c:out value="${stu.sName}"/>
        </div>
        <div class="back">
            <div class="backPic">
                <img src="<c:url value="/static/imgs/back.png" />" alt="back"/>
            </div>
            <a href="<c:url value="/student/back"/>" class="backWords">退出</a>
        </div>
    </div>
</header>
<br><br><br><br><br><br>
<c:set var="stu" scope="session" value="${sessionScope.student}"/>
<div class="w" style="height: 900px;">
    <div class="sel">
        <div class="score">已选择学分:<c:out value="${sessionScope.score}"/>/30</div>
        <div class="score">还可选学分:<c:out value="${30-sessionScope.score}"/></div>
        <div class="divide"></div>
        <div class="sel2">
            <form method="post" action="${pageContext.request.contextPath}/student/showCourse2">
                <div class="s1">
                    课程名称:<input type="text" name="cname"/>
                </div>
                <div class="s1">
                    教师姓名:<input type="text" name="tName"/>
                </div>
                <div class="s1">
                    课程编号:<input type="text" name="cNum"/>
                </div>
                <div class="s1">
                    选择状态:<input type="text" name="cState"/>
                </div>
                <div class="s1">
                    所属学院:<input type="text" name="department"/>
                </div>
                <div class="s1" style="margin-left: 100px;width: 300px">
                    <input type="submit" value="查询课程"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<c:url value="/student/showCourse"/>" class="a_border">重置</a>
                </div>
            </form>
        </div>
    </div>
    <div class="hadSel">
        <div class="ti">已选课程</div>
        <div class="table1">
            <table>
                <thead>
                <tr>
                    <th>课程名称</th>
                    <th>教学班编号</th>
                    <th>课程学分</th>
                    <th>授课时间</th>
                    <th>授课地点</th>
                    <th>所属学院</th>
                    <th>课程教师</th>
                    <th>选择人数</th>
                    <th>选择状态</th>
                </tr>
                </thead>
                <c:if test="${not empty sessionScope.pgc}">
                    <tbody>
                    <c:forEach var="course" items="${sessionScope.pgc}">
                        <tr>
                            <td><c:out value="${course.cName}"/></td>
                            <td><c:out value="${course.cNumber}"/></td>
                            <td><c:out value="${course.credit}"/></td>
                            <td><c:out value="${course.cTime}"/></td>
                            <td><c:out value="${course.location}"/></td>
                            <td><c:out value="${course.department}"/></td>
                            <td><c:out value="${course.teacher}"/></td>
                            <td><c:out value="${course.nowNum}"/>/<c:out value="${course.maxNumber}"/></td>
                            <c:set var="s" value="0"/>
                            <c:forEach var="sc" items="${sessionScope.chao}">
                                <c:if test="${sc.cId==course.cId}">
                                    <c:set var="s" value="1"/>
                                </c:if>
                            </c:forEach>
                            <c:if test="${s==1}">
                                <td style="color:red;">超额选择</td>
                            </c:if>
                            <c:if test="${s==0}">
                                <td style="color:#2b669a;">已选择</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </c:if>
            </table>
        </div>
        <div class="page">
            <c:if test="${sessionScope.pgc2 > 1}">
                <a href="${pageContext.request.contextPath}/student/showCourse1?page=${sessionScope.pgc2 - 1}"
                   class="a_border">上一页</a>
            </c:if>

            当前页: ${sessionScope.pgc2} / 共 ${sessionScope.curpgc} 页

            <c:if test="${sessionScope.pgc2 < sessionScope.curpgc}">
                <a href="${pageContext.request.contextPath}/student/showCourse1?page=${sessionScope.pgc2 + 1}"
                   class="a_border">下一页</a>
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
