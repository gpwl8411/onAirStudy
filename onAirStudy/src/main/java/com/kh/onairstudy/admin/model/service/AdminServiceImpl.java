package com.kh.onairstudy.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.onairstudy.admin.model.dao.AdminDAO;
import com.kh.onairstudy.member.model.vo.Member;
import com.kh.onairstudy.servicecenter.model.vo.ServiceCenter;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;

	@Override
	public List<Member> memberList() {
		return adminDAO.memberLis();
	}

	@Override
	public Map<String, Object> memberDetail(String memberId) {
		return adminDAO.memberDetail(memberId);
	}

	@Override
	public List<Map<String, Object>> serviceList() {
		return adminDAO.serviceList();
	}

	@Override
	public Map<String, Object> serviceDetail(int no) {
		return adminDAO.serviceDetail(no);
	}

	@Override
	public Map<String, Object> serviceDetailAv(int no) {
		return adminDAO.serviceDetailAv(no);
	}

	@Override
	public int insertService(ServiceCenter sc) {
		return adminDAO.insertService(sc);
	}

	@Override
	public int updateService(int replyNo) {
		return adminDAO.updateService(replyNo);
	}
	
	
	
}
