<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yaDRGoon5YoRzAAwH781yUgn"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>

<script type="text/javascript">
function showMapWindow(){
	var point = $("#coordinate").val();
	var region = "";
	var dist = $("#dist").val();
	//设置地图初始区域
	if (dist != null && dist != ""){
		region = dist;
	} else {
		var city = $("#city").val();
		if (city != null && city != "") {
			region = city;
		} else {
			var prov = $("#prov").val();
			if (prov != null && prov != "")
				region = prov;
		}
	}
	//var point=$("#span").text();
	if(window.ActiveXObject){ //IE  
		var returnValue = window.showModalDialog("<%=basePath%>pub/showMapPage?region="+region+"&point="+point, window, "dialogWidth:1050px;status:no;dialogHeight:630px");  
	if(returnValue != null ){  
		setValue(returnValue);  
	}  
	}else{  //非IE  
		window.open("<%=basePath%>pub/showMapPage?region="+region+"&point="+point, 'newwindow','height=600,width=1000,top=30,left=170,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		//window.open("<%=basePath%>static/new/mapforStation.htm?point="+point, 'newwindow','height=630,width=1050,top=250,left=600,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');  
	}  
}
</script>