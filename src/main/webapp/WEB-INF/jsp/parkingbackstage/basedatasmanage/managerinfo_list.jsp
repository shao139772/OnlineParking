<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<meta charset="utf-8" />
	<title></title>
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- basic styles -->
	<link href="system/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="system/css/font-awesome.min.css" />
	<link rel="stylesheet" href="system/css/chosen.css" />
	<link rel="stylesheet" href="system/css/ace.min.css" />
	<link rel="stylesheet" href="system/css/ace-skins.min.css" />
	<link rel="stylesheet" href="plugins/paginate/css/lanrenzhijia.css" /> <!-- 分页样式 -->
	<script type="text/javascript" src="system/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="plugins/paginate/js/jquery.paginate.js"></script><!--分页-->
	<link rel="stylesheet" href="system/css/datepicker.css" /><!-- 日期框 -->
	<script type="text/javascript" src="system/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="system/zDialog/zDialog.js"></script>
	
	<script type="text/javascript">
	$(function(){
		var allParkInfo = ${allParkInfo} ;
		for(var i = 0 ; i < allParkInfo.datas.length ; i ++){
			for(var i = 0 ; i < allParkInfo.datas.length ; i ++){
				$("#parkInfoId").append("<option value='"+allParkInfo.datas[i].parkingInfoId+"'>"+allParkInfo.datas[i].parkingInfoName+"</option>");
			}
		}
	}) ;
		
		
	</script>
	</head>
<body onkeydown="keySearch();">
		
