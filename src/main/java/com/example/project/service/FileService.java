package com.example.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dao.FileDao;
import com.example.project.vo.FileVO;

@Service
public class FileService {
	
	@Value("${file.dir}")
	private String fileDir;

	private FileDao fileDao;

	@Autowired
	public FileService(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	public void saveFile(MultipartFile file, int memberId) throws IOException {

		if (file.isEmpty()) {
			return;
		}

		String orgName = file.getOriginalFilename();

		String uuid = UUID.randomUUID().toString();

		String extension = orgName.substring(orgName.lastIndexOf("."));

		String savedName = uuid + extension;

		String savedPath = fileDir + "/" + savedName;
		
//		MultipartFile resizeFile = resizeImage(file, orgName, extension, savedName);

		fileDao.insertFileInfo(orgName, savedName, savedPath, memberId);

		file.transferTo(new File(savedPath));
	}

	public List<FileVO> getFiles() {
		return fileDao.getFiles();
	}

	public FileVO getFileById(int fileId) {
		return fileDao.getFileById(fileId);
	}

//	MultipartFile resizeImage(MultipartFile file, String orgName, String extension, String savedName) {
//		
//        try {
//            // MultipartFile -> BufferedImage Convert
//            BufferedImage image = ImageIO.read(file.getInputStream());
//            // newWidth : newHeight = originWidth : originHeight
//            int orgWidth = image.getWidth();
//            int orgHeight = image.getHeight();
//
//            // origin 이미지가 resizing될 사이즈보다 작을 경우 resizing 작업 안 함
//            if(orgWidth < 256)
//                return file;
//
//            MarvinImage imageMarvin = new MarvinImage(image);
//
//            Scale scale = new Scale();
//            scale.load();
//            scale.setAttribute("newWidth", 256);
//            scale.setAttribute("newHeight", 256 * orgHeight / orgWidth);
//            scale.process(imageMarvin.clone(), imageMarvin, null, null, false);
//
//            BufferedImage imageNoAlpha = imageMarvin.getBufferedImageNoAlpha();
//            ByteArrayOutputStream baos = new ByteArrayOutputStream();
//            ImageIO.write(imageNoAlpha, extension, baos);
//            baos.flush();
//
//            return new MockMultipartFile(savedName, baos.toByteArray());
//
//        } catch (IOException e) {
//            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "파일 리사이즈에 실패했습니다.");
//        }
//    }

}
