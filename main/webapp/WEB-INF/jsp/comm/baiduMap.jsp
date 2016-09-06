<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body,html,#allmap {
	width: 100%;
	height: 100%;
	margin: 0;
	font-family: "微软雅黑";
}

#l-map {
	height: 100%;
	width: 100%;
}

#r-result {
	position: absolute;
	top: 0px;
	left: 80%;
}
</style>
<script type="text/javascript" src="<%=basePath %>static/plugins/jquery.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yaDRGoon5YoRzAAwH781yUgn"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
<title>拖动标记到正确位置，直接关闭窗口即可</title>
</head>
<body>
	<div id="l-map"></div>
	<div id="r-result"></div>
	<input type="hidden" id="point" value="${point }">
</body>
</html>
<script type="text/javascript">
	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}
	var pi = GetQueryString("point");
	var map = new BMap.Map("l-map");
	// 百度地图API功能	
	function initMap() {
		// 百度地图API功能
		var point = null
		if (pi == null || pi == "") {
			point = new BMap.Point(104.145982, 30.698948);
		} else {
			point = new BMap.Point(pi.split(",")[0], pi.split(",")[1]);
		}
		map.centerAndZoom(point, 12);
		var top_left_control = new BMap.ScaleControl({
			anchor : BMAP_ANCHOR_TOP_LEFT
		});// 左上角，添加比例尺
		var top_left_navigation = new BMap.NavigationControl(); //左上角，添加默认缩放平移控件
		var top_right_navigation = new BMap.NavigationControl({
			anchor : BMAP_ANCHOR_TOP_RIGHT,
			type : BMAP_NAVIGATION_CONTROL_SMALL
		}); //右上角，仅包含平移和缩放按钮
		map.addControl(top_left_control);
		map.addControl(top_left_navigation);
		map.addControl(top_right_navigation);
		map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
		map.enableContinuousZoom(); //启用地图惯性拖拽，默认禁用
		var marker = new BMap.Marker(point);// 创建标注
		map.addOverlay(marker); // 将标注添加到地图中
		marker.enableDragging(); // 不可拖拽

		marker.addEventListener(
						"dragging",
						function(e) {
							window.opener.document.getElementById('span').textContent = e.point.lng
									+ ", " + e.point.lat;
							window.opener.document
									.getElementById('coordinate').value = e.point.lng
									+ ", " + e.point.lat;
						})
		var bdary = new BMap.Boundary();
		bdary.get('${region}', function(rs) { //获取行政区域
			var count = rs.boundaries.length;
			for ( var i = 0; i < count; i++) {
				var ply = new BMap.Polygon(rs.boundaries[i], {
					strokeWeight : 4,
					strokeColor : "#007fff",
					strokeStyle : "dashed"
				}); //建立多边形覆盖物
				ply.setFillColor();
				map.addOverlay(ply); //添加覆盖物

				map.setViewport(ply.getPath()); //调整视野         
			}
		});

	}
	initMap();
	/* $(function(){ 
		navigator.geolocation.getCurrentPosition(translatePoint); //定位 
	}); 
	function translatePoint(position){ 
		var currentLat = position.coords.latitude; 
		var currentLon = position.coords.longitude;
		alert("currentLat="+currentLat+"currentLon="+currentLon);
		var gpsPoint = new BMap.Point(currentLon, currentLat); 
		BMap.Convertor.translate(gpsPoint, 0, initMap); //转换坐标 
	} 
	function initMap(point){ 
		//初始化地图 
		map = new BMap.Map("l-map"); 
		map.addControl(new BMap.NavigationControl()); 
		map.addControl(new BMap.ScaleControl()); 
		map.addControl(new BMap.OverviewMapControl()); 
		map.centerAndZoom(point, 15); 
		map.addOverlay(new BMap.Marker(point)) 
	}  */
</script>
