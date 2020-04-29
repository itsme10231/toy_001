package com.sandl.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sandl.dtos.CommentDto;
import com.sandl.dtos.MntDto;
import com.sandl.dtos.ScheduleDto;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Util {
	
	
	
	public Cookie getCookie(String cookieName, HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;
		
		for (int i = 0; i < cookies.length; i++) {
			if(cookies[i].getName().equals(cookieName)) {
				cookie = cookies[i];
			}
		}
		return cookie;
	}
	
	public void setCookie(String cookieName, String value, HttpServletResponse response) {
		Cookie cookie = new Cookie(cookieName, value);
		cookie.setMaxAge(60*60);
		response.addCookie(cookie);
	}
	
	public String setParamCookie(String cookieName, String init, HttpServletRequest request, HttpServletResponse response) {
		String s = request.getParameter(cookieName);

		if(s==null){
			if(getCookie(cookieName, request) == null) {
				s = init;
			}else {
				s = getCookie(cookieName, request).getValue();
			}
		} else {
			setCookie(cookieName, s, response);
		}
		
		return s;
	}
	
	public static String isTwo(String s) {
		return s.length() < 2 ? "0"+s : s;
	}
	
	//달력의 날짜에 대한 요일을 확인하여 폰트색을 적용하는 메서드
		public static String fontColor(int dayOfWeek, int i) {
			String color = "";
			if((i+(dayOfWeek-1))%7 == 0){ //토요일
				color = "cornflowerblue";
			}else if ((i+(dayOfWeek-1))%7 == 1) { //일요일
				color = "lightcoral";
			}else { //평일
				color = "#555555";
			}
			return color;
		}
		
		//다중 스케쥴의 처리 고민해볼것
	public static Map getCalView(List<ScheduleDto> list,int year, int month, int i) {
		//list에 저장된 mdate는 8자리
		Map<String, String> map = new HashMap<>();
		
		String m = isTwo(String.valueOf(month));
		String d = isTwo(String.valueOf(i));
		
		String yyyyMMdd = year +m +d;
		//달력에서 일정을 출력해줄 문자열(<p>title</p>)
		String titleList = "";
		for (ScheduleDto dto : list) {
			int mCode = dto.getMntn_code();
			if(dto.getSdate().equals(yyyyMMdd)) {
				
				titleList += "<p class='sdate'><input type='hidden' name='" +mCode +"' value='" +mCode +"'>" 
						  + dto.getMntdto().getMntn_name()
						  +"</p>";
				map.put("seq", dto.getSeq()+"");
			
			}else if(dto.getEdate().equals(yyyyMMdd)) {
				
				titleList += "<p class='edate'><input type='hidden' name='" +mCode +"' value='" +mCode +"'>" 
						  + dto.getMntdto().getMntn_name()
						  +"</p>";
				map.put("seq", dto.getSeq()+"");
				
			}else if(Integer.parseInt(dto.getSdate()) < Integer.parseInt(yyyyMMdd)
					&&Integer.parseInt(yyyyMMdd) < Integer.parseInt(dto.getEdate())
					) {
				titleList+= "<p class='mdate'><input type='hidden' name='" +mCode +"' value='" +mCode +"'>"
						 + "&nbsp;&nbsp;&nbsp;&nbsp;"
						 +"</p>";
			}
		}
		
		map.put("titleList", titleList);
		return map;
	}
	
	public JSONArray listToJson(List<?> list) {
		JSONArray jArr = new JSONArray();
		
		for(int i = 0; i < list.size(); i++) {
			jArr.add(JSONObject.fromObject(list.get(i)));
		}
				
		return jArr;
	}
	
	public int compareDate(String date1, String date2) {
		
		
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyyMMdd");
		
		Date day1 = null;
		Date day2 = null;

		try {
			day1 = dateform.parse(date1);
			day2 = dateform.parse(date2);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		int compare = day1.compareTo(day2);
		
		//compare가 0보다 크면 date1이 더 먼저의 날짜
		return compare;
	}

	public String formDate(String thisdate) {
		System.out.println("변환되기전값"+thisdate);
		return thisdate.substring(0,4) +"-"+ thisdate.substring(4,6) +"-"+ thisdate.substring(6,8);
	}

	public String formDate2(String thisdate) {
		return thisdate.substring(0,4) +thisdate.substring(5,7) +thisdate.substring(8);
	}
	
	
}
