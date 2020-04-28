package com.sandl.dtos;

public class MntDto {
	
	private int seq;
	private String mntn_name;
	private String mntn_loc;
	private int mntn_code;
	private int scount;
	
	private String iswish;
	private String isclimb;
	
	public MntDto() {
		super();
	}

	public MntDto(int seq, String mntn_name, String mntn_loc, int mntn_code) {
		super();
		this.seq = seq;
		this.mntn_name = mntn_name;
		this.mntn_loc = mntn_loc;
		this.mntn_code = mntn_code;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getMntn_name() {
		return mntn_name;
	}

	public void setMntn_name(String mntn_name) {
		this.mntn_name = mntn_name;
	}

	public String getMntn_loc() {
		return mntn_loc;
	}

	public void setMntn_loc(String mntn_loc) {
		this.mntn_loc = mntn_loc;
	}

	public int getMntn_code() {
		return mntn_code;
	}

	public void setMntn_code(int mntn_code) {
		this.mntn_code = mntn_code;
	}
	
	

	public int getScount() {
		return scount;
	}

	public void setScount(int scount) {
		this.scount = scount;
	}

	public String getIswish() {
		return iswish;
	}

	public void setIswish(String iswish) {
		this.iswish = iswish;
	}

	public String getIsclimb() {
		return isclimb;
	}

	public void setIsclimb(String isclimb) {
		this.isclimb = isclimb;
	}

	@Override
	public String toString() {
		return "MntDto [seq=" + seq + ", mntn_name=" + mntn_name + ", mntn_loc=" + mntn_loc + ", mntn_code=" + mntn_code
				+ "]";
	}
	
	
}
