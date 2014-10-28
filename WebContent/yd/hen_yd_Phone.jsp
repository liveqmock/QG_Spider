<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/domain.jsp" flush="true"/> 
<html>
<style>
.error-tip {
display: inline-block;
margin-left: 10px;
color: #F71717;
background: #FFEBEB;
border: 1px solid #ffbdbe;
padding: 4px;
border-radius: 3px;
display:none;
}
</style>
	
	
	
	
					<c:set var="currentNet" value="中国移动"/>
        			<c:set var="url" value="${putong_hn_yidong_url}"/>
        			<c:set var="result" value="putong_hn_yidong"/>
        			<form id="form1" class="base-form" action="">
        					<input type="hidden" name="resultCode" id="result_hnyd_code" value="0"/>
							<input type="hidden" name="imgcode" id="imgcode_hnyd" value=""/>
							
						    <input type="hidden" name="putong_hn_yidong_userName1" id="putong_hn_yidong_userName1" value=""/>
						<h2 class="base-form-title">中国移动：</h2>
						
						  <input type="hidden" name="${result}_hidden" id="${result}_hidden" value="false"/>
						
						<div class="base-fieldset clearfix">
							<span class="base-fieldset-title">
								<label>手机号</label>
							</span>
							<span class="base-form-phone">
								${phone}
								<input type="hidden" name="${result}_userName" id="${result}_userName"  value="${phone}" />
							</span>
						</div>
						
						<div style="padding-left: 120px">
							<label id="${result}_password_tip" class="error-tip" >请输入密码</label>
							<label id="password_tip" class="error-tip" >请输入密码</label>
						</div>
						<div class="base-fieldset login-fieldset clearfix">
							<span class="base-fieldset-title login-fieldset-title">
								<label>服务密码</label>
							</span>
							<input class="base-fieldset-input w173" name="password" id="password" size="30" type="password"/>
							<a href="http://service.ha.10086.cn/service/self/passwd-reset.action?menuCode=1110" target="_blank" class="base-forgetpwd">忘记密码</a>
						</div>
						
						<div style="padding-left: 120px">
						<label id="authcode_tip" class="error-tip" >请输入验证码</label>
						<label id="authcode_message" class="error-tip" >验证码错误</label>
						</div>
						<div class="base-fieldset clearfix"  id="${result}_authcode" style="display:none;">
							<span class="base-fieldset-title">
								<label>验证码</label>
							</span>
							
							<input class="base-fieldset-input w173" name="authCode" id="authCode" type="text"/>
		  					<label class="base-form-checkimglab">
							<img  onclick="checkAuth()" src="<c:if test="${url ne 'none'}">${imgPath}${url}</c:if>" id="putong_hn_yidong_authcode_img"  style="height:30px;width:60px;position: relative;top: 8px;"/>
						
		  					</label>
		  					<label class="base-form-changelab">
		  						看不清？<a class="" href="javascript:checkAuth();">换一张</a>
		  					</label>
						</div>
						<div class="base-fieldset base-form-submit">
							<input id="lastBtn"  type="button" value="上一步" class="base-btn w120" trigger="base-btn-hover"/>
							<input id="saveBtn" type="button" value="下一步" class="base-btn w120 base-nextstep" onclick="checkField();return false;" trigger="base-btn-hover"/>
						</div>
						<!-- <p class="base-from-console" id="message" style="display: none">
							<span class="base-from-wrd">正在加载验证码，请稍等...</span>
						</p> -->				
						<p class="base-from-console">
							<span class="base-from-wrd" id="message" style="display:none;">正在登陆中，请稍等。。。</span>
						</p>
					</form>
					<form id="form2" class="base-form base-element-hidden" action="">
						<input  name="isSecond" id="isSecond" type="hidden"/>
					    <input  name="spid" id="spid" type="hidden"/>
					    <input type="hidden" name="msgMonthIndex" id="msgMonthIndex" value=""/>
						<div class="base-fieldset login-fieldset clearfix">
							<span class="base-fieldset-title login-fieldset-title">
								<label>手机验证码</label>
							</span>
							<input name="smsCode" id="smsCode"  class="base-fieldset-input w173"/>
							<a href="javascript:void(0);" class="base-forgetpwd" onclick="getydDynpass();" id="sendCode">获取动态密码</a>	
						</div>
						
						
						<div class="base-fieldset base-form-submit">
							<input id="lastBtn" type="button" value="上一步" class="base-btn w120" trigger="base-btn-hover"/>
							<input id="saveBtn" type="button" value="下一步" class="base-btn w120 base-nextstep" trigger="base-btn-hover" onclick="checkField();return false;"/>
						</div>
						<p class="base-from-console">
							<span class="base-from-wrd" id="_dongtai_password_message_tip" style="display:none;"></span>
							<span class="base-from-wrd" id="error_message" style="display:none;">页面错误,请刷新重试</span>
						</p>
					</form>
					
					
</div>        			
<script type="text/javascript">


$(document).ready(function(){
	//初始化登陆页面
	initloginPage();
});

