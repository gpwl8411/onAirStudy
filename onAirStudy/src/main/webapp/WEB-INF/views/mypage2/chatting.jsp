<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">


<script
	src="${pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
/* .chatcontent {
	overflow: auto;
	height: 100%;
	position: relative;
}   */
.chat-containerK {
	overflow: hidden;
}

.chatcontent {
	height: 500px;
	overflow-y: scroll;
}

.chat-fix {
	position: fixed;
	bottom: 0;
	width: 100%;
}
#alertK{
	display : none;
}
</style>

<div id="chat-containerK">
	<div class="chatWrap">
		<div class="main_tit">
			<h1>방 이름 [ ${roomNo}번 ] 아이디[${memberId}]</h1>
		</div>
		<div class="content chatcontent" data-room-no="${roomNo}"
			data-member="${loginMember}">
			<div class="user">
				<ul>

				</ul>
			</div>
			<ul id="list-guestbook">
				<c:forEach items="${firstList}" var="chat">
					<li data-no="${chat.no}"><strong
						style="background-color: tomato;">${chat.no}</strong> <strong>${chat.memberId}</strong>
						<p>${chat.chatContent}</p> <strong><fmt:formatDate
								value="${chat.sendDate }" pattern="yy/MM/dd HH:mm:ss" /></strong></li>
				</c:forEach>
			</ul>
			<div class="box"></div>
		</div>
		<div class="chat-fixK">
			<div id="alertK" onclick="moveDown();" class="alert alert-success" role="alert">
				<strong>Well done!</strong> You successfully read
			</div>
			<div class="fix_btn">
				<input type="text" id="msgi" name="msg" placeholder="메세지를 입력하세요" />
				<button type="button" class="send">보내기</button>
			</div>
		</div>

	</div>
