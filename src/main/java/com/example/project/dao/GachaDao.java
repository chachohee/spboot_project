package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.vo.Gacha;

@Mapper
public interface GachaDao {

	@Insert("""
			INSERT INTO gacha
				SET orgName = #{orgName},
					grantDate = null,
					savedName = #{savedName},
					savedPath = #{savedPath}
			""")
	void insertFileInfo(String orgName, String savedName, String savedPath);
	
	@Select("""
			<script>
			SELECT *
				FROM gacha
				WHERE 1 = 1
					<if test="stock != 0">
						AND stock = #{stock}
					</if>
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'memberId'">
								AND memberId LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'id'">
								AND id LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'orgName'">
								AND orgName LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<otherwise>
								AND (
									memberId LIKE CONCAT('%', #{searchKeyword}, '%')
									OR id LIKE CONCAT('%', #{searchKeyword}, '%')
									OR orgName LIKE CONCAT('%', #{searchKeyword}, '%')
								)
							</otherwise>
						</choose>
					</if>
				ORDER BY id DESC
				LIMIT #{limitStart}, #{itemsInAPage}
			</script>
			""")
	List<Gacha> getFiles(int stock, String searchKeywordType, String searchKeyword, int itemsInAPage,
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
	int getGachaTotalCnt();

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

	@Select("""
			<script>
			SELECT COUNT(*)
				FROM gacha
				WHERE 1 = 1
					<if test="stock != 0">
						AND stock = #{stock}
					</if>
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'memberId'">
								AND memberId LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'id'">
								AND id LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'orgName'">
								AND orgName LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<otherwise>
								AND (
									memberId LIKE CONCAT('%', #{searchKeyword}, '%')
									OR id LIKE CONCAT('%', #{searchKeyword}, '%')
									OR orgName LIKE CONCAT('%', #{searchKeyword}, '%')
								)
							</otherwise>
						</choose>
					</if>
			</script>
			""")
	int getGachasCnt(int stock, String searchKeywordType, String searchKeyword);

	@Select("""
			SELECT id 
				FROM gacha
				WHERE memberId = 0
				ORDER BY RAND() LIMIT 1;
			""")
	int getGachaId();

	@Update("""
			UPDATE gacha
				SET grantDate = NOW(),
					memberId = #{memberId}
				WHERE id = #{gachaId}
			""")
	void updateGachaInfo(int gachaId, int memberId);

	@Select("""
			<script>
			SELECT *
				FROM gacha
				WHERE 1 = 1
					AND memberId = #{memberId}
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'grantDate'">
								AND grantDate LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'id'">
								AND id LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'orgName'">
								AND orgName LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<otherwise>
								AND (
									grantDate LIKE CONCAT('%', #{searchKeyword}, '%')
									OR id LIKE CONCAT('%', #{searchKeyword}, '%')
									OR orgName LIKE CONCAT('%', #{searchKeyword}, '%')
								)
							</otherwise>
						</choose>
					</if>
				ORDER BY grantDate DESC
				LIMIT #{limitStart}, #{itemsInAPage}
			</script>
			""")
	List<Gacha> getMyGachas(int memberId, String searchKeywordType, String searchKeyword, int itemsInAPage, int limitStart);

	@Select("""
			<script>
			SELECT COUNT(*)
				FROM gacha
				WHERE 1 = 1
					AND memberId = #{memberId}
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'grantDate'">
								AND grantDate LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'id'">
								AND id LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'orgName'">
								AND orgName LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<otherwise>
								AND (
									grantDate LIKE CONCAT('%', #{searchKeyword}, '%')
									OR id LIKE CONCAT('%', #{searchKeyword}, '%')
									OR orgName LIKE CONCAT('%', #{searchKeyword}, '%')
								)
							</otherwise>
						</choose>
					</if>
			</script>
			""")
	int getMyGachasCnt(int memberId, String searchKeywordType, String searchKeyword);

}
