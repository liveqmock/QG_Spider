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
					<c:set var="currentNet" value="江苏电信"/>
					<c:set var="locationUrl" value="/${ctx}/dx/js"/>
        			<c:set var="result" value="putong_zj_dianxin"/>
        			<input type="hidden" name="isSecond" id="${result}isSecond"  value="0" />
        			<form id="form1" class="base-form" action="">
						<h2 class="base-form-title">江苏电信：</h2>
						<div class="base-fieldset clearfix">
							<span class="base-fieldset-title">
								<label>手机号</label>
							</span>
							<span class="base-form-phone">
								${phone}
								<input type="hidden" name="phone" id="${result}phone"  value="${phone}" />
							</span>
						</div>
						<div style="padding-left: 120px">
							<label id="${result}password_tip" class="error-tip" >请输入密码</label>
						</div>
						<div class="base-fieldset login-fieldset clearfix">
							<span class="base-fieldset-title login-fieldset-title">
								<label>服务密码</label>
							</span>
							<input class="base-fieldset-input w173" name="password" id="${result}password" size="30" type="password"/>
							<a class="base-forgetpwd" href="http://js.189.cn/getBackPwd_getPassBackAction.action" target="_blank">忘记密码</a>
						</div>
						<div style="padding-left: 120px">
						<label id="${result}authcode_tip" class="error-tip" >请输入验证码</label>
						<label id="${result}authcode_message" class="error-tip" >验证码错误</label>
						</div>
						<div class="base-fieldset clearfix" id="${result}authimg" style="display:none">
							<span class="base-fieldset-title">
								<label>验证码</label>
							</span>
							
							<input class="base-fieldset-input w173" name="authCode" id="${result}authCode" type="text"/>
		  					<label class="base-form-checkimglab">
							<img  onclick="getAuth()" src="" id="${result}authcode_img" style="height:30px;width:60px;position: relative;top: 8px;"/>
						
		  					</label>
		  					<label class="base-form-changelab">
		  						看不清？<a class="" href="javascript:getAuth();">换一张</a>
		  					</label>
						</div>
						<div class="base-fieldset base-form-submit">
							<input id="lastBtn"  type="button" value="上一步" class="base-btn w120" trigger="base-btn-hover"/>
							<input id="saveBtn" type="button" value="下一步" class="base-btn w120 base-nextstep" onclick="checkField();return false;" trigger="base-btn-hover"/>
						</div>
						<p class="base-from-console">
							<span class="base-from-wrd" id="${result}message" style="display:none;"></span>
						</p>
					</form>
					<form id="form2" class="base-form base-element-hidden" action="">
					<input  name="spid" id="spid" type="hidden"/>
						<div class="base-fieldset login-fieldset clearfix">
							<span class="base-fieldset-title login-fieldset-title">
								<label>手机验证码</label>
							</span>
							<input name="authCode" id="${result}phoneCode"  class="base-fieldset-input w173"/>
							<a href="javascript:void(0);" class="base-forgetpwd" onclick="getSms();" id="${result}sendCode">获取动态密码</a>	
						</div>
						<div class="base-fieldset base-form-submit">
							<input id="lastBtn1" type="button" value="上一步" class="base-btn w120" trigger="base-btn-hover"/>
							<input id="saveBtn1" type="button" value="下一步" class="base-btn w120 base-nextstep" trigger="base-btn-hover" onclick="checkField();return false;"/>
						</div>
						<p class="base-from-console">
							<span class="base-from-wrd" id="${result}message1" style="display:none;"></span>
						</p>
					</form>
					</div>
        			
        			
<script type="text/javascript">



$(document).ready(function(){
	//getAuth();
	getInitAuth("${locationUrl}/first.html");
});
function getAuth(){
	getInitAuth("${locationUrl}/image.html");
}

function getInitAuth(requesturl){
	var phone = ${result}("phone").val();
	var t = new Date().getTime();
	if(phone!=''){
		$.ajax({
	   	 	 type:'post',
      		 data:{"loginName":phone,"t":t},
	     	 url:requesturl,
	         success : function(data) {
	         		if(data.state){
	         			//$("#form1").hide();
						//${result}("isSecond").val("1");
						//$("#form2").show();
						 window.location.href="/${ctx}/entranceEmail.html";	
	         		}else{
	         			var url = data.url;
	    	 	   	    if(url != 'none'){		
	    	 			 ${result}("authimg").show(); 	
	    	 			 ${result}("authcode_img").attr("src",'${imgPath}'+url+"?l="+new Date().getTime());
	    		   	    }
	         		}
	    	    },
  		      error:function(){	  }
	  	   });
	}
}

