<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<jsp:include page="comm/script.jsp" flush="true" />
<html>
<head>
<title>公墓之家</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/layout-default-latest.css">
<script src="<c:url value='static/plugins/jquery.min.js'/>" type="text/javascript"></script>
<script language="javascript">
	$(function(){
		$(".parent").hide();
		$(".parent:first").show();
	});
	$(document).on('click', '.txt', function(event){
		$(".parent").attr("class", "parent hide");
		$(this).next().attr("class", "parent show");
		$(".show").show(500);
		$(".hide").hide(500);
	});
</script>
</head>
<body>

	<iframe name="content" class="ui-layout-center"
		src="${pageContext.request.contextPath}/welcome" frameborder="0"
		scrolling="auto"></iframe>
	<div class="ui-layout-north">
		欢迎[
		<shiro:principal />
		]登陆公墓之家管理端，<a href="${pageContext.request.contextPath}/logout">退出</a>
	</div>
	<div class="ui-layout-south"></div>
	<div class="ui-layout-west">

		<div id="navigation">
			<h4><strong>主菜单</strong></h4>
			<ul>
				<c:forEach items="${menus }" var="item" varStatus="i">
					<li><div class="txt">${item.name}</div>
						<ul class="parent">
							<c:forEach items="${item.subMenu }" var="subMenu" varStatus="j">
								<li><a href="${pageContext.request.contextPath}/${subMenu.url}" target="content">${subMenu.name }</a></li>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>

	</div>

	<script src="${pageContext.request.contextPath}/static/plugins/jquery.layout-latest.min.js"></script>
	<script>
		$(function() {
			$(document).ready(function() {
				$('body').layout({
					applyDemoStyles : true
				});
			});
		});
	</script>
</body>
</html>