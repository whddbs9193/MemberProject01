package member;

import java.sql.Timestamp;

// DTO, VO, DataBean
// useBean 액션태그에서 사용 -> 데이터의 이동에서 사용
public class MemberDTO {
	// 프로퍼티 (property) -> 멤버변수
	// 아이디, 비밀번호, 이름, 이메일, 전화번호, 주소
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String address;
	private Timestamp regDate;

	public String getId() {
		return id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public String getTel() {
		return tel;
	}

	public String getAddress() {
		return address;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", address=" + address + ", regDate=" + regDate + "]";
	}

}
