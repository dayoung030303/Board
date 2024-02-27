package com.eugeneprogram.testweb.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eugeneprogram.testweb.dao.TestMapper;

@Service
public class TestService {
	@Autowired
	TestMapper testMapper;
	
	public List<Map<String, Object>> getList() throws Exception {
		return testMapper.getList();
    }

	public List<Map<String, Object>> searchList(String searchKeyword) throws Exception {
	        return testMapper.searchList(searchKeyword);
	}
	
	public int insertWrite(Map<String, Object> write) throws Exception {
		return testMapper.insertWrite(write);
	}

	public Map<String, Object> readWrite(int writing_id) throws Exception {
		// TODO Auto-generated method stub
		return testMapper.readWrite(writing_id);
	}

	public void insertFile(Map<String, Object> fileInfo) throws Exception {
		// TODO Auto-generated method stub
		testMapper.insertFile(fileInfo);
	}

	public List<Map<String, Object>> readFile(int writing_id) throws Exception{
		// TODO Auto-generated method stub
		return testMapper.readFile(writing_id);
	}

	public Map<String, Object> readFileinformation(int file_id) throws Exception {
		// TODO Auto-generated method stub
		return testMapper.readFileinformation(file_id);
	}

	public void deleteWrite(int writing_id) throws Exception{
		// TODO Auto-generated method stub
		testMapper.deleteWrite(writing_id);
	}

	public void deleteSelect(String writing_id) throws Exception{
		// TODO Auto-generated method stub
		testMapper.deleteSelect(writing_id);
	}
	
	

	
}