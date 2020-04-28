package com.sandl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sandl.daos.LoginDao;
import com.sandl.dtos.CommentDto;
import com.sandl.dtos.LoginDto;
import com.sandl.dtos.ScheduleDto;
import com.sandl.utils.Util;



@WebServlet("/LoginController.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		LoginDao dao = new LoginDao();
		HttpSession session = request.getSession();
		Util util = new Util();
		
		if(command.equals("insertuser")) {
			boolean isS = false;
			
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String address = request.getParameter("address1") +":"
							+request.getParameter("address2") +":"
							+request.getParameter("address3");
			
			isS = dao.insertUser(new LoginDto(id, password, name, email, address, null, null));
			
			if(isS) {
				request.setAttribute("msg", "회원가입에 성공했습니다.");
				response.sendRedirect("index.jsp");
			}else {
				request.setAttribute("msg", "회원가입에 실패했습니다.");
				dispatch("regist.jsp", request, response);
			}
			
		}else if (command.equals("idchk")) {
			response.setContentType("text/json;charset=utf-8");

			String id = request.getParameter("id");
			System.out.println(id);
			boolean resultId = dao.idCheck(id); //true면 중복아이디가 존재
			PrintWriter pw = response.getWriter();
			pw.print(resultId);
			
		}else if (command.equals("login")) {
			System.out.println("checked!");
			String id = request.getParameter("lid");
			String password = request.getParameter("lpassword");
			
			LoginDto ldto = dao.login(id, password);
			
			if(ldto != null) {
				
				session.setAttribute("ldto", ldto);

				List<Integer> clist = dao.getMyList(id);
				session.setAttribute("climblist", clist);
				System.out.println(clist);
				
				session.setMaxInactiveInterval(60*60);
				response.sendRedirect(request.getHeader("referer"));
				
			}else {
				request.setAttribute("msg", "로그인에 실패했습니다.");
				dispatch("index.jsp", request, response);
			}
			
		}else if (command.equals("logout")) {
			if(session.getAttribute("ldto") != null) {
				session.invalidate();
			}
			response.sendRedirect("index.jsp");
		}else if(command.equals("deluser")) {
			LoginDto ldto = (LoginDto)session.getAttribute("ldto");
			
			boolean isS = dao.inactiveUser(ldto.getId());
			
			if(isS) {
				session.invalidate();
				response.sendRedirect("index.jsp");
			}else {
				request.setAttribute("msg", "회원 탈퇴에 실패했습니다.");
				dispatch("LoginController.do?command=myinfo", request, response);
			}
		}else if (command.equals("modifyinfo")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String address = request.getParameter("address1")+":"+
							 request.getParameter("address2")+":"+
							 request.getParameter("address3");
			String password = "none";
			if(!request.getParameter("password").equals("")) {
				password = request.getParameter("password");
			}
			LoginDto dto = new LoginDto();
			
			dto.setId(id);
			dto.setName(name);
			dto.setPassword(password);
			dto.setEmail(email);
			dto.setAddress(address);
		}
		
		else if (command.equals("userupdate")) {
			
		}
	}
	

	public void dispatch (String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
}
