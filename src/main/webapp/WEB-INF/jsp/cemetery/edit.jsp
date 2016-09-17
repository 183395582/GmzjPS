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
						<form:form id="editform" modelAttribute="cemetery" class="form-horizontal" method="POST">
							<form:hidden path="id"/>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="name">公司名称：</label>
								</div>
								<div class="col-md-3">
									<form:input path="name" class="form-control pull-left" placeholder="公司名称"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="type">经营类型：</label>
								</div>
								<div class="col-md-3">
									<form:select path="type" items="${types}" itemLabel="name" itemValue="index" class="form-control" styele="overflow: hidden;"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="score">评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="score" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="average">评分排名：</label>
								</div>
								<div class="col-md-3">
									<form:input path="average" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="price">参考价格：</label>
								</div>
								<div class="col-md-3">
									<form:input path="price" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="status">状态：</label>
								</div>
								<div class="col-md-3">
									<form:select path="status" items="${stats}" itemLabel="name" itemValue="index" class="form-control" styele="overflow: hidden;"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="address">地址：</label>
								</div>
								<div class="col-md-3">
									<form:input path="address" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="slogan">服务口号：</label>
								</div>
								<div class="col-md-3">
									<form:input path="slogan" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="scale">规模：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scale" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="ranking">所属地区：</label>
								</div>
								<div class="col-md-3" id="city">
									<form:select path="prov" class="prov"/>
									<form:select path="city" class="city" disabled="disabled"/>
									<form:select path="dist" class="dist" disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="distance">距离市区：</label>
								</div>
								<div class="col-md-3">
									<form:input path="distance" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="bespeak">预约人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="bespeak" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="viewNum">查看人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="viewNum" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="approvalDep">审批部门：</label>
								</div>
								<div class="col-md-3">
									<form:input path="approvalDep" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="characteristic">特色：</label>
								</div>
								<div class="col-md-3">
									<form:input path="characteristic" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="preferential">优惠：</label>
								</div>
								<div class="col-md-3">
									<form:input path="preferential" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="authentication">认证标志：</label>
								</div>
								<div class="col-md-3">
									<form:input path="authentication" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="discount">优惠标志：</label>
								</div>
								<div class="col-md-3">
									<form:input path="discount" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="retainAshes">保留骨灰：</label>
								</div>
								<div class="col-md-3">
									<form:input path="retainAshes" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="imgUrl">首页图片：</label>
								</div>
								<div class="col-md-3">
									<form:input path="imgUrl" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="introduce">介绍：</label>
								</div>
								<div class="col-md-3">
									<form:input path="introduce" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="coordinate">坐标：</label>
								</div>
								<div class="col-md-3">
									<input name="input" type="button" id="show" value="拖选" class="btn" onclick="showMapWindow();" />
									<span id="span" style="color: red;">${cemetery.coordinate}</span>
									<form:hidden path="coordinate" />
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-md-offset-9">
									<button type="submit" class="btn btn-success">保存</button>
									<a class="btn btn-primary" href="<%=basePath%>/cemetery/" target="content" role="button">返回</a>
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