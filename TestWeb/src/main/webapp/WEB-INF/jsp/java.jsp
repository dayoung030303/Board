<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.eugeneprogram.testweb.service.TestService" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>java list</title>
</head>
<h1>게시판</h1>
<body>
    <input type="button" value="회원가입"  onClick="location.href='membership'" style="font-size:15px; padding : 8px 8px 8px 8px;float:right;"/>&nbsp;&nbsp;
    <input type="button" value="로그인" onClick="location.href='login'" style="font-size:15px; padding : 8px 8px 8px 8px;float:right;"/>&nbsp;&nbsp;
    
   
   <div style="width:200px; height:150px; float:left; border-right:none; border-left:none; border-top:none;border-bottom:none; margin-right:10px;"> <table>
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
    <span><input type="button" value="C++" onClick="location.href='C++'"></span>
    </div>
    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
    <span></span>
    </div>
    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
    <span><input type="button" value="C" onClick="location.href='C'"></span>
    </div>
    <div style="border: 10px solid white; width:200px; heigth: 500px; text-align: center;">
    <span></span>
    </div>
    <div style="border: 1px solid blue; width:200px; heigth: 500px; text-align: center;">
    <span><input type="button" value="공지사항" onClick="location.href='announcement'"></span>
    </div>
    </table>
    </div>
    
    <div style="width:1000px; height:1000px; float:left; border-right:none; border-left:none; border-top:none;border-bottom:none;"> <table>
     <div class="search_wrap" align="right">
              <%-- 검색어를 입력하는 폼 --%>
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
                <th>번호</th>
                <th>제목</th>
            </tr>
        </thead>
        <tbody>
        
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.writing_id}</td>
                    <td>
                    <a href="listread?writing_id=${item.writing_id}">
                    ${item.writing_name}
                    </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <%-- 페이징 처리 부분 --%>
    <c:if test="${totalPages > 1}">
        <div>
            <span>현재 페이지: ${currentPage + 1} / 총 페이지: ${totalPages}</span>
            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                <a href="/java?page=${i}&searchKeyword=${searchKeyword}">${i + 1}</a>
            </c:forEach>
        </div>
    </c:if>
</body>
</html>
            
            <span><input type="button" value="글 작성" onClick="location.href='write'" style="font-size:10px; padding : 5px 5px 5px 5px;float:right;"></span>&nbsp;&nbsp;
            </table>
    
    
    </div>
   
</body>
</html>