package com.sandl.dtos;

public class WishDto {
	private int seq;
	private String id;
	private int mntn_code;
	
	private MntDto mntdto;

	public WishDto() {

	}

	public WishDto(int seq, String id, int mntn_code, MntDto mntdto) {
		super();
		this.seq = seq;
		this.id = id;
		this.mntn_code = mntn_code;
		this.mntdto = mntdto;
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

	public int getMntn_code() {
		return mntn_code;
	}

	public void setMntn_code(int mntn_code) {
		this.mntn_code = mntn_code;
	}

	public MntDto getMntdto() {
		return mntdto;
	}

	public void setMntdto(MntDto mntdto) {
		this.mntdto = mntdto;
	}
	
	
}
