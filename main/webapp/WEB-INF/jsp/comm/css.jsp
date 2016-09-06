<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link href="http://apps.bdimg.com/libs/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
<link href="http://apps.bdimg.com/libs/fontawesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">

<!-- 本地css -->
<link rel="stylesheet" href="<%=basePath%>static/css/cloud-admin.min.css">
<link rel="stylesheet" href="<%=basePath%>static/css/bootstrap-select.min.css">
<style type="text/css">
.table-hover  tr td,th {
	text-align: center;
	font-size: 13;
}
.table-hover tr th {
	text-align: center;
}
.td_label label {
	padding-top: 7px;
}

.td_label {
	align: center;
}
</style>
