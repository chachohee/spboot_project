package com.example.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dao.GachaDao;
import com.example.project.vo.Gacha;

@Service
public class GachaService {
	
	@Value("${gacha.dir}")
	private String fileDir;
	
	private GachaDao gachaDao;

	@Autowired
	public GachaService(GachaDao gachaDao) {
		super();
		this.gachaDao = gachaDao;
	}
	
	public void saveFile(MultipartFile file) throws IOException {

		if (file.isEmpty()) {
			return;
		}

		String orgName = file.getOriginalFilename();
		
		String uuid = UUID.randomUUID().toString();
		
		String extension = orgName.substring(orgName.lastIndexOf("."));
		
		String savedName = uuid + extension;

		String savedPath = fileDir + "/" + savedName;

		gachaDao.insertFileInfo(orgName, savedName, savedPath);

		file.transferTo(new File(savedPath));
	}
	
	public List<Gacha> getFiles(String memberId, String searchKeywordType, String searchKeyword, int itemsInAPage,
			int page) {

		int limitStart = (page - 1) * itemsInAPage;
		
		return gachaDao.getFiles(memberId, searchKeywordType, searchKeyword, itemsInAPage, limitStart);
	}

	public Gacha getFileById(int fileId) {
		return gachaDao.getFileById(fileId);
	}

	public int getGachaCnt() {
		return gachaDao.getGachaCnt();
	}

	public int getGachaStockCnt() {
		return gachaDao.getGachaStockCnt();
	}

	public int getGachaSoldOutCnt() {
		return gachaDao.getGachaSoldOutCnt();
	}

	

}
