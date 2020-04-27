package com.moon.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.moon.domain.BoardVO;
import com.moon.domain.Criteria;
import com.moon.domain.SearchCriteria;
import com.moon.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private BoardDAO dao;
	
	// 게시글 등록
	@Override
	public void regist(BoardVO board) throws Exception {		
		dao.create(board);				
	}

	// 게시글 읽기
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) throws Exception {
		dao.updateViewCnt(bno);
		return dao.read(bno);
	}
	
	// 게시글 수정
	@Override
	public void modify(BoardVO board) throws Exception {
		dao.update(board);		
	}

	// 게시글 삭제
	@Override
	public void remove(Integer bno) throws Exception {
		dao.delete(bno);		
	}

	// 리스트 전체 불러오기
	@Override
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}

	// 리스트 불러오기 페이징
	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {		
		return dao.listCriteria(cri);
	}

	// 전체 게시물의 숫자 반환
	@Override
	public int listCountCriteria(Criteria cri) throws Exception {		
		return dao.countPaging(cri);
	}

	// 검색조건에 따른 조회
	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	// 검색 조건에 따른 총 게시물 수 반환
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}
}
