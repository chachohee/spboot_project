package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.vo.FileVO;

@Mapper
public interface FileDao {
	
	@Insert("""
			INSERT INTO file
				SET regDate = NOW(),
					originName = #{orgName},
					savedName = #{savedName},
					savedPath = #{savedPath},
					memberId = #{memberId}
			""")
	void insertFileInfo(String orgName, String savedName, String savedPath, int memberId);

	@Select("""
			SELECT *
				FROM file
				WHERE id = #{fileId}
			""")
	FileVO getFileById(int fileId);

	@Select("""
			SELECT f.*,
					m.nickname AS writerName
				FROM `file` AS f
				INNER JOIN `member` AS m
				ON f.memberId = m.id
				ORDER BY f.id DESC
			""")
	List<FileVO> getFiles();

}
