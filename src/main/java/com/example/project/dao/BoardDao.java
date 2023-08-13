package com.example.project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.vo.Board;

@Mapper
public interface BoardDao {

	@Select("""
				SELECT *
					FROM board
					WHERE id = #{boardId}
					AND delStatus = 0
			""")
	public Board getBoardById(int boardId);

}