function checkField(){ 
		
	
		 var isSecond = ${result}("isSecond").val();
		if(isSecond=="1"){
			var mess = ${result}("message1");
			mess.text("正在验证中，请稍等……");
			mess.show(500,secondSubmit);
		}else{
		var mess = ${result}("message");
			mess.text("正在努力登录中，请稍等……");
			mess.show(500,firstSubmit);
		}
		
		
}
function firstSubmit(){
	var vertifyUrl='${locationUrl}/login.html'+"?t="+new Date().getTime();
	var phoneValue = ${result}("phone").val();
    var passwordValue = ${result}("password").val();
    var authCode =${result}("authCode").val();
    
    ${result}("password_tip").hide();
    ${result}("authcode_tip").hide();
    ${result}("authcode_message").hide();
   // ${result}("message").text("");
    if(passwordValue==''||passwordValue== undefined){
   	    ${result}("password_tip").show();
    	return false;
    }
    if(!${result}("authimg").css("display")){
      if (authCode==''||authCode== undefined){
    	 ${result}("authcode_tip").show();
    	return false;
    	}
    }
  	$("#saveBtn").attr('disabled','disabled'); 
	$.ajax({
	     type:'post',
       	 async:true,                                                            
	     url:vertifyUrl,
	     data:{"loginName":phoneValue,password:passwordValue,"authcode":authCode},
	     success : function(data) {
			   if(data.state){
			  	 	if(data.isSecLogin){
						$("#form1").hide();
						${result}("isSecond").val("1");
						$("#form2").show();		
			   		}else if(data.isSecCheck==2){
						 window.location.href="/${ctx}/entranceEmail.html";
			  	 	}
			   	
				}else{
					if(data.url!='none'){
						${result}("authimg").show(); 	
	    	 		 	${result}("authcode_img").attr("src",'${imgPath}'+data.url+"?l="+new Date().getTime());
					}
					${result}("message").text(data.msg);
				}
				$("#saveBtn").removeAttr("disabled");
	    	},
	    	 error:function(){
	    		 ${result}("message").text("系统错误,请刷新页面重试!");
	    		$("#saveBtn").removeAttr("disabled");
	    	 }
	     });
}
function ${result}(id){
	var result = "${result}";
	return $("#"+result+id);
}



function getSms(){
	var phoneValue = ${result}("phone").val();
	${result}("message1").text("正在发送手机动态口令....").show();
	${result}("sendCode").attr('disabled','disabled'); 
	$.ajax({
	     type:'post',
	     url:'${locationUrl}/getSms.html'+"?t="+new Date().getTime(),
	     data:{"loginName":phoneValue},
	     success : function(data) {
	    	 	${result}("message1").text(data.msg);
				${result}("sendCode").removeAttr("disabled");
	    	 },
  	 error:function(){	
  	 		${result}("message1").text("发送异常,请重试!");
  	 		${result}("sendCode").removeAttr("disabled");	    		
			     }
	     });
	
}
function secondSubmit(){
	var mess = ${result}("message1");
	var vertifyUrl='${locationUrl}/checkDynamics.html'+"?t="+new Date().getTime();
	var smsCode = ${result}("phoneCode").val();
	var phone = ${result}("phone").val();
	
	if(smsCode==''||smsCode.length==0||smsCode==undefined)
	{
		alert('请先点击"获取动态密码"链接，再填入验证码');
		return false;
	}
	
	mess.text("正在验证中，请稍等。。。");//.attr("style","dislpay:block;");
    $.ajax({
	     type:'post',
	     url:vertifyUrl,
	     data:{"phoneCode":smsCode,"loginName":phone},
	     success : function(data) {
	    	 if(data.state){
	    	 	 var spiderurl = "${locationUrl}/startSpider.html"+"?t="+new Date().getTime();
	    	  	 $.post(spiderurl,{"type":"2","loginName":phone,"authcode":data.authcode},function(data){});
	    		 window.location.href="/${ctx}/entranceEmail.html";
			 }else{
				 mess.text(data.msg);
				}        
	    	},
	    	 error:function(){
	    		mess.show();
	    		mess.text("验证错误,请稍后再试!");
	    	 }
	     });
}
	
	
</script>
</html>