<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rewriting page</title>

<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckeditor/ko.js"></script>

<!-- 넓이 높이 조절 -->
	<style>
	.ck.ck-editor {
    	max-width: 500px;
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	</style>
</head>
<body>

<div class="panel-heading">게시글 수정하기</div>
	<div class="panel-body">
		<form method="post" action="/rewritesave" enctype="multipart/form-data">
		<input type="hidden" name="writing_id" value="${writing_id}">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />		
			<div class="form-group">
				<label>제목</label> 
                <input type="text" value="${writing_name}" class="form-control" name="name"><br>
               
                <label>첨부파일</label>
                <input type="file" value="${writing_file}" name="file" multiple>
			</div>
			
			<div class="input-group">
				<label>내용</label>
				
					<div id="editor"></div>
					<textarea name="content" id="content">${writing_content}</textarea> <!-- 추가된 부분 -->
        
    		</div>
    <script>
       
        ClassicEditor
            .create( document.querySelector( '#content' ), {
            	
            	ckfinder: {
            		uploadUrl : '/rewrite/upload'
            	}
            })
             .then(newEditor => {
                editor = newEditor;
            })
            .catch( error => {
                console.error( error );
            } );
        
        // form이 submit될 때 실행되는 코드를 추가합니다.
        document.querySelector('form').addEventListener('submit', () => {
            // CKEditor의 내용을 textarea 요소에 저장합니다.
            document.querySelector('#content').value = editor.getData();
        });
    </script>

					
				
		
			<input type="submit" value="수정완료" style="margin-top: 50px;">
			<input type="button" value="뒤로가기" 
								onClick="listread('${writing_id}')" style="margin-top: 50px;">
		</form>
</div>
<script>
 	function listread(writing_id) {
 			location.href="/listread?writing_id=" + writing_id;
 	}
 	
 </script>  
</body>
</html>