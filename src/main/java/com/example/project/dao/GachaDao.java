package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.vo.Gacha;

@Mapper
public interface GachaDao {

	@Insert("""
			INSERT INTO gacha
				SET `name` = #{fileName},
					grantDate = null,
					savedPath = #{savedPath}
			""")
	void insertFileInfo(String fileName, String savedPath);
	
	@Select("""
			<script>
			SELECT *
				FROM gacha
				WHERE 1 = 1
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordType == 'memberId'">
							AND memberId LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordType == 'id'">
							AND id LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordType == 'name'">
							AND name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND (
								memberId LIKE CONCAT('%', #{searchKeyword}, '%')
								OR id LIKE CONCAT('%', #{searchKeyword}, '%')
								OR name LIKE CONCAT('%', #{searchKeyword}, '%')
							)
						</otherwise>
					</choose>
				</if>
				ORDER BY id DESC
				LIMIT #{limitStart}, #{itemsInAPage}
			</script>
			""")
	List<Gacha> getFiles(String memberId, String searchKeywordType, String searchKeyword, int itemsInAPage,
			int limitStart);

	@Select("""
			SELECT *
				FROM gacha
				WHERE id = #{fileId}
			""")
	Gacha getFileById(int fileId);

	@Select("""
			SELECT COUNT(*)
				FROM gacha
			""")
	int getGachaCnt();

	@Select("""
			SELECT COUNT(*)
				FROM gacha
				WHERE memberId = 0
			""")
	int getGachaStockCnt();

	@Select("""
			SELECT COUNT(*)
				FROM gacha
				WHERE memberId != 0
			""")
	int getGachaSoldOutCnt();

}
