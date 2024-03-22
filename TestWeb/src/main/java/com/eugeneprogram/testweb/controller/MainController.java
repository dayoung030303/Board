package com.eugeneprogram.testweb.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.eugeneprogram.testweb.service.TestService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MainController {
	@Autowired
	TestService testService;
	
	
	@RequestMapping(value = "/main") //주소록 매핑을 해주므로써 보안성을 강화해줌
	public String goMain() {
		return "main"; //jsp파일의 이름이 됨 jsp파일이 root가 됨
	}
	
	
	@RequestMapping(value = "/java")
	public ModelAndView java(
	    @RequestParam(defaultValue = "0") int page,
	    @RequestParam(required = false) String searchKeyword
	) throws Exception {
	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("java");

	    // 한 페이지에 표시할 항목 수
	    int pageSize = 10;

	    // 검색어에 맞는 리스트의 특정 값만 가져오기
	    List<Map<String, Object>> list;

	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        list = testService.searchList(searchKeyword);
	    } else {
	        // 검색어가 없으면 전체 리스트 가져오기
	        list = testService.getList();
	    }

	    // 페이징 처리를 위한 부분
	    // 전체 데이터의 크기
	    int totalItems = list.size();

	    // 전체 페이지 수
	    int totalPages = (int) Math.ceil((double) totalItems / pageSize);

	    // 현재 페이지에 해당하는 일부 데이터만 선택
	    int startIdx = page * pageSize;
	    int endIdx = Math.min((page + 1) * pageSize, totalItems);

	    List<Map<String, Object>> paginatedData = list.subList(startIdx, endIdx);

	    // 현재 페이지 정보 및 데이터 전달
	    mv.addObject("currentPage", page);
	    mv.addObject("totalPages", totalPages);
	    mv.addObject("list", paginatedData);
	    mv.addObject("searchKeyword", searchKeyword);

	    return mv;
	}
	
	@RequestMapping(value = "/writesave", method = RequestMethod.POST)
	public String uploadFileAndWrite(@RequestParam("writing_id") int writing_id, @RequestParam String name, @RequestParam Object content, @RequestParam("file") MultipartFile[] files, Model model) throws Exception {
	    
		String filePath = "C:\\Users\\user\\Documents\\workspace-spring-tool-suite-4-4.19.0.RELEASE\\TestWeb\\src\\main\\webapp\\file";
	    File directory = new File(filePath);

	    // 해당 디렉토리가 없으면 생성함
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }

	    // 글 작성 부분
	    System.out.println("name: " + name);
	    System.out.println("content: " + new String(((String) content).getBytes("euc-kr"), "UTF-8"));
	    
		if(writing_id == 0)
		{
		
	    Map<String, Object> write = new HashMap<>();

	    write.put("name", name);
	    write.put("content", content);
	    int writingId = testService.insertWrite(write); // 게시글 정보를 데이터베이스에 저장하고 ID를 가져옴
	    System.out.println("write : " + write.get("writeId"));
	    writingId = (Integer) write.get("writeId");
	    List<Map<String, Object>> fileList = new ArrayList<>();

	    for (MultipartFile file : files) {
	        //파일의 원래 이름을 가져옴
	        String originalFileName = file.getOriginalFilename();
	        File dest = new File(directory, originalFileName);

	        try {
	            //해당 경로에 파일을 저장함
	            file.transferTo(dest);
	            
	            Map<String, Object> fileInfo = new HashMap<>();
	            System.out.println("originalFileName : " + originalFileName);
	            fileInfo.put("fileOriginalname", originalFileName);
	            fileInfo.put("filePath", filePath + "/" + originalFileName);
	            fileInfo.put("fileSize", file.getSize());
	            fileInfo.put("writingId", writingId);

	            fileList.add(fileInfo); // 파일 정보를 리스트에 추가함
	            testService.insertFile(fileInfo); // 파일 정보를 데이터베이스에 저장함
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }
	    }

	    model.addAttribute("files", fileList); // 파일 정보 리스트를 모델에 추가함
		}
		
		else
		{
		    Map<String, Object> rewrite = new HashMap<>();

		    rewrite.put("writing_id", writing_id);
		    rewrite.put("writingName", name);
		    rewrite.put("writingContent", content);
		    testService.reInsertWrite(rewrite); // 게시글 정보를 데이터베이스에 수정하고 ID를 가져옴
		    //System.out.println("write : " + rewrite.get("writeId"));
		    //writing_id = (Integer) rewrite.get("writing_id");
		    List<Map<String, Object>> fileList = new ArrayList<>();

		    for (MultipartFile file : files) {
		        //파일의 원래 이름을 가져옴
		        String originalFileName = file.getOriginalFilename();
		        File dest = new File(directory, originalFileName);

		        try {
		            //해당 경로에 파일을 저장함
		            file.transferTo(dest);
		            
		            Map<String, Object> fileInfo = new HashMap<>();
		            System.out.println("originalFileName : " + originalFileName);
		            fileInfo.put("fileOriginalname", originalFileName);
		            fileInfo.put("filePath", filePath + "/" + originalFileName);
		            fileInfo.put("fileSize", file.getSize());
		           // fileInfo.put("writingId", writing_id);

		            fileList.add(fileInfo); // 파일 정보를 리스트에 추가함
		            testService.reInsertFile(fileInfo); // 파일 정보를 데이터베이스에 저장함
		        } catch (IllegalStateException | IOException e) {
		            e.printStackTrace();
		        }
		    }

		    model.addAttribute("files", fileList); // 파일 정보 리스트를 모델에 추가함
		}
	    return "redirect:java";
	}
	
	@RequestMapping(value = "/rewritesave", method = RequestMethod.POST)
	public String uploadFileAndRewrite(@RequestParam("writing_id") int writing_id, @RequestParam String name, @RequestParam Object content, @RequestParam("file") MultipartFile[] files, Model model) throws Exception {
	    String filePath = "C:\\Users\\user\\Documents\\workspace-spring-tool-suite-4-4.19.0.RELEASE\\TestWeb\\src\\main\\webapp\\file";
	    File directory = new File(filePath);
	    //System.out.println(writing_id);
	    // 해당 디렉토리가 없으면 생성함
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }

	    // 글 작성 부분
	    System.out.println("name: " + name);
	    System.out.println("content: " + new String(((String) content).getBytes("euc-kr"), "UTF-8"));
	    Map<String, Object> rewrite = new HashMap<>();

	    rewrite.put("writing_id", writing_id);
	    rewrite.put("writingName", name);
	    rewrite.put("writingContent", content);
	    testService.reInsertWrite(rewrite); // 게시글 정보를 데이터베이스에 수정하고 ID를 가져옴
	    //System.out.println("write : " + rewrite.get("writeId"));
	    //writing_id = (Integer) rewrite.get("writing_id");
	    List<Map<String, Object>> fileList = new ArrayList<>();

	    for (MultipartFile file : files) {
	        //파일의 원래 이름을 가져옴
	        String originalFileName = file.getOriginalFilename();
	        File dest = new File(directory, originalFileName);

	        try {
	            //해당 경로에 파일을 저장함
	            file.transferTo(dest);
	            
	            Map<String, Object> fileInfo = new HashMap<>();
	            System.out.println("originalFileName : " + originalFileName);
	            fileInfo.put("fileOriginalname", originalFileName);
	            fileInfo.put("filePath", filePath + "/" + originalFileName);
	            fileInfo.put("fileSize", file.getSize());
	           // fileInfo.put("writingId", writing_id);

	            fileList.add(fileInfo); // 파일 정보를 리스트에 추가함
	            testService.reInsertFile(fileInfo); // 파일 정보를 데이터베이스에 저장함
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }
	    }

	    model.addAttribute("files", fileList); // 파일 정보 리스트를 모델에 추가함
	    return "redirect:java"; //rewrite 뒤로가기 부분 참고하면서 수정완료 부분 상세페이지로 가게 처리하기 금요일날
	}
	 //글쓰기 화면
	 @RequestMapping(value = "/write")
	    public String write()	{
	    	return "write";
	    }
	 //글수정 화면
	 @RequestMapping(value = "/rewrite")
	    public ModelAndView rewrite(@RequestParam("writing_id") int writing_id) throws Exception {
	        // TestService를 통해 writingId에 해당하는 글의 세부 내용을 가져옵니다.
		 	ModelAndView mv = new ModelAndView();
		 	mv.setViewName("rewrite");
		 	
	        Map<String, Object> writingDetails = testService.readWrite(writing_id);
	        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	        list = testService.readFile(writing_id);
	        //System.out.println(list.size() + " " + list.get(0)); //파일의 사이즈를 찍어서 파일의 개수를 확인함
	        
	        // 가져온 세부 내용을 모델에 추가합니다.
	        mv.addObject("writing_id", writingDetails.get("writing_id"));
	        mv.addObject("writing_name", writingDetails.get("writing_name"));
	        mv.addObject("writing_content", writingDetails.get("writing_content"));
	        mv.addObject("writing_file", list);

	        return mv;
	    }
	 
		
	 
	 //내용부분의 이미지 파일 업로드
	 @PostMapping(value = "/write/upload")
		public ModelAndView image(MultipartHttpServletRequest request) throws Exception {
	    
			// ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
			// modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
			// jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단 
			// WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로 등록해야 함 
			ModelAndView mav = new ModelAndView("jsonView");

			// ckeditor 에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서 uploadFile에 저장함
			MultipartFile uploadFile = request.getFile("upload");

			// 파일의 오리지널 네임
			String originalFileName = uploadFile.getOriginalFilename();
			
	        // 파일의 확장자
			String ext = originalFileName.substring(originalFileName.indexOf("."));
			
	        // 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
			String newFileName = UUID.randomUUID() + ext;

			// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
			String realPath = request.getServletContext().getRealPath("/");
			//dir create
			//upload/userid/파일업로드년도/날짜 만약 upload아래에 userid아래에 userid폴더가 있는지
			//여부를 확인하고 없으면 폴더를 만들고 날짜를 확인하기
			
			//userID는 임의로 dy로 설정해놓음 로그인을 아직 하지 않았기 때문
			
			//현재 날짜를 가져오는 코드 추가
			LocalDate currentDate = LocalDate.now();
			String year = String.valueOf(currentDate.getYear());
			String month = String.valueOf(currentDate.getMonthValue());
			String day = String.valueOf(currentDate.getDayOfMonth());
			
			// 현재경로/upload/파일명이 저장 경로
			String savePath = realPath + "upload/dy/" + year + "/" + month + "/" + day;
			
		    File directory = new File(savePath);
		    if(!directory.exists()) {
		        directory.mkdirs();
		    }

			// 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 상대경로를 쓰거나 이미지 불러오는 jsp 또는 클래스 파일을 만들어 가져오는 식으로 우회해야 함
			// 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
		    String uploadPath = "./upload/dy/" + year + "/" + month + "/" + day + "/" + newFileName;

			// 저장 경로로 파일 객체 생성
		    File file = new File(savePath + "/" + newFileName);
		    
			// 파일 업로드
			uploadFile.transferTo(file);

			// uploaded, url 값을 modelandview를 통해 보냄
			mav.addObject("uploaded", 1); // 업로드 완료
			mav.addObject("url", uploadPath); // 업로드 파일의 경로

			return mav;
		}
	 /*
	 @RequestMapping(value = "/listread")
	    public String read(@RequestParam("writing_id") int writing_id, Model model) throws Exception {
	        // TestService를 통해 writingId에 해당하는 글의 세부 내용을 가져옵니다.
	        Map<String, Object> writingDetails = testService.readWrite(writing_id);

	        // 가져온 세부 내용을 모델에 추가합니다.
	        model.addAttribute("writing_name", writingDetails.get("writing_name"));
	        model.addAttribute("writing_content", writingDetails.get("writing_content"));
	        model.addAttribute("writing_file", writingDetails.get("writing_file"));

	        return "listread";
	    }*/
	 @RequestMapping(value = "/listread")
	    public ModelAndView read(@RequestParam("writing_id") int writing_id) throws Exception {
	        // TestService를 통해 writingId에 해당하는 글의 세부 내용을 가져옵니다.
		 	ModelAndView mv = new ModelAndView();
		 	mv.setViewName("listread");
		 	
	        Map<String, Object> writingDetails = testService.readWrite(writing_id);
	        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	        list = testService.readFile(writing_id);
	        System.out.println(list.size()); //파일의 사이즈를 찍어서 파일의 개수를 확인함
	        
	        // 가져온 세부 내용을 모델에 추가합니다.
	        mv.addObject("writing_id", writingDetails.get("writing_id"));
	        mv.addObject("writing_name", writingDetails.get("writing_name"));
	        mv.addObject("writing_content", writingDetails.get("writing_content"));
	        mv.addObject("writing_file", list);

	        return mv;
	    }
	 
	 
	 @RequestMapping(value = "/selectDelete")
		public String goSelectDelete(HttpServletRequest request) throws Exception {
		 
		 	String[] selectId = request.getParameterValues("checked");
		 	
		 	for(int i = 0; i<selectId.length; i++) {
		 		testService.deleteSelect(selectId[i]);
		 	}
		 	
			return "selectDelete";
		}
	 
	 @RequestMapping(value = "/delete")
	  public String delete(@RequestParam("writing_id") int writing_id) throws Exception {
		 //System.out.println(writing_id + 10000);
		 testService.deleteWrite(writing_id);
		 
		 return "redirect:java";

	  }
	 
	   //파일을 눌렀을 때 처리하는 부분(/filedownload에서 처리)
	   @RequestMapping(value = "/filedownload")
	   //파일을 다운로드하는 것이므로 반환형이 없는 void를 이용(file_id에 맞는 파일을 검색하기 위해 file_id를 받아오고 
	   //request객체를 생성하여 정보를 저장, response객체를 생성하여 응답을 보냄
	   public void downloadFile(@RequestParam("file_id") int file_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		   System.out.println("file_id : " + file_id);
		   Map<String, Object> file = testService.readFileinformation(file_id); //file_id에 맞는 파일 정보들을 map을 이용해 file에 저장
		   
		   String saveFileName = (String)file.get("file_path"); //파일의 절대 경로를 저장
		   String originalFileName = (String)file.get("file_originalname"); //파일의 상대경로를 저장
		   
		   File downloadFile = new File(saveFileName); //절대 경로를 담은 객체를 생성
		   
		   byte[] fileByte = Files.readAllBytes(downloadFile.toPath()); //byte형식으로 파일들의 절대 경로의 객체를 모두 변환시켜줌, 파일의 경로를 가져와 파일에서 읽은 바이트를 포함하는 바이트 어레이를 반환함
		   
		   response.setContentType("application/octet-stream"); //응답한 정보에 내용 타입을 8비트 바이너리 배열로 다운로드 하도록 처리
		   response.setContentLength(fileByte.length); //응답한 정보에 내용의 길이를 지정
		   
		   response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") +"\";"); //다운로드 시 파일이름을 지정해줌
		   response.setHeader("Content-Transfer-Encoding", "binary"); //바이너리데이터이므로 바이너리로 인코딩함
		   
		   response.getOutputStream().write(fileByte); //버퍼에 파일을 담아 스트림으로 출력
		   response.getOutputStream().flush(); //버퍼에 저장된 내용을 클라이언트로 전송하고 버퍼를 비움
		   response.getOutputStream().close(); //출력스트림을 종료
	   }
	   
		 
	 @RequestMapping(value = "/login")
	    public String login()	{
	    	return "login";
	    }
	    
	    @RequestMapping(value = "/membership")
	    public String membership()	{
	    	return "membership";
	    }
	    
	    @RequestMapping(value = "/datastructure")
	    public String datastructure() {
	    	return "datastructure";
	    }
	    
	    @RequestMapping(value = "/c++")
	    public String c() {
	    	return "c++";
	    }
	    
	    @RequestMapping(value = "/c")
	    public String C() {
	    	return "c";
	    }
	    
	    @RequestMapping(value = "/announcement")
	    public String announcement() {
	    	return "announcement";
	    }
	   
	    
}