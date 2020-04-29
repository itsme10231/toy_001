package com.sandl.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sandl.daos.MntDao;
import com.sandl.dtos.CommentDto;
import com.sandl.dtos.LoginDto;
import com.sandl.dtos.MntDto;
import com.sandl.dtos.WishDto;
import com.sandl.paging.Paging;
import com.sandl.utils.Util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.xml.XMLSerializer;


@WebServlet("/FindController.do")
public class FindController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		MntDao mdao = new MntDao();
		Util util = new Util();
		HttpSession session = request.getSession();
		
		if(command.equals("indexAjax")) {
			String today = util.getCookie("today", request).getValue();
			
			
		} else if(command.equals("findmntn")) { //DB내의 산 테이블에서 검색
			List<MntDto> list = null;
			
			int scount = 0;
			int pcount = 0;
			Map<String, Integer> map = null;
			
			String mName = request.getParameter("mName");
			String mLoc = request.getParameter("mLoc");
			if(mLoc.equals("all")) {
				mLoc = "none";
			}
			
			if(mName == null || mName.equals("")) {
				mName = "none";
			}
			
			String pnum = util.setParamCookie("pnum", "1", request, response);
			String view = util.setParamCookie("view", "20", request, response);
			
			if(session.getAttribute("ldto")!=null && request.getParameter("isclimb") != null) { //로그인, flag 체크해서 분기 나누기
				List<Integer> climblist = (List<Integer>)session.getAttribute("climblist");
				System.out.println(climblist);
				list = mdao.getMntLogged(mName, mLoc, pnum, view, climblist);
			}else if(request.getParameter("is100") != null) {
				//100대명산 테이블화 시키기
			}else {
				//
				list = mdao.getMnt(mName, mLoc, pnum, view);
				//
			}
			
			
			//이 이하로 검색결과가 없을시의 처리
			if(list.size() != 0 && list != null) {
				scount = list.get(0).getScount();
				pcount = (int)Math.ceil(scount/(double)Integer.parseInt(view));
				map = Paging.pagingValue(pcount, pnum, 5);
			}else {
				
				String serviceN = "mntInfoOpenAPI";
				String paramN = "searchWrd";
				String paramV = request.getParameter("mName");
				
				StringBuffer result = findMntnApi(serviceN, paramN, paramV, request);
				
				if(!result.substring(result.indexOf("<totalCount>")+12, result.indexOf("</totalCount>")).equals("0")) {
					XMLSerializer xmlS = new XMLSerializer();
					List<MntDto> toDBList = new ArrayList<>();
					
					JSONObject jO = (JSONObject)xmlS.read(result.toString());
					JSONArray jArr = jO.getJSONObject("body").getJSONArray("items");
					
					for(int i = 0; i < jArr.size(); i++) {
						MntDto addDto = new MntDto();
						JSONObject thisO = (JSONObject)jArr.get(i);
						
						addDto.setMntn_name(thisO.getString("mntiname"));
						addDto.setMntn_loc(thisO.getString("mntiadd"));
						addDto.setMntn_code(Integer.parseInt(thisO.getString("mntilistno")));
						System.out.println(addDto);
						toDBList.add(addDto);
					}
					
					boolean isS = mdao.updateMntn(toDBList);
					
					if(isS) {
						System.out.println("산정보 DB 입력 성공!!!!!!!!!!");
					}else {
						System.out.println("산정보 DB 입력 실패");
					}
				}
				
				
				scount = 0;
				pcount = 1;
			}
			
			
			request.setAttribute("mName", mName);
			request.setAttribute("mLoc", mLoc);
			request.setAttribute("list", list);
			request.setAttribute("scount", scount);
			request.setAttribute("pcount", pcount);
			request.setAttribute("pnum", pnum);
			request.setAttribute("view", view);
			request.setAttribute("pmap", map);
			
			dispatch("searchresult.jsp", request, response);
			
			

		} else if(command.equals("findmntndetail")) { //api에서 검색1
			
			String serviceN = "mntInfoOpenAPI";
			String paramN = "searchWrd";
			String paramV = request.getParameter("mName");
			
			StringBuffer result = findMntnApi(serviceN, paramN, paramV, request);
			
			PrintWriter pw = response.getWriter();
			System.out.println("result:" +result);
			pw.write(result.toString());
			
		} else if(command.equals("findmntnimg")) { //api에서 검색2
			
			String serviceN = "mntInfoImgOpenAPI";
			String paramN = "mntiListNo";
			String paramV = request.getParameter("mCode");
			
			StringBuffer result = findMntnApi(serviceN, paramN, paramV, request);
			
			PrintWriter pw = response.getWriter();
			System.out.println("result:" +result);
			pw.write(result.toString());
			
		} else if(command.equals("findreview")) {
			
			String mCode = request.getParameter("mntn_code");
			String mName = request.getParameter("mntn_name");
			
			List<CommentDto> list = null;
			
			list = mdao.getCmtMntDetail(mCode);
			
			Object obj = session.getAttribute("ldto");
			WishDto wdto = null;
			if(obj != null) {
				LoginDto ldto = (LoginDto)obj;
				wdto = mdao.getMntWish(ldto.getId(),mCode);
				request.setAttribute("wdto", wdto);
			}
			
			request.setAttribute("list", list);
			
			dispatch("mntndetail.jsp?mntn_name=" +mName +"&mntn_code=" +mCode, request, response);
		
		} else if(command.equals("findmntnAjax")) {
			response.setContentType("text/json;charset=utf-8");
			List<MntDto> list = null;
			
			int scount = 0;
			
			
			String mName = request.getParameter("mName");
			String mLoc = request.getParameter("mLoc");
			if(mLoc.equals("all")) {
				mLoc = "none";
			}
			
			if(mName == null || mName.equals("")) {
				mName = "none";
			}
			
			String scview = util.setParamCookie("scview", "100", request, response);
			
			list = mdao.getMnt(mName, mLoc, "1", scview);
			
			if(list.size() != 0 && list != null) {
				scount = list.get(0).getScount();
			}else {
				scount = 0;
			}
						
			JSONArray jArr = util.listToJson(list);
			
			
			PrintWriter pw = response.getWriter();
			jArr.write(pw);
			System.out.println(jArr.toString());
			
		}
	}
	
	
	
	
	public StringBuffer findMntnApi(String serviceN, String paramN, String paramV, HttpServletRequest request) {

		String serviceKey = "GAEzoe6c7Vd7igSDi%2F5ShwU1wFgZed%2FZ2xiQy%2FrPn%2FiqPC8xjvXPXj6huvHoewAhF7byR8TVKceLjlq4xyGKBA%3D%3D";
		StringBuffer result = new StringBuffer(); 
		System.out.println(paramV);

		try {
			String urlS = "http://apis.data.go.kr/1400000/service/cultureInfoService/" +serviceN +"?serviceKey=" +serviceKey
					+"&" +paramN +"=" 
					+URLEncoder.encode(paramV, "utf-8")
					+"&numOfRows=100";
			System.out.println(urlS);
			URL url = new URL(urlS);
			InputStream is;
			is = url.openStream();
			InputStreamReader isr = new InputStreamReader(is);
			
			BufferedReader br = new BufferedReader(isr);
			
			String line;
			
			
			while((line = br.readLine()) != null) {
				result.append(line);
				result.append("\n");
			}
			

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	


}
