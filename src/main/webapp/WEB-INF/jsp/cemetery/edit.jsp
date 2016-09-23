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
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">基本信息</label>
							</div>
							
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="name">园区名称：</label>
								</div>
								<div class="col-md-3">
									<form:input path="name" class="form-control pull-left" placeholder="公墓名称"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="status">状态：</label>
								</div>
								<div class="col-md-3">
									<form:select path="status" items="${stats}" itemLabel="name" itemValue="index" class="form-control" styele="overflow: hidden;"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="approvalDep">审批部门：</label>
								</div>
								<div class="col-md-3">
									<form:input path="approvalDep" class="form-control"/>
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
									<label for="address">园区地址：</label>
								</div>
								<div class="col-md-3">
									<form:input path="address" class="form-control pull-left"/>
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
									<label for="coordinate">园区坐标：</label>
								</div>
								<div class="col-md-3">
									<input name="input" type="button" id="show" value="拖选" class="btn" onclick="showMapWindow();" />
									<span id="span" style="color: red;">${cemetery.coordinate}</span>
									<form:hidden path="coordinate" />
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="scale">园区规模：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scale" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right;">
									<label for="characteristic">墓穴数量：</label>
								</div>
								<div class="col-md-3">
									<form:input path="characteristic" class="form-control pull-left"/>
								</div>
								
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="characteristic">园区特色：</label>
								</div>
								<div class="col-md-3">
									<form:input path="characteristic" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="slogan">园区印象：</label>
								</div>
								<div class="col-md-3">
									<form:input path="slogan" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="price">参考均价：</label>
								</div>
								<div class="col-md-3">
									<form:input path="price" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="slogan">咨询热线：</label>
								</div>
								<div class="col-md-3">
									<form:input path="slogan" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="characteristic">看墓专车：</label>
								</div>
								<div class="col-md-3">
									<form:input path="characteristic" class="form-control pull-left"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="price">园区介绍：</label>
								</div>
								<div class="col-md-10">
									<textarea class="col-md-10" rows="8"></textarea>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="imgUrl">首页图片：</label>
								</div>
								<div class="col-md-3">
									<form:input path="imgUrl" class="form-control"/>
								</div>
								
							</div>
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">客户关注及评分</label>
							</div>
							<div class="row">
								<div class="col-md-2"  style="text-align: right;">
									<label for="score">总评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="score" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="average">总评分排名：</label>
								</div>
								<div class="col-md-3">
									<%-- <form:input path="average" class="form-control"/> --%>
								</div>
							</div>
							<div class="row">
									<label for="name">&nbsp;</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="score">风水评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scoreFs" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="average">交通评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scoreJt" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="score">环境评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scoreHj" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="average">服务评分：</label>
								</div>
								<div class="col-md-3">
									<form:input path="scoreFw" class="form-control"/>
								</div>
							</div>
							<div class="row">
									<label for="name">&nbsp;</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="viewNum">关注人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="viewNum" class="form-control pull-left"/>
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
									<label for="viewNum">评价人数：</label>
								</div>
								<div class="col-md-3">
									<form:input path="viewNum" class="form-control pull-left"/>
								</div>
								
							</div>
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">园区提供</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="distance">是否专车接送：</label>
								</div>
								<div class="col-md-3">
									<form:input path="distance" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="bespeak">是否一对一服务：</label>
								</div>
								<div class="col-md-3">
									<form:input path="bespeak" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="distance">是否可寄存骨灰盒：</label>
								</div>
								<div class="col-md-3">
									<form:input path="distance" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="bespeak">是否提供下葬仪式：</label>
								</div>
								<div class="col-md-3">
									<form:input path="bespeak" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="distance">是否提供清明节班车：</label>
								</div>
								<div class="col-md-3">
									<form:input path="distance" class="form-control pull-left"/>
								</div>
								<div class="col-md-2 col-md-offset-1" style="text-align: right">
									<label for="bespeak">是否提供免费停车：</label>
								</div>
								<div class="col-md-3">
									<form:input path="bespeak" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="distance">是否提供休息区：</label>
								</div>
								<div class="col-md-3">
									<form:input path="distance" class="form-control pull-left"/>
								</div>
								
							</div>
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">认证标志</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="authentication">实地认证：</label>
								</div>
								<div class="col-md-3">
									<form:input path="authentication" class="form-control pull-left"/>
								</div>
							</div>
							<div class="row" style="background-color:#F5F5F5;">
									<label for="name">优惠活动</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="preferential">优惠政策：</label>
								</div>
								<div class="col-md-3">
									<form:input path="preferential" class="form-control"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="preferential">优惠类型：</label>
								</div>
								<div class="col-md-3">
									<form:input path="preferential" class="form-control"/>
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