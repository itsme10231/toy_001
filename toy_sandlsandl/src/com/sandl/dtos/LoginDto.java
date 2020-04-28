package com.sandl.dtos;

public class LoginDto {
	private String id;
	private String password;
	private String name;
	private String email;
	private String address;
	private String role;
	private String delflag;
	
	public LoginDto() {
	}

	public LoginDto(String id, String password, String name, String email, String address, String role,
			String delflag) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.address = address;
		this.role = role;
		this.delflag = delflag;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	@Override
	public String toString() {
		return "LoginDto [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", address="
				+ address + ", role=" + role + ", delflag=" + delflag + "]";
	}
	
	
	
}
