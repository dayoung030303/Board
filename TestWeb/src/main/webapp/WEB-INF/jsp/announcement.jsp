<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>announcement list</title>
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
        <div class="search_area">
            <input type="text" name="keyword" value="${keyword }">
            <button>Search</button>
            </div>
    </div>
        <colgroup>
           <col style="width:5%;"/>
           <col style="width:auto;"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty boardList}">
                    <tr><td colspan="5" align="center">데이터가 없습니다.
                    </td></tr>
                    </c:when>
                <c:when test="${!empty boardList}">
                    <c:forEach var="list" items="${boardList}">
                     <tr>
                         <td><c:out value="${list.bid}"/></td>
                         <td><c:out value="${list.title}"/></td>
                     </tr>
                 </c:forEach>
                 </c:when>
               </c:choose>
               </tbody>
               </table>
                            
            </tbody>
            
            <input type="button" value="글 작성" onClick="location.href='write'" style="font-size:10px; padding : 5px 5px 5px 5px;float:right;"/>&nbsp;&nbsp;
            </table>
    
    
    </div>
   
</body>
</html>