</div>
<script>
//생성된 메시지로 가기//맨 아래로 가기
function moveDown(){
	$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
	$('#alertK').css('display','none');
	
}
$(document).ready(function() {
	//시작할때 스크롤 내리기
	$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
	//alert("안되는거 같지..?");
	var isEnd = false;
	var isScrolled = false;
	var fetchList = function() {
		if (isEnd == true) {
			return;
		}

		// 채팅 리스트를 가져올 때 시작 번호
		// renderList 함수에서 html 코드를 보면 <li> 태그에 data-no 속성이 있는 것을 알 수 있다.
		// ajax에서는 data- 속성의 값을 가져오기 위해 data() 함수를 제공.
		var endNo = $("#list-guestbook li").first().data("no") || 0;
		console.log("endNo" + endNo);
		$
				.ajax({
					url : "${pageContext.request.contextPath}/chat/chatList.do?endNo="
							+ endNo + "&roomNo=${roomNo}",
					type : "GET",
					dataType : "json",
					success : function(result) {
						console.log(result[0]);

						// 컨트롤러에서 가져온 방명록 리스트는 result.data에 담겨오도록 했다.
						// 남은 데이터가 5개 이하일 경우 무한 스크롤 종료
						var length = result.size;
						if (result[0].no == 1) {
							//console.log("resultno"+ result[0].no);
							isEnd = true;
						}
						$.each(result, function(index, vo) {
							renderList(false, vo);

						})
						var position = $('[data-no=' + (endNo - 1)+ ']').offset();//위치값
						console.log(position);
						//$('#chat-containerK').stop().animate({scrollTop : position.top},600,'easeInQuint');
						//window.scrollTo({top:position.top, behavior:'auto'});
						//$(".chatcontent").animate({scrollTop:position},0);
						document.querySelector('.chatcontent').scrollTo({top : position.top,behavior : 'auto'});
						isScrolled = false;
					},
					error : function(xhr, status, err) {
						console.log("처리실패!");
						console.log(xhr);
						console.log(status);
						console.log(err);
					}
				});
	}

	var renderList = function(mode, vo) {
		//alert("아뭐냐구");
		// 리스트 html을 정의
		var html = "<li data-no='"+ vo.no +"'>"
				+ "<strong>" + vo.no + "</strong>"
				+ "<strong>" + vo.memberId + "</strong>"
				+ "<p>" + vo.chatContent + "</p>"
				+ "<strong>" + vo.sendDate + "</strong>"
				+ "</li>"

		if (mode) {
			$("#list-guestbook").prepend(html);
		} else {
			$("#list-guestbook").prepend(html);
		}
	}
	//무한 스크롤
	$(".chatcontent").scroll(function() {
		//console.log("???");
		var $window = $(this);
		var scrollTop = $window.scrollTop();
		var windowHeight = $window.height();
		var documentHeight = $(document).height();

		//console.log("documentHeight:" + documentHeight + " | scrollTop:" + scrollTop + " | windowHeight: " + windowHeight );

		// scrollbar의 thumb가 위의1px까지 도달 하면 리스트를 가져옴//말 잘 안들었어
		if (scrollTop < 1 && isScrolled == false) {
			isScrolled = true;
			fetchList();

		}
	})

	////////////////////socket
	//새로운 메시지 알림
	function newAlerts(content,endNo) {
		//alert("새로운 메시지 도착!");
		$('#alertK').css('display','block');
		$('#alertK').html(content.chatContent);
	}
	
	$(function() {
		var chatBox = $('.box');
		var messageInput = $('input[name="msg"]');
		var roomNo = "${roomNo}";
		var member = $('.content').data('member');
		var sock = new SockJS(
				"${pageContext.request.contextPath}/endpoint");
		var client = Stomp.over(sock);

		function sendmsg() {
			var message = messageInput.val();
			//alert("메시지"+message);
			if (message == "") {
				return false;
			}
			client.send('/app/hello/' + roomNo, {}, JSON
					.stringify({
						chatContent : message,
						memberId : "honggd"

					}));

			messageInput.val('');
		}

		client.connect({},function() {
			// 여기는 입장시
			//alert("로그인 정보"+"${loginMember.memberId}");
			//client.send('/app/join/'+ roomNo , {}, JSON.stringify({ writer: member})); 
			//	           일반메세지 들어오는곳         
			client
					.subscribe(
							'/subscribe/chat/'
									+ roomNo,
							function(chat) {
								var endNo = $("#list-guestbook li").last().data("no") + 1;
								//받은 데이터
								var content = JSON
										.parse(chat.body);
								if (content.memberId == "kinghj") {
									//내 채팅 메시지일때
									var html = "<li data-no='"+ endNo +"'>"
											+ "<strong>"
											+ endNo
											+ "</strong>"
											+ "<strong>"
											+ content.memberId
											+ "</strong>"
											+ "<p>"
											+ content.chatContent
											+ "</p>"
											+ "<strong>"
											+ content.sendDate
											+ "</strong>"
											+ "</li>"
									$(
											"#list-guestbook")
											.append(
													html);
									//chatBox.append("<div style='color : grey;'><li>" + content.memberId + " :  <br/>" + content.chatContent + "</li>").append('<span>' + "[보낸 시간]" + content.sendDate + "</span>" + "</div><br>");

								} else {
									//다른사람의 메시지일때
									var html = "<li data-no='"+ endNo +"'>"
											+ "<strong>"
											+ endNo
											+ "</strong>"
											+ "<strong>"
											+ content.memberId
											+ "</strong>"
											+ "<p>"
											+ content.chatContent
											+ "</p>"
											+ "<strong>"
											+ content.sendDate
											+ "</strong>"
											+ "</li>"
									$(
											"#list-guestbook")
											.append(
													html);
									//chatBox.append("<li>" + content.memberId + " :  <br/>" + content.chatContent + "</li>").append('<span>' + "[보낸 시간]" + content.sendDate + "</span>" + "<br>");

								}
								newAlerts(content,endNo);
								
							});

						});
		//	         대화시
		$('.send').click(function() {
			//alert("눌리나?");
			sendmsg();
		});

		//채팅창 떠날시에
		function disconnect() {
			if (client != null) {
				client.disconnect();
			}
		}
		window.onbeforeunload = function(e) {
			disconnect();
		}

		function closeConnection() {
			sock.close();
		}

		function viewList() {

			alert('viewList');
			var url = "/chat/chatList?page=" + page
					+ "&perPageNum=" + perPageNum;
			location.replace(url);
		}

	});

});
	//여기 위에까지가 방 입장하자마자
</script>
