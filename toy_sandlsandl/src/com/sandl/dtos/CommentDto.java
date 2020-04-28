package com.sandl.dtos;

import java.util.Date;

public class CommentDto {
	private int seq;
	private int mntn_code;
	private String id;
	private String mcomment;
	private int mlike;
	private Date regdate;
	private String delflag;
	private String pubflag;
	private int pmntn_sn;
	private int sch_seq;
	
	private int sumlike;
	private int climbc;
	private int wishc;
	private String mntn_name;
	
	private MntDto mntdto;
	
	public CommentDto() {

	}

	public CommentDto(int seq, int mntn_code, String id, String mcomment, int mlike, Date regdate, String delflag,
			String pubflag, int pmntn_sn, int sch_seq, int sumlike, int climbc, int wishc) {
		super();
		this.seq = seq;
		this.mntn_code = mntn_code;
		this.id = id;
		this.mcomment = mcomment;
		this.mlike = mlike;
		this.regdate = regdate;
		this.delflag = delflag;
		this.pubflag = pubflag;
		this.pmntn_sn = pmntn_sn;
		this.sch_seq = sch_seq;
		this.sumlike = sumlike;
		this.climbc = climbc;
		this.wishc = wishc;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getMntn_code() {
		return mntn_code;
	}

	public void setMntn_code(int mntn_code) {
		this.mntn_code = mntn_code;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMcomment() {
		return mcomment;
	}

	public void setMcomment(String mcomment) {
		this.mcomment = mcomment;
	}

	public int getMlike() {
		return mlike;
	}

	public void setMlike(int mlike) {
		this.mlike = mlike;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getPubflag() {
		return pubflag;
	}

	public void setPubflag(String pubflag) {
		this.pubflag = pubflag;
	}

	public int getPmntn_sn() {
		return pmntn_sn;
	}

	public void setPmntn_sn(int pmntn_sn) {
		this.pmntn_sn = pmntn_sn;
	}

	public int getSch_seq() {
		return sch_seq;
	}

	public void setSch_seq(int sch_seq) {
		this.sch_seq = sch_seq;
	}

	public int getSumlike() {
		return sumlike;
	}

	public void setSumlike(int sumlike) {
		this.sumlike = sumlike;
	}

	public int getClimbc() {
		return climbc;
	}

	public void setClimbc(int climbc) {
		this.climbc = climbc;
	}

	public int getWishc() {
		return wishc;
	}

	public void setWishc(int wishc) {
		this.wishc = wishc;
	}

	public MntDto getMntdto() {
		return mntdto;
	}

	public void setMntdto(MntDto mntdto) {
		this.mntdto = mntdto;
	}

	public String getMntn_name() {
		return mntn_name;
	}

	public void setMntn_name(String mntn_name) {
		this.mntn_name = mntn_name;
	}

	@Override
	public String toString() {
		return "CommentDto [seq=" + seq + ", mntn_code=" + mntn_code + ", id=" + id + ", mcomment=" + mcomment
				+ ", mlike=" + mlike + ", regdate=" + regdate + ", delflag=" + delflag + ", pubflag=" + pubflag
				+ ", pmntn_sn=" + pmntn_sn + ", sch_seq=" + sch_seq + ", sumlike="
				+ sumlike + ", climbc=" + climbc + ", wishc=" + wishc + "]";
	}

	
	
	
	

	
}
