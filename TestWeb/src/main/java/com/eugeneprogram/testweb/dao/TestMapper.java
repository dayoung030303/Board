package com.eugeneprogram.testweb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface TestMapper {
	public List<Map<String, Object>> getList() throws Exception;
	public List<Map<String, Object>> searchList(@Param("searchKeyword") String searchKeyword) throws Exception;
	public int insertWrite(Map<String, Object> write) throws Exception;
	public Map<String, Object> readWrite(int writing_id) throws Exception;
	public void insertFile(Map<String, Object> fileInfo) throws Exception;
	public List<Map<String, Object>> readFile(int writing_id) throws Exception;
	public Map<String, Object> readFileinformation(int file_id) throws Exception;

}
