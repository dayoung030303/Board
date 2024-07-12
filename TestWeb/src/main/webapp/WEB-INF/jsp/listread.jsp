<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>LIST DETAIL CONTENT</title>
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
				<col width="250px"/>
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
							<c:if test="${file.file_delete == 'N'}">
							<a href='<c:url value="/filedownload?file_id=${file.file_id }"/>'>${file.file_originalname }</a>
							</c:if>
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
		<table>
				<colgroup>
			    	<col style="width:5%;" />
			        <col style="width:auto;" />
			    </colgroup>
			    <thead>
			    	<tr>
			         <td style="font-weight: 900;">
			           번호
			         </td>
			         <td style="font-weight: 900;">
			           제목
			         </td>
			        </tr>
			    </thead>
			    <tbody>
			    	
			        	<c:forEach var="item" items="${list}">
			                <tr>
			                    <c:if test="${item.writing_delete == 'N'}">
			                     
			                     <td>
			                      ${item.writing_id}
			                     </td>
			                     <td>
			                      <a href="listread?writing_id=${item.writing_id}&currentPage=${currentPage}">
			                       ${item.writing_name}
			                      </a>
			                     </td>
			                    </c:if>
			                    <c:if test="${item.writing_delete == 'Y'}">
			                     <td>
			                      ${item.writing_id}
			                     </td>
			                     <td> 
			                      삭제된 글입니다.
			                     </td>
			                    </c:if>
			                </tr>
			            </c:forEach>
			        
			    </tbody>
			    </table>
			     <%-- 페이징 처리 부분  --%>
			    <c:if test="${totalPages > 1}">
			    	<div>
			            <span>현재 페이지: ${currentPage + 1} / 총 페이지: ${totalPages}</span>
						<span>
						     <input type="button" value="<<" onClick="subAllClickEvent('${pageGroup}','${searchKeyword}')" style="font-size:10px; padding: 5px;" <c:if test="${pageGroup == 1}">disabled</c:if> />
						</span>
						<span>
						    <input type="button" value="<" onClick="subClickEvent('${pageGroup}','${searchKeyword}')" style="font-size:10px; padding: 5px;" <c:if test="${currentPage == 0}">disabled</c:if> />
						</span>			            
			            <c:forEach var="i" begin="${firstPageNum}" end="${lastPageNum}">
			            	<c:if test = "${i < totalPages}">
			                	<a href="/java?currentPage=${i}&searchKeyword=${searchKeyword}">${i + 1}</a>
			                </c:if>
			            </c:forEach>
			           <span><input type="button" value=">" onClick="addClickEvent('${pageGroup}','${searchKeyword}')" style="font-size:10px; padding : 5px;"<c:if test="${currentPage == totalPages - 1}">disabled</c:if> />
			           </span>
			           <span><input type="button" value=">>" onClick="addAllClickEvent('${pageGroup}','${searchKeyword}')" style="font-size:10px; padding : 5px;"
			           <c:if test="${pageGroup == lastpageGroup}">disabled</c:if> 
			           <c:if test="${currentPage + 11 > totalPages}">disabled</c:if>/>
			           </span>
			        </div>
			    </c:if>
		</div>
		</div>
		</div>
		</div>
	</body>
	
	<script>
			 	function subClickEvent(currentPage, searchKeyword) {
			 		location.href = "/java?currentPage=${currentPage-1}&searchKeyword=${searchKeyword}";	
			 	}
			</script> 
			<script>
			 	function subAllClickEvent(currentPage, searchKeyword) {
			 		location.href = "/java?currentPage=${currentPage-10}&searchKeyword=${searchKeyword}";	
			 	}
			</script> 
			<script>
			 	function addClickEvent(currentPage, searchKeyword) {
			 		location.href = "/java?currentPage=${currentPage+1}&searchKeyword=${searchKeyword}";
			 	}
			</script> 
			<script>
			 	function addAllClickEvent(currentPage, searchKeyword) {
			 		location.href = "/java?currentPage=${currentPage+10}&searchKeyword=${searchKeyword}";
			 	}
			</script> 
			<script>
				function selectAll() {
					if(document.getElementById("all").checked==true){
						for(var i=0;i<100;i++)
							document.getElementsByName("checked")[i].checked=true;
					}
					if(document.getElementById("all").checked==false){
						for(var i=0;i<100;i++)
							document.getElementsByName("checked")[i].checked=false;
					}
				};
		    </script>
</html>