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
						<form:form id="editform" modelAttribute="zone" class="form-horizontal" method="POST">
							<form:hidden path="id"/>
							
							<div class="row" style="background-color:#F5F5F5;">
									<label for="info">园区信息</label>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="whe">所属地域：</label>
								</div> 
								<div class="col-md-3" id="city">
									<input type="text" placeholder="忽略行政区域" id="regionname" 
													data-key="0086" data-idx="0" data-full="中国" class="form-control inp-search" value="${gmfn:regionFullName(cemetery.regionno) }"/> 
									<div class="localcity selectCity" id="selectCity"></div>
									<input type="hidden" id="regionno" value="${cemetery.regionno }"/>
								</div>
								<div class="col-md-2" style="text-align: right;">
									<label for="whegm">所属公墓：</label>
								</div>
								<div class="col-md-3">
									<form:select path="cemId" items="${cemeterys}" itemLabel="name" itemValue="id" class="form-control" styele="overflow: hidden;"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right">
									<label for="name">园区名称：</label>
								</div>
								<div class="col-md-3">
									<form:input path="name" class="form-control pull-left" placeholder="园区名称"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2" style="text-align: right;">
									<label for="price">园区描述：</label>
								</div>
								<div class="col-md-10">
									<form:textarea class="col-md-10" rows="8" path="description"/>
								</div>
							</div>
							
							<br>
							<div class="row">
								<div class="col-md-offset-9">
									<button type="submit" class="btn btn-success">保存</button>
									<a class="btn btn-primary" href="<%=basePath%>/zone/" target="content" role="button">返回</a>
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
		var localsel = $("#selectCity").localCity({
			provurl : "<%=basePath%>pub/findRegion",
			cityurl : "<%=basePath%>pub/findRegion",
			disturl : "<%=basePath%>pub/findRegion",
			callback : function (index, key, value, fullkey, fullname) {
				$("#regionname").val(fullname);
				$("#regionno").val(key);
				if (index == 3){
					$("#selectCity").hide();
					getCemeterys($("#regionno").val());
				}
			}
		});
		
		$("#regionname").click(function() {
			$("#selectCity").show();
		});
		
		function getCemeterys(regionno){
			var postParam = "regionno=" + regionno;             
            $.ajax({    
                type:'GET',        
                url:'<%=basePath%>cemetery/getCemeterys',    
                data:postParam,    
                cache:false,    
                dataType:'json',    
                success:function(res){  
                    if(res.succflag==0){
                    	html = '';
                    	for(var i=0; i<res.data.length; i++){
                    		html += '<option value="'+res.data[i].no+'">' + res.data[i].name + '</option>';
                        }
                    	$("#cemId").html(html);
                    }                                           
                }
            });
		}
	</script>
</body>
</html>