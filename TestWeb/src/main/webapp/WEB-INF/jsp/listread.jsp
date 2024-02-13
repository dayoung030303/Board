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
			<c:forEach var="file" items="${writing_file}" varStatus="status">
			    <div class="file-info">
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
           
</div>
</div>
</div>
</div>
</div>
</body>
</html>