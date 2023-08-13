package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.vo.Reply;

@Mapper
public interface ReplyDao {

	@Insert("""
			INSERT INTO reply
				SET updateDate = NOW()
					, memberId = #{loginedMemberId}
					, relTypeCode = #{relTypeCode}
					, relId = #{relId}
					, `body` = #{body}
			""")
	void writeReply(int loginedMemberId, String relTypeCode, int relId, String body);

	@Select("""
			SELECT r.*, m.nickname AS writerName
				FROM reply AS r
				LEFT JOIN `member` AS m
				ON r.memberId = m.id
				WHERE relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	List<Reply> getReplies(String relTypeCode, int relId);

	@Select("""
			SELECT *
				FROM reply
				WHERE id = #{id}
			""")
	Reply getReply(int id);

	@Delete("""
			DELETE FROM reply
				WHERE id = #{id}
			""")
	void deleteReply(int id);

	@Update("""
			UPDATE reply
				SET `body` = #{body}
				WHERE id = #{id}
			""")
	void modifyReply(int id, String body);

}
