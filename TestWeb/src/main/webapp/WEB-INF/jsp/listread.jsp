<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list detail content</title>
</head>
<body>
<div class="row" style="margin-bottom:20px; margin-left:1px;">
<div class="col-lg-12">
<h1>상세 페이지</h1>
</div>
</div>

<div class="panel" style="margin-left:1px;">
<div id="contAreaBox">
<div class="panel">
<div class="panel-body">
<div class="table-responsive" style="text-align:center;">
<table id="datatable-scroller"
	class="table table-bordered tbl_Form">
	<caption></caption>
	<colgroup>
		<col width="250px" />
		<col />
	</colgroup>
	<tbody>
		<tr>
			<th>제목</th>
			<td>
				${writing_name}
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				${writing_content}
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
			<!-- jstl c:forEach의 속성 var =for문에서 사용할 변수 items={리스트가 받아올 배열이름} varStatus=상태용 변수 -->
			<c:forEach var="file" items="${writing_file}" varStatus="status">
			    <div class="file-info">
			    <!-- aria-hidden="true"로 하면 하위의 정보들을 숨길 수 있음 -->
					<span class="glyphicon glyphicon-camera" aria-hidden="true"></span>
					<a href='<c:url value="/filedownload?file_id=${file.file_id }"/>'>${file.file_originalname }</a>
				</div>
			
			</c:forEach>
			</td>
		</tr>
	</tbody>
</table>
</div>
<div style="margin-left:1px;">
 <span><input type="button" value="목록" onClick="location.href='java'" style="font-size:10px; padding : 5px 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;
 <span><input type="button" value="글 삭제" onClick="delCheck('${writing_id}')" style="font-size:10px; padding : 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;   
 <span><input type="button" value="글 수정" onClick="reWrite('${writing_id}')" style="font-size:10px; padding : 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;   
 
 <script>
 	function delCheck(writing_id) {
 		var chk = confirm("정말 삭제하시겠습니까?");
 		if (chk) {
 			location.href="/delete?writing_id=" + writing_id;
 		}
 	}
 	
 </script>  
 <script>
 	function reWrite(writing_id) {
 			location.href="/rewrite?writing_id=" + writing_id;
 	}
 	
 </script>  
</div>
</div>
</div>
</div>
</div>
</body>
</html>