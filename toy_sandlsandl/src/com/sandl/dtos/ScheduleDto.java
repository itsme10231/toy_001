package com.sandl.dtos;

public class ScheduleDto {
	
	private int seq;
	private String id;
	private String sdate;
	private String edate;
	private int mntn_code;
	private String mcontent;
	private String pubflag;
	private String climbflag;
	private String pmntn_sn;
	
	private MntDto mntdto;
	
	
	public ScheduleDto() {
		super();
	}


	public ScheduleDto(int seq, String id, String sdate, String edate, int mntn_code, String mcontent, String pubflag,
			String climbflag, String pmntn_sn) {
		super();
		this.seq = seq;
		this.id = id;
		this.sdate = sdate;
		this.edate = edate;
		this.mntn_code = mntn_code;
		this.mcontent = mcontent;
		this.pubflag = pubflag;
		this.climbflag = climbflag;
		this.pmntn_sn = pmntn_sn;
	}
	
	


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getSdate() {
		return sdate;
	}


	public void setSdate(String sdate) {
		this.sdate = sdate;
	}


	public String getEdate() {
		return edate;
	}


	public void setEdate(String edate) {
		this.edate = edate;
	}


	public int getMntn_code() {
		return mntn_code;
	}


	public void setMntn_code(int mntn_code) {
		this.mntn_code = mntn_code;
	}


	public String getMcontent() {
		return mcontent;
	}


	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}


	public String getPubflag() {
		return pubflag;
	}


	public void setPubflag(String pubflag) {
		this.pubflag = pubflag;
	}


	public String getClimbflag() {
		return climbflag;
	}


	public void setClimbflag(String climbflag) {
		this.climbflag = climbflag;
	}


	public String getPmntn_sn() {
		return pmntn_sn;
	}


	public void setPmntn_sn(String pmntn_sn) {
		this.pmntn_sn = pmntn_sn;
	}


	


	public MntDto getMntdto() {
		return mntdto;
	}


	public void setMntdto(MntDto mntdto) {
		this.mntdto = mntdto;
	}


	@Override
	public String toString() {
		return "ScheduleDto [seq=" + seq + ", id=" + id + ", sdate=" + sdate + ", edate=" + edate + ", mntn_code="
				+ mntn_code + ", mcontent=" + mcontent + ", pubflag=" + pubflag + ", climbflag=" + climbflag
				+ ", pmntn_sn=" + pmntn_sn + "]";
	}
	
	
	
}
