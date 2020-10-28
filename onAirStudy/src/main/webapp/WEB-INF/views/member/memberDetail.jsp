<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
div#member-update-container input.form-control{width:50%; text-align:center; margin: 0 auto;}

</style>

<div class="col-lg p-0">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
</div>
<div class="row">
	<div class="col-lg-2">
		<jsp:include page="/WEB-INF/views/mypage1/mypageSideBar.jsp"></jsp:include>
	</div>
	<div class="col-lg-10 p-0" id="member-update-container">
		<form name="memberUpdateFrm" 
			  action="${pageContext.request.contextPath}/mypage1/memberUpdate.do" 
			  onsubmit="return MupdateValidate();"
			  method="post">
			<input type="text" class="form-control" placeholder="아이디" name="memberId" id="memberId" value="${ loginMember.memberId }"  readonly/>
			<input type="text" class="form-control" placeholder="비밀번호" name="password" id="password_" value="${ loginMember.password }" required />
			<input type="password" class="form-control" placeholder="비밀번호체크" name="passwordCheck" id="passwordCheck_" value="${ loginMember.password }" required/>
			<input type="text" class="form-control" placeholder="이름" name="memberName" id="memberName" value="${ loginMember.memberName }" readonly />
			<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value="${ loginMember.phone }" required />
			<input type="text" class="form-control" placeholder="자기소개" name="comment" id="comment" value="${ loginMember.comment }" />
			
			<input type="text" class="form-control" placeholder="성실포인트" name="diligentPoint" id="diligentPoint" value="${ loginMember.diligentPoint }" readonly />
			<input type="text" class="form-control" placeholder="블랙리스트" name="blacklist" id="blacklist" value="${ loginMember.blacklist }" readonly />
			<br />
			<input type="hidden" name="memberId" value="${ loginMember.memberId }" />
			<input type="submit" class="btn btn-outline-success" value="수정" >&nbsp;
			<input type="reset" class="btn btn-outline-success" value="취소">
		</form>
		<form action="${pageContext.request.contextPath}/mypage1/uploadProfile"
		      onsubmit="return uploadProfileValidate();">
		<div style="border:3px solid #000; width:30%">
			<input type="file" class="custom-file-input" name="upFile" id="upFile1" value="프로필사진 첨부"  >
			<label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
			<input type="submit" class="btn btn-outline-success" value="프로필사진 업로드" >
		</div>
		</form>
	</div>
</div>
<script>
function uploadProfileValidate(){

	return true;
}

function MupdateValidate(){
	//비밀번호 똑같은지
    if($("#password_").val() != ($("#passwordCheck_").val())){ 
	    alert("비밀번호가 틀렸네용.");
	    $("#password_").val("");
	    $("#passwordCheck_").val("");
	    $("#password_").focus();
    	return false;
    }
  	//비밀번호
    if(!/^[a-zA-Z0-9]{4,12}$/.test($("#password_").val())) {
    alert("비밀번호는 4~12자리 영문,숫자만  가능해요");
    $("#password_").val("");
    $("#password_").focus();
    return false;
    }
  	//휴대폰번호
	if(!/^[0-9]{11}$/.test($("#phone").val())) {
	alert("휴대폰번호 11자리수를 입력해주세요");
	$("#phone").val("");
	$("#phone").focus();
	return false;
	}

	//자기소개
	if(!/^[가-힣]{20}$/.test($("#comment").val())) {
	alert("자기소개는 20글자 이내로 작성해주세요");
	$("#comment").val("");
	$("#comment").focus();
	return false;
	}
    
    return true;
}

 $(function(){
	//파일 선택/취소 파일라벨명을 업로드된 파일로 변경한다.
	$("[name=upFile]").on("change", function(){
		//방금 선택한 파일
		var file = $(this).prop('files')[0];
		var $label = $(this).next(".custom-file-label");
	
		if(file == undefined)
			$label.html("파일을 선택하세요");
		else
			$label.html(file.name);
	});
	
	
});
</script>

<div class="col-lg p-0">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</div>

