package com.kh.onairstudy.scheduler.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.onairstudy.scheduler.model.dao.SchedulerDAO;
import com.kh.onairstudy.scheduler.model.vo.Scheduler;

/*@Transactional(propagation = Propagation.REQUIRED,
isolation = Isolation.READ_COMMITTED,
rollbackFor = Exception.class)*/
@Service
public class SchedulerServiceImpl implements SchedulerService {

	@Autowired
	private SchedulerDAO schedulerDAO;

	@Override
	public List<Scheduler> mainScheduler(String memberId) {
		return schedulerDAO.mainScheduler(memberId);
	}

	@Override
	public int insertSchedule(Scheduler sch) {
		return schedulerDAO.insertSchedule(sch);
	}

	@Override
	public int deleteSchedule(int no) {
		return schedulerDAO.deleteSchedule(no);
	}

	@Override
	public Scheduler selectOne(int no) {
		return schedulerDAO.selectOne(no);
	}
	
	
	
	
}