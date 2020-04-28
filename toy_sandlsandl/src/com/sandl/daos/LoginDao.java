package com.sandl.daos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.sandl.config.SqlMapConfig;
import com.sandl.dtos.CommentDto;
import com.sandl.dtos.LoginDto;
import com.sandl.dtos.ScheduleDto;

public class LoginDao extends SqlMapConfig {
	
	String nameSpace = "com.sandl.Sandle.";
	
	public boolean insertUser (LoginDto ldto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace +"insertUser", ldto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		
		return count > 0 ? true:false;
	}
	
	public boolean idCheck(String id) {
		boolean isS = false;
		
		LoginDto ldto = null;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			ldto = sqlSession.selectOne(nameSpace +"idCheck", id);
			if(ldto != null) {
				isS = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return isS;
	}
	
	public LoginDto login(String id, String password) {
		LoginDto ldto = null;
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			ldto = sqlSession.selectOne(nameSpace +"login", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		
		return ldto;
	}
	
	public List<Integer> getMyList(String id){ //코멘트의 산코드를 리스트 형태로 가져옴
		List<Integer> list = new ArrayList<>();
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			
			list = sqlSession.selectList(nameSpace +"climblist", id);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public LoginDto getUserInfo(String id) {
		LoginDto dto = new LoginDto();
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getUserInfo",id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	public boolean inactiveUser(String id) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace +"inactiveUser", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return count > 0 ? true : false;
	}
	
	public boolean updateUserInfo(LoginDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace +"updateUserInfo", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0? true:false;
	}
	
}