/* function checkAuth(){
	var timestamp=new Date().getTime();
	 var phoneNum = '${phone}';
		$.ajax({
		     type:'post',
	         async:false,
		     url:'/${ctx}/putonghnydFirst.html',
		     data:{random2:Math.random(),"loginName":phoneNum},
		     success : function(data) {
		    	 if(data.url!="none"){
			    	  var url = data.url+"&time="+timestamp;
			    	  $("#imgcode_hnyd").val(url);
					  $('#putong_hn_yidong_authcode_img').attr("src","${imgPath}"+url);
					  $("#putong_hn_yidong_authcode").show();
		    	 }
		    }, 
		   error:function(){	
			}
		   });
} */
function initloginPage(){
		var phoneNum = '${phone}';
		$.ajax({
		     type:'post',
	         async:false,
		     url:'/${ctx}/putonghnydFirst.html',
		     data:{"loginName":phoneNum},
		     success : function(data) {
		    	 if(data.state==true){
		    	 	return;
		    	 }
		    }, 
		   error:function(){	
			}
		   });
}

	
	function getydDynpass(){
		$("#_dongtai_password_message_tip").text("正在发送手机动态口令....");
		$("#_dongtai_password_message_tip").show();
		$("sendCode").attr('disabled','disabled'); 
		var telno = "${phone}";
		//var msgMonthIndex = $("#msgMonthIndex").val();
		$.ajax({
		     type:'post',
	         async:false,
		     url:'/${ctx}/hn_yidong_sendCard.html',
		     //data:{"loginName":telno,random2:Math.random(),msgMonthIndex:msgMonthIndex},
		     data:{"loginName":telno},
		     success : function(data) {
					var message='';
			       /* if(data.sendFlag=='true'){
			    	   message=data.msg;
					}else{
						message=data.msg;
				   } */
			    	message=data.msg;
		          $("#_dongtai_password_message_tip").text(message);
		          $("#_dongtai_password_message_tip").show();
		          $("sendCode").removeAttr("disabled");
		    	 },
		    	 error:function(){					    		
				     }
		     });	
	}

	function checkField(){ 
		var flag = true;
		if(flag==true){
			 var isSecond = $("#isSecond").val();
			 $("#message").hide();
			if(isSecond!=null && isSecond=="1"){
				$("#message").text("正在努力登录中，请稍等……");
				$("#message").show(500,secondSubmit);
			}else{
				//alert(2);
				$("#message").text("正在努力登录中，请稍等……");
				$("#message").show(500,firstSubmit);
			}
			
			
			return false;
		}
	}
	
	function firstSubmit(){

		var vertifyUrl='/${ctx}/fuwu_hn_yidong_vertifyLogin.html';
		var phoneValue = '${phone}';
	    var passwordValue = $("#password").val();
	    var authCode = $("#authCode").val();
	    
	    
	     $("#password_tip").hide();
	     $("#authcode_tip").hide();
	     $("#authcode_message").hide();
	     $("#message").text("");
	    if(passwordValue==''||passwordValue== undefined){
	        $("#password_tip").show();
	    	return false;
	    }              
	    var style = $("#putong_hn_yidong_authcode").attr("style");
	    //alert(style);
	    if(style!='display: none;'){
	    	 if (authCode==''||authCode== undefined){
	 	        $("#authcode_tip").show();
	 	    	return false;
	 	    }
	    }
	  
	    $("#message").attr("style","dislpay:block;");
	    $.ajax({
		     type:'post',
	         async:false,                                                            
		     url:vertifyUrl,	     
		     data:{loginName:phoneValue,password:passwordValue,"resultCode":1,authcode:authCode},
		     success : function(data) {
		    	 $("#message").hide();
		    	 
		    	 if(data.state==true){
				    	 $("#form2").show();
				    	  $("#form1").hide();
				    	  $("#isSecond").val("1");
				    	 //$("#msgMonthIndex").val(data.msgMonthIndex);
				    }else{
				    	var msg = data.msg;
				    	$("#_dongtai_password_message_tip").text(msg);
		    		 	$("#_dongtai_password_message_tip").show();
		    		 	if(data.state=='false'){
				    		initloginPage();
				 		}
					}
		    	},
		    	 error:function(){		    		
		    		 
		    	 }
		     });
		
	}
	
	function secondSubmit(){
		var vertifyUrl='/${ctx}/dongtai_hn_yidong_vertifyLogin.html';
		var smsCode = $("#smsCode").val();
	    //var spid = $("#spid").val();
	    var phone = '${phone}';
	    //var msgMonthIndex = $("#msgMonthIndex").val();
	    
		$.ajax({
		     type:'post',
	         async:false,                                                            
		     url:vertifyUrl,
		     data:{dtpassword:smsCode,loginName:phone},
		     success : function(data) {
		     	var msg= data.msg;
		     	var state = data.state;
		    	 $("#message").hide();
		    	 if(state==true){
		    		 window.location.href="/${ctx}/entranceEmail.html";
				 }else if(state==false){
					 $("#_dongtai_password_message_tip").text(msg);
		    		 $("#_dongtai_password_message_tip").show();
				 }else{
				 	 alert("登录失败,动态密码错误.");
				 }
		    	},
		    	 error:function(){
		    		$("#message").show();
		    		$("#message").text(msg);
		    	 }
		     });
	}
			
</script>
</html>