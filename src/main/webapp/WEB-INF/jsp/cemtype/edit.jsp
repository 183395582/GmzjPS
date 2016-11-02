<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="gmfn" uri="http://www.gmzj.co/tags/functions"%>
<jsp:include page="../comm/script.jsp" flush="true" />
<jsp:include page="../comm/css.jsp" flush="true" />
<jsp:include page="../comm/mapJs.jsp" flush="true" />
<%@ include file="../comm/taglib.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
	<style>
		label{
			margin-top: 7px;
		}
		.row{
			margin-top: 10px;
		}
		#city select {
			height: 32px;
		}
	</style>
</head>
<body>

    <div class="box border">
				<div class="box-title">
					<h4>
						<span>${op }</span>
					</h4>
					<div class="tools"></div>
				</div>
				<div class="box-body">
					<div class="box-body big">
						<form:form id="editform" modelAttribute="cemtype" class="form-horizontal" method="POST">
							<form:hidden path="id"/>
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">基本信息</label>
							</div>
							
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="name">墓型名称：</label>
								</div>
								<div class="col-md-3">
									<form:input path="name" class="form-control pull-left" placeholder="公墓名称"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="stat">状态：</label>
								</div>
								<div class="col-md-3">
									<form:input path="stat" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="code">墓型编号：</label>
								</div>
								<div class="col-md-3">
									<form:input path="code" class="form-control pull-left" placeholder="墓型编号"/>
								</div>
								
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="whe">所属地域：</label>
								</div> 
								<div class="col-md-3" id="city">
									<select class="prov" id="pr" onchange="getCemeteries()"></select> 
									<select class="city" id="ct" onchange="getCemeteries()"></select>
									<select class="dist" id="di" onchange="getCemeteries()"></select>
								</div>
								<div class="col-md-2" style="text-align: right;">
									<label for="zoneId">所属园区：</label>
								</div>
								<div class="col-md-3">
									<form:input path="zoneId" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="origPrice">原价：</label>
								</div>
								<div class="col-md-3">
									<form:input path="origPrice" class="form-control"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="price">优惠价：</label>
								</div>
								<div class="col-md-3">
									<form:input path="price" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="type">墓型类型：</label>
								</div>
								<div class="col-md-3">
									<form:input path="type" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="material">材质：</label>
								</div>
								<div class="col-md-3">
									<form:input path="material" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="colours">墓碑颜色：</label>
								</div>
								<div class="col-md-3">
									<form:input path="colours" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="num">墓穴数量：</label>
								</div>
								<div class="col-md-3">
									<form:input path="num" class="form-control pull-left"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="direction">墓型朝向：</label>
								</div>
								<div class="col-md-3">
									<form:input path="direction" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="feature">墓型特点：</label>
								</div>
								<div class="col-md-3">
									<form:input path="feature" class="form-control pull-left"/>
								</div>
							</div>
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">设置状态</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="enjoy">尊享标志：</label>
								</div>
								<div class="col-md-3">
									<form:input path="enjoy" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right;">
									<label for="special">特惠标志：</label>
								</div>
								<div class="col-md-3">
									<form:input path="special" class="form-control pull-left"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="specialNum">获得特惠人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="specialNum" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="followNum">关注人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="followNum" class="form-control"/>
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-md-offset-9">
									<button type="submit" class="btn btn-success">保存</button>
									<a class="btn btn-primary" href="<%=basePath%>/cemType/" target="content" role="button">返回</a>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="text-align: center;">
									<c:if test="${msg != null }">
										<div id="myAlert" class="alert alert-success">
											<a href="#" class="close" data-dismiss="alert">&times;</a>
											<strong>${msg }！</strong>
										</div>
									</c:if>
								</div>
							</div>
						</form:form>

					</div>
				</div>
				<!-- /BOX -->
			</div>
<script type="text/javascript">
$(function(){
	$("#city").citySelect({
		prov:"${cemetery.prov}", 
		city:"${cemetery.city}",
		dist:"${cemetery.dist}",
		nodata:"none",
		required:false
	});
});
</script>
</body>
</html>