package com.sandl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sandl.daos.MntDao;
import com.sandl.dtos.CommentDto;
import com.sandl.dtos.LoginDto;
import com.sandl.dtos.ScheduleDto;
import com.sandl.dtos.WishDto;
import com.sandl.utils.Util;

import net.sf.json.JSONArray;


@WebServlet("/PostController.do")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//Schedule과 Comment를 담당하는 컨트롤러
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		MntDao dao = new MntDao();
		Util util = new Util();
		HttpSession session = request.getSession();
		
		if(command.equals("getschlist")) {
			if(util.getCookie("pYear", request)!=null) {
				response.sendRedirect("schedule.jsp?year=" +util.getCookie("pYear", request) +"&month=" +util.getCookie("pMonth", request));
			}else {
				response.sendRedirect("schedule.jsp");
			}
		}else if(command.equals("getschdetail")) {
			String seq = request.getParameter("seq");
			
			ScheduleDto dto = dao.getSchedule(seq);
			request.setAttribute("dto", dto);
			dispatch("schdetail.jsp", request, response);
			
		}else if(command.equals("writesch")) {
			String id = ((LoginDto)session.getAttribute("ldto")).getId();
			
			String today = util.getCookie("today", request).getValue();
			
			String sdate = util.formDate2(request.getParameter("sdate"));
			String edate = util.formDate2(request.getParameter("edate"));
			
			int mntn_code = Integer.parseInt(request.getParameter("searchresult"));
			String mcontent = request.getParameter("mcontent");
			String pubflag = request.getParameter("pubflag");
			String climbflag = "N";
			
			if(util.compareDate(sdate, today) < 0) {
				climbflag = "N";
			}
			
			if(util.compareDate(edate, today) > 0) {
				climbflag = "Y";
			}
			
			if(util.compareDate(sdate, today) == 0 || util.compareDate(edate, today) == 0) {//당일에 당일 일정을 등록하는 경우
				climbflag = "Y";
			}
			
			//로그인시 edate가 현재 날짜보다 이전에 위치하면서, climbflag가 N인 일정의 등반 여부를 물어보고 변경
			
			ScheduleDto dto = new ScheduleDto();
			
			dto.setId(id);
			dto.setSdate(sdate);
			dto.setEdate(edate);
			dto.setMntn_code(mntn_code);
			dto.setMcontent(mcontent);
			dto.setPubflag(pubflag);
			dto.setClimbflag(climbflag);
			
			boolean isS = dao.addSchedule(dto);
			
			if(isS) {
				response.sendRedirect("schedule.jsp");
			}else {
				
			}
			
		}else if(command.equals("modifysch")) {
			
		}else if(command.equals("deletesch")) {
			
		}else if (command.equals("getwishAjax")) {
			String id = request.getParameter("id");
			List<WishDto> list = null;
			
			list = dao.getMyWish(id);
			
			JSONArray jArr = util.listToJson(list);
			
			
			PrintWriter pw = response.getWriter();
			jArr.write(pw);
			System.out.println(jArr.toString());
		}else if(command.equals("addwishlist")) {
			String id = request.getParameter("id");
			String mntn_code = request.getParameter("mntn_code");
			
			dao.addMyWish(id, mntn_code);
		}else if(command.equals("delwishlist")) {
			String id = request.getParameter("id");
			String mntn_code = request.getParameter("mntn_code");
			
			dao.delMyWish(id, mntn_code);
		}else if(command.equals("addcomment")) {
			LoginDto ldto = (LoginDto)session.getAttribute("ldto");
			int mntn_code = Integer.parseInt(request.getParameter("mntn_code"));
			String mntn_name = request.getParameter("mntn_name");
			String id = ldto.getId();
			String mcomment = request.getParameter("mcomment");
			int mlike = Integer.parseInt(request.getParameter("mlike"));
			
			CommentDto dto = new CommentDto();
			dto.setMntn_code(mntn_code);
			dto.setId(id);
			dto.setMcomment(mcomment);
			dto.setMlike(mlike);
			
			
			String schflag = request.getParameter("schflag");
			
			if(schflag != null) { //산 상세보기에서 코멘트를 작성할 경우
				dto.setPubflag("Y"); //공개
				boolean isS = dao.addComment(dto);
				if(schflag.equals("Y")) { //스케쥴을 작성하러 가기=> 스케쥴은 오늘 날짜 이후로는 작성 못하게 해야 하므로 오늘의 날짜를 같이 넘김	
					response.sendRedirect("addsch.jsp?yyyyMMdd=" +util.getCookie("today", request).getValue() +"&schflag=Y");
				
				}else if(schflag.equals("N")) { //sch_seq가 null이 되면서 나의 등산기록 보기에서 일정을 작성할수 있다.
					
					if(isS) {//코멘트 작성에 성공했을 경우 산 상세보기로 돌아가기
						List<Integer> climblist = (List<Integer>)session.getAttribute("climblist");
						climblist.add(mntn_code);
						session.setAttribute("climblist", climblist);
						response.sendRedirect("FindController.do?command=findreview&mntn_name="+ mntn_name +"&mntn_code="+mntn_code);
					}else {//index로 돌아감
						response.sendRedirect("index.jsp");
					}
				}
			}else { //마이페이지에서 작성하는 경우(일정 seq 있음)
				dto.setPubflag(request.getParameter("pubflag"));
				dto.setSch_seq(Integer.parseInt(request.getParameter("sch_seq")));
				boolean isS = dao.addComment(dto);
				
				if(isS) {
					List<Integer> climblist = (List<Integer>)session.getAttribute("climblist");
					climblist.add(mntn_code);
					session.setAttribute("climblist", climblist);
				}
				
				response.sendRedirect("FindController.do?command=findreview&mntn_name="+ mntn_name +"&mntn_code="+mntn_code);
			}
			
		}else if(command.equals("getmymtcmtlist")) {
			
		}else if(command.equals("getmycmtdetail")) {
			
		}else if(command.equals("modifycomment")) {
			
		}else if(command.equals("delcomment")) {
			
		}else if(command.equals("mydiary")) {
			//위시리스트, 오른 산 목록(코멘트), 코멘트를 작성하지 않은 일정 목록 보내기
			
			LoginDto ldto = (LoginDto)session.getAttribute("ldto");
			String id = ldto.getId();
			
			List<WishDto> wlist = dao.getMyWish(id);
			List<CommentDto> clist = dao.getClistDetail(id);
			List<ScheduleDto> slist = dao.getSchNoCmt(id, util.getCookie("today", request).getValue());
			
			request.setAttribute("wlist", wlist);
			request.setAttribute("clist", clist);
			request.setAttribute("slist", slist);
			
			dispatch("mydiary.jsp", request, response);
		}else if (command.equals("ajaxCalendar")) {
			
			LoginDto ldto = (LoginDto)session.getAttribute("ldto");
			String id = ldto.getId();
			
			int pyear = Integer.parseInt(request.getParameter("selyear"));
			
			String smonth = request.getParameter("selmonth");
			int pmonth = Integer.parseInt(smonth);
			
			List<ScheduleDto> list = dao.getScheduleList(""+pyear+Util.isTwo(smonth), id);
			
			Calendar cal = Calendar.getInstance();
			cal.set(pyear, pmonth);
			
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			String result = "";
			
			for(int i = 0; i < dayOfWeek-1; i++){
				result += "<td>&nbsp;</td>";
			}
			
			for(int i = 1; i <= lastDay; i++){
				
				Map<String, String> map = Util.getCalView(list, pyear, pmonth, i);
				String titleList = map.get("titleList");
				
				result += "<td"+
						  (titleList.equals("")?"poss":"imposs")
						  +">"+i+"</td>";
				if((i+(dayOfWeek-1))%7 == 0){
					result += "<tr></tr>";
				}
			}
			
			int nbsp = (7 -(dayOfWeek-1 +lastDay)%7)%7;
			for(int i = 1; i <= nbsp; i++) {
				result += "<td>&nbsp;</td>";
			}
			
			result = "<table class=\"datesT\"><tr>"+result+"</tr></table>";
			
			PrintWriter pw = response.getWriter();
			pw.write(result);
		}
	}
	
//	Cookie cookie = getCookie("refererQuery", request);
//	
//	if(cookie != null) {
//		String refererQuery = cookie.getValue();
//		refererQuery = refererQuery.substring(refererQuery.indexOf("&")+1);
//		System.out.println(refererQuery);
//		response.sendRedirect("calendar.jsp?"+refererQuery);
//	}else {
//		response.sendRedirect("calendar.jsp");				
//	}
	
	public void dispatch (String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
}
