package com.kh.onairstudy.diary.model.dao;

import java.util.List;

import com.kh.onairstudy.diary.model.vo.Diary;

public interface DiaryDAO {

	List<Diary> selectDiaryList();

}