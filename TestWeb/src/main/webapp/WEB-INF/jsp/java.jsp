<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.eugeneprogram.testweb.service.TestService" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JAVA BOARD</title>
	</head>
	<h1>게시판</h1>
		<body>
		    <input type="button" value="회원가입"  onClick="location.href='membership'" style="font-size:15px; padding : 8px 8px 8px 8px;float:right;"/>&nbsp;&nbsp;
		    <input type="button" value="로그인" onClick="location.href='login'" style="font-size:15px; padding : 8px 8px 8px 8px;float:right;"/>&nbsp;&nbsp;
		    
		    <div style="width:200px; height:150px; float:left; border-right:none; border-left:none; border-top:none;border-bottom:none; margin-right:10px;"> 
		    <table>
		    <div style="border: 20px solid white; width:200px; heigth: 500px; text-align: center;">
		    <span></span>
		    </div>
		    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
		    <span><input type="button" value="java" onClick="location.href='java'"></span>
		    </div>
		    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
		    <span></span>
		    </div>
		     <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
		    <span><input type="button" value="자료구조" onClick="location.href='datastructure'"></span>
		    </div>
		    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
		    <span></span>
		    </div>
		    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
		    <span><input type="button" value="C++" onClick="location.href='c++'"></span>
		    </div>
		    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
		    <span></span>
		    </div>
		    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
		    <span><input type="button" value="C" onClick="location.href='c'"></span>
		    </div>
		    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
		    <span></span>
		    </div>
		    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
		    <span><input type="button" value="공지사항" onClick="location.href='announcement'"></span>
		    </div>
		    </table>
		    </div>
		    
		    <div style="width:1000px; height:1000px; float:left; border-right:none; border-left:none; border-top:none;border-bottom:none;"> 
		    <table>
		    <div class="search_wrap" align="right">
              
            <%-- 검색어 입력하는 폼 --%>
			<form action="/java" method="GET">
			  <input type="text" name="searchKeyword" value="${searchKeyword}"/>
			  <button type="submit">검색</button>
			</form>
			    
			<table>
				<colgroup>
			    	<col style="width:5%;" />
			        <col style="width:auto;" />
			    </colgroup>
			    <thead>
			    	<tr>
			         <td>
			          <input type="checkbox" id="all" name="all" class="btn-outlin-info" onclick="selectAll()"/>
			         </td>
			         <td style="font-weight: 900;">
			           번호
			         </td>
			         <td style="font-weight: 900;">
			           제목
			         </td>
			        </tr>
			    </thead>
			    <tbody>
			    	<form action = "selectDelete">
			        	<c:forEach var="item" items="${list}">
			                <tr>
			                    <c:if test="${item.writing_delete == 'N'}">
			                     <td>
			                   	  <input type="checkbox" name="checked" class="btn-outlin-info" value="${item.writing_id}"/>
			                     </td>
			                     <td>
			                      ${item.writing_id}
			                     </td>
			                     <td>
			                      <a href="listread?writing_id=${item.writing_id}">
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
			        </form>
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
		</body>
		</html>
			            
			            <span><input type="button" value="글 작성" onClick="location.href='write'" style="font-size:10px; padding : 5px 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;
			            <span><input type="button" value="선택 삭제" onClick="location.href='selectDelete'" style="font-size:10px; padding : 5px 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;
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