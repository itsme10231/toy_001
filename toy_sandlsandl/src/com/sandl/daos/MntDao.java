package com.sandl.daos;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.sandl.config.SqlMapConfig;
import com.sandl.dtos.CommentDto;
import com.sandl.dtos.MntDto;
import com.sandl.dtos.ScheduleDto;
import com.sandl.dtos.SearchDto;
import com.sandl.dtos.WishDto;

public class MntDao extends SqlMapConfig {
	
	String nameSpace = "com.sandl.Sandle.";
	

	
	
	public List<MntDto> getMnt(String mName, String mLoc, String pnum, String view) {
		List<MntDto> list = new ArrayList<>();
		SearchDto dto = new SearchDto();
		
		dto.setMname(mName);
		dto.setMloc(mLoc);
		dto.setPnum(pnum);
		dto.setView(view);
		System.out.println(mName +" + "+ mLoc);
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"searchMnt", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<MntDto> getMntLogged(String mName, String mLoc, String pnum, String view, List<Integer> climblist) {
		List<MntDto> list = new ArrayList<>();
		SearchDto dto = new SearchDto();
		
		dto.setMname(mName);
		dto.setMloc(mLoc);
		dto.setPnum(pnum);
		dto.setView(view);
		dto.setClimblist(climblist);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"searchMnt", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<CommentDto> getCmtMntDetail(String mCode) {
		List<CommentDto> list = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"getCmtMD", mCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<ScheduleDto> getScheduleList(String yyyyMM, String id) {
		List<ScheduleDto> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("yyyyMM", yyyyMM);
		map.put("id", id);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"getSchList", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<ScheduleDto> getSchNoCmt(String id, String today){
		List<ScheduleDto> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("today", today);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"getSchNoCmt", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	
	public ScheduleDto getSchedule(String seq) {
		ScheduleDto dto = null;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace +"getSch", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	
	public boolean addSchedule(ScheduleDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace +"insertSch", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0 ? true: false;
	}
	
	public boolean modifySchedule(ScheduleDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace +"updateSch", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0 ? true: false;
	}
	
	public boolean deleteSchedule(ScheduleDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.delete(nameSpace +"deleteSch", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0 ? true: false;
	}
	
	public boolean addComment(CommentDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace +"insertCmt", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		
		return count > 0 ? true: false;
	}
	
	
	public List<WishDto> getMyWish(String id){
		List<WishDto> list = new ArrayList<>();
		SqlSession sqlSession = null;
		
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"getMyWish", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		
		return list;
	}
	
	public WishDto getMntWish(String id, String mntn_code) {
		WishDto dto = null;
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("mntn_code", mntn_code);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace +"getMntWish", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		
		return dto;
	}
	
	public boolean addMyWish(String id, String mntn_code) {
		int count = 0;
		SqlSession sqlSession = null;
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("mntn_code", mntn_code);
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace +"addMyWish", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0 ? true: false;
	}
	
	public boolean delMyWish(String id, String mntn_code) {
		int count = 0;
		SqlSession sqlSession = null;
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("mntn_code", mntn_code);
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.delete(nameSpace +"delMyWish", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count > 0 ? true: false;
	}
	
	public List<CommentDto> getClistDetail(String id){
		List<CommentDto> list = null;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace +"cListDetail", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public boolean updateMntn(List<MntDto> list) {
		SqlSession sqlSession = null;
		int[] count = new int[list.size()];
		boolean isS = true;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(false);
			for(int i = 0; i < list.size(); i++) {
				count[i] = sqlSession.insert("mdto", list.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.commit();
			sqlSession.close();
		}
		
		for(int i = 0; i < count.length; i++) {
			if(count[i] <= 0) {
				isS = false;
			}
		}
		return isS;
	}
}
