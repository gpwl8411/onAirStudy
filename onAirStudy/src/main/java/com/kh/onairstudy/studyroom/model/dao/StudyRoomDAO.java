package com.kh.onairstudy.studyroom.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.onairstudy.studyroom.model.vo.ProfileAttachment;
import com.kh.onairstudy.studyroom.model.vo.StudyCategory;
import com.kh.onairstudy.studyroom.model.vo.StudyRoom;
import com.kh.onairstudy.studyroom.model.vo.StudyRoomInfo;
import com.kh.onairstudy.studyroom.model.vo.StudyRoomList;
import com.kh.onairstudy.studyroom.model.vo.StudyRoomLog;
import com.kh.onairstudy.studyroom.model.vo.StudyRoomWaiting;
import com.kh.onairstudy.studyroom.model.vo.StudyRoomWish;

public interface StudyRoomDAO {
	
	int insertWating(StudyRoomWaiting srWating);

	List<StudyRoom> selectMystudyList();

	List<StudyRoomWaiting> selectMywaitingList();

	List<StudyRoomWish> selectMywishList();

	List<StudyRoomList> selectStudyRoomList();

	List<StudyCategory> selectCategoryList();

	int insertProfileAttachment(ProfileAttachment profile);

	int insertStudyRoom(StudyRoomList roomlist);

	int insertStudyRoomList(StudyRoom studyroom);
	
	int insertWish(StudyRoomWish srWish);

	//
	List<StudyRoomList> selectDiligentStudyroom();

	List<StudyRoomLog> selectParticipantList(int roomNum);

	List<String> selectApplicantList(int roomNum);

	StudyRoomInfo selectRoomInfo(int roomNum);

	List<Map<String, Object>> searchRoom(Map<String, String> param);

	int selectParticipatingRoomCnt(String memberId);

	int deleteWaiting(Map<String, Object> param);

	int insertStudyLog(Map<String, Object> param);


	

	

}