<div class="container-fluid" id="main-container">
<div id="page-content" class="clearfix">
		<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-home"></i>首页<span class="divider"><i class="icon-angle-right"></i></span></li>
			<li>基础数据维护<span class="divider"><i class="icon-angle-right"></i></span></li>
			<li class="active">停车场管理员信息</li>
		</ul>
	</div><!--#breadcrumbs-->

  <div class="row-fluid">
      
	<div class="row-fluid">
			<table>
				<tr>
					<td style="vertical-align:top;"> 
					 	<select class="chzn-select" name="parkInfoId" id="parkInfoId" data-placeholder="请选择停车场" style="vertical-align:top;">
					  	<option value="0">请选择停车场</option>
					  	</select>
					</td>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="phone"  maxlength="11" placeholder="这里输入手机号" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="find();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
				</tr>
			</table>
			<!-- 检索  -->
			<!-- </form> -->
			<input type="hidden" value="" id="currentPage" /><!-- 当前页 -->
			<input type="hidden" value="" id="pageSize" /><!-- 每页多少条-->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center" style="width:30px"></th>
						<th class="center">停车场名称</th>
						<th class="center">手机号</th>
						<th class="center">联系人</th>
						<th class="center">创建时间</th>
						<th class="center" style="width:50px">操作</th>
					</tr>
				</thead>
				
				
				
														
				<tbody id="t_datas">
					<tr>
						<td colspan="7" class="center">暂无数据</td>
					</tr>
				</tbody>
			</table>
		<div class="page-header position-relative">
			<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
				</td>
			</tr>
			<tr>
			 <td style="vertical-align:top;" id="page">
					 
				</td> 
			</tr>
		</table>
		</div>
		<!-- </form> -->
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='system/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="system/js/bootstrap.min.js"></script>
		<script src="system/js/ace-elements.min.js"></script>
		<script src="system/js/ace.min.js"></script>
		
		<script type="text/javascript" src="system/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="system/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="system/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="system/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript" src="system/js/jquery.json-2.4.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		//keySearch enter键 触发搜索 
		function keySearch(){
			var event = arguments.callee.caller.arguments[0]||window.event;//消除浏览器差异 
			 if(event.keyCode == 13){
				 search(1) ;
			 }
		}
		//选择框发生变化触发的事件
		$("#parkInfoId").change(function(){
			giveNum() ;
			search(1);
		});
		
		//如果当前页和当前页条数为空 则给默认值
		function giveNum(){
				 $("#currentPage").val("1") ;
				 $("#pageSize").val("20") ;
		}
		//搜索 和选择框发生变化时一样，与分页功能 分离  ，将页码值设为默认值 
		function find(){
			giveNum() ;//点击搜索按钮时，将当前页和每页条数清空,并赋予默认值 
			search(1);
		}
		//检索
		function search(type){
			top.jzts();
			var currentPage = $("#currentPage").val() ;
			var pageSize = $("#pageSize").val() ;
			var parkInfoId = $("#parkInfoId").val() ;
			if(parkInfoId==0){
				parkInfoId = "" ;
			}
			var phone = $("input[name='phone']").val().trim() ;
			var jsonstr = {"parkInfoId":parkInfoId,"phone":phone,"currentPage":currentPage,"pageSize":pageSize} ;
			if(!checkInvalid()){return false} ; //判断session是否失效 
			$.ajax({
				type: "POST",
				contentType : 'application/json',
				url: '/OnlineParking/selectManagerList',
				data:$.toJSON(jsonstr),
				dataType:'json',
				cache: false,
				success: function(allManager){
					if(allManager.datas.total==0){
						var html = "" ;
						 html += "<tr>" ;
						 html += "<td colspan=\"7\" class=\"center\">暂无数据</td>" ;
						 html += "</tr>" ;
						 $("#t_datas").html(html) ;
						 $("#page").html("") ;
						 return false ;
					}
					$("#currentPage").val(allManager.datas.pageNum) ;
					$("#pageSize").val(allManager.datas.pageSize) ;
					getDataList(allManager) ;
					//分页信息
					if(type!="paginate"){
						getPaginate( allManager.datas.pages) ;
					}
					//设置页码被选中的样式					
					//$("#page li:eq("+allManager.datas.pageNum+")").addClass("active");   			
					}
			}) ;
		}
		
		function getDataList(allManager){
			var parkName = $("#parkInfoId").find("option:selected").text();
			var parkInfoId = $("#parkInfoId").val() ;
			var html = "" ;
			for(var i = 0 ; i < allManager.datas.result.length ; i ++){
				html+="<tr>";
				html+="	<td class=\"center\"></td>";
				if(parkInfoId != 0){
					html+="	<td class=\"center\">"+parkName + "</td>";
				}else{
					html+="	<td class=\"center\">"+getParkName(allManager.datas.result[i].parkingInfoId)+"</td>";
				}
				html+="	<td class=\"center\">"+allManager.datas.result[i].parkingManagerPhone+"</td>";
				html+="	<td class=\"center\">"+allManager.datas.result[i].parkingManagerName+"</td>";
				html+="	<td class=\"center\">"+allManager.datas.result[i].parkingManagerCreateTime+"</td>";
				html+="	<td class=\"center\">";
				html+="		<div class='hidden-phone visible-desktop btn-group'>";
				html+="		<div class=\"inline position-relative\">";
				html+="		<button class=\"btn btn-mini btn-info\" data-toggle=\"dropdown\"><i class=\"icon-cog icon-only\"></i></button>";
				html+="		<ul class=\"dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close\">";
				html+="		<li><a style=\"cursor:pointer;\" title=\"编辑\" onclick=\"edit('"+allManager.datas.result[i].parkingManagerPhone+"');\" class=\"tooltip-success\" data-rel=\"tooltip\" title=\"\" data-placement=\"left\"><span class=\"green\"><i class=\"icon-edit\"></i></span></a></li>";
				html+="		<li><a style=\"cursor:pointer;\" title=\"删除\" onclick=\"del('"+allManager.datas.result[i].parkingManagerId+"');\" class=\"tooltip-error\" data-rel=\"tooltip\" title=\"\" data-placement=\"left\"><span class=\"red\"><i class=\"icon-trash\"></i></span> </a></li>";
				html+="		</ul>";
				html+="		</div>";
				html+="		</div>";
				html+="</td>";
				html+="</tr>";
			}
			//动态获取行号
			 setRowNumByJSON(allManager,'t_datas',html) ;
		}
		
		//新增 by xumingyue
		function add(){
 			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '/OnlineParking/toAddManagerInfo';
			 diag.Width = 350;
			 diag.Height = 380;
			 diag.CancelEvent = function(){ //关闭事件
			 	 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 			 var nowParkingId = $(diag.innerFrame.contentWindow.document.getElementById('parkingInfoId')).val();
			 			 var nowParkingName = $(diag.innerFrame.contentWindow.document.getElementById('zhongxin')).find(".chzn-single span").text();
			 			 $(".chzn-single span").text(nowParkingName);
						 $("#parkInfoId  option[value='"+nowParkingId+"']").attr("selected", "selected").trigger("change");//触发seelct选择方法 */
				} 
			 	 diag.close();
			 };
			 diag.show();
		}
		
		//修改 by xumingyue
		function edit(parkingManagerPhone){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = "/OnlineParking/toEditManagerInfo?parkingManagerPhone="+parkingManagerPhone;
			 diag.Width = 350;
			 diag.Height = 380 ;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 var nowParkingId = $(diag.innerFrame.contentWindow.document.getElementById('parkInfoId')).val();
		 			 var nowParkingName = $(diag.innerFrame.contentWindow.document.getElementById('zhongxin')).find(".chzn-single span").text();
		 			 $(".chzn-single span").text(nowParkingName);
					 $("#parkInfoId  option[value='"+nowParkingId+"']").attr("selected", "selected").trigger("change");//触发seelct选择方法 */
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//停车场通过员工id 删除该员工信息
		function del(parkingManagerId){
			var name = $("input[name='name']").val() ;
			var phone = $("input[name='phone']").val() ;
			var parkInfoId = $("#parkInfoId").val() ;
			var jsonstr = {"parkingManagerId":parkingManagerId} ;
			bootbox.confirm("确定要删除这条数据吗?", function(result) {
				if(result) {
					var url = "/OnlineParking/deleteParkingManager";
					if(!checkInvalid()){return false} ; //判断session是否失效 
					$.ajax({
						type:"post" ,
						url:url ,
						data:$.toJSON(jsonstr),
						dataType:'json',
						contentType : 'application/json',
						success:function(allManager){
							 top.jzts();
							 search(1) ;
						}
					}) ;
				}
			});
		}
		
		
		//获取selected控件中 value值所对应的 text
		function getParkName(parkingInfoId){
		    var parkName = "" ;
	         $("#parkInfoId option").each(function () {
	             var txt = $(this).text(); //获取单个text
	             var val = $(this).val(); //获取单个value
	             if(val == parkingInfoId){
	            	 parkName = txt; 
	             }
	         });
	         return parkName ;
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
		});
		
		
		</script>
		
	</body>
</html>

