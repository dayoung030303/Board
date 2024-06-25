<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>DELETESLECTE PAGE</title>
</head>
	<body>
	<%
			String[] wirintid = request.getParameterValues("checked");
		
		 if(wirintid != null)  {
	            System.out.print("과목 : ");
	            for(int i = 0; i < wirintid.length; i++)  {
	            	System.out.print(wirintid[i] + " ");
	            }
         }
	%>
		<script>
		alert("삭제가 완료되었습니다.");
		location.href="java";
		</script>
	</body>
</html>