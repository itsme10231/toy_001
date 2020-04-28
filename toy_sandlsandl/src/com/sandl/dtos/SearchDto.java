package com.sandl.dtos;

import java.util.List;

public class SearchDto {
	
	private String mname;
	private String mloc;
	private String pnum;
	private String view;
	
	private List<Integer> climblist;
	
	public SearchDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SearchDto(String mname, String mloc, String pnum, String view,
			List<Integer> climblist) {
		super();
		this.mname = mname;
		this.mloc = mloc;
		this.pnum = pnum;
		this.view = view;
		this.climblist = climblist;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMloc() {
		return mloc;
	}
	public void setMloc(String mloc) {
		this.mloc = mloc;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getView() {
		return view;
	}
	public void setView(String view) {
		this.view = view;
	}

	public List<Integer> getClimblist() {
		return climblist;
	}
	public void setClimblist(List<Integer> climblist) {
		this.climblist = climblist;
	}
	
	
}
