# GaCha Pong 💊✨
![gacha 복사본](https://github.com/chachohee/spboot_project/assets/83406032/c57fec09-55b0-4ed9-b74b-f44fa59bc36a)

랜덤으로 이미지를 얻고, 갤러리에 자신이 뽑은 이미지를 자랑할 수 있습니다!😊<br>
게시판 CRUD를 중점으로 한 스프링부트 프로젝트입니다.

# 주요 기능 설명
## 👩🏻‍🏫 관리자 기능
### 랜덤 이미지 생성
- [hashlips_art_engine](https://github.com/HashLips/hashlips_art_engine) 참고
- 조합 이미지 layer는 [Figma](https://www.figma.com/) 사용

![랜덤이미지](https://github.com/chachohee/spboot_project/assets/83406032/efc9eddd-4c5f-49f7-ac56-3233020bc533)

### 랜덤으로 생성된 이미지 파일 업로드
- 다중 파일 업로드

![다중파일업로드](https://github.com/chachohee/spboot_project/assets/83406032/bb5aeffa-e58e-48d8-b398-0c3ff903cb78)

### 회원 관리
- 회원 삭제 시, 삭제 여부와 삭제 날짜 update

![회원관리](https://github.com/chachohee/spboot_project/assets/83406032/0f2ce64d-674b-4d61-93cc-8a001d814476)

## 👩‍👧‍👦 회원 기능
### 회원가입, 로그인, 로그아웃
- 회원가입

![회원가입](https://github.com/chachohee/spboot_project/assets/83406032/9ba26fbd-5d19-409f-bb16-aa323edb6f68)

- 로그인, 로그아웃

![로그인로그아웃](https://github.com/chachohee/spboot_project/assets/83406032/85dde46b-a3e7-4e30-8d0b-2e30f31e650f)

### 회원정보 수정, 비밀번호 변경
- 회원정보 수정

![회원정보수정](https://github.com/chachohee/spboot_project/assets/83406032/e1ddaa44-10f4-469b-be45-b2ffc55fae79)

- 비밀번호 변경

![비밀번호변경](https://github.com/chachohee/spboot_project/assets/83406032/40a253b1-1938-4932-bcb0-cc3131fb958d)

### 아이디 찾기, 비밀번호 찾기(임시 패스워드 전송)
- 이름, 이메일로 아이디 찾기

![아이디찾기](https://github.com/chachohee/spboot_project/assets/83406032/3dbdabe6-3165-422f-b8b8-3dc21f306ead)

- 임시패스워드 전송(Gmail 앱 비밀번호 사용)

![비밀번호찾기1](https://github.com/chachohee/spboot_project/assets/83406032/5aa69cd8-0ffd-48bd-87f2-0f593ce480a4)
![비밀번호찾기2](https://github.com/chachohee/spboot_project/assets/83406032/5a78fe47-58f4-4556-84f2-e7c6ee3461d5)

## 🥚 가챠 기능
### 가챠 얻기
- 랜덤 이미지를 얻으면 마이컬렉션에 저장

![가챠뽑기마이컬렉션](https://github.com/chachohee/spboot_project/assets/83406032/2debf061-aae7-4046-84b5-0077d1fda6e7)

### 나의 가챠 자랑하기
- 단일 파일 업로드

![단일파일업로드](https://github.com/chachohee/spboot_project/assets/83406032/ab7e6e33-37ce-429a-8210-0170c7b09fdd)

## 📝 게시판 CRUD
- 게시글 작성, 조회, 수정, 삭제
- 댓글 작성, 조회, 수정, 삭제
- 좋아요, 싫어요

## 🔍 검색 기능
- 각 페이지 우측 상단에 적용
#### GACHA 
- 가챠 갤러리

<img width="1424" alt="스크린샷 2023-09-15 오전 2 27 24" src="https://github.com/chachohee/spboot_project/assets/83406032/1b691da9-935c-4605-b968-8334b583cf8d">

#### BOARD 
- 공지사항, 자유게시판

<img width="1424" alt="스크린샷 2023-09-15 오전 2 27 43" src="https://github.com/chachohee/spboot_project/assets/83406032/d3c872e9-1a9b-4355-b21d-156791cd6389">

#### USER 
- 회원 관리

<img width="1424" alt="스크린샷 2023-09-15 오전 2 27 53" src="https://github.com/chachohee/spboot_project/assets/83406032/41424092-067c-4bad-b524-a687c252ccb2">
<img width="1424" alt="스크린샷 2023-09-15 오전 2 27 57" src="https://github.com/chachohee/spboot_project/assets/83406032/cf6b635f-8ce0-4670-a771-3ccf08e37194">

- 가챠 관리

<img width="1424" alt="스크린샷 2023-09-15 오전 2 28 06" src="https://github.com/chachohee/spboot_project/assets/83406032/8d10efec-1bf0-499b-9fe4-c65c54b20dad">
<img width="1424" alt="스크린샷 2023-09-15 오전 2 28 11" src="https://github.com/chachohee/spboot_project/assets/83406032/df0e5e9f-e5e8-421f-b493-e0d77deb8f7b">

- 마이컬렉션

<img width="1424" alt="스크린샷 2023-09-15 오전 2 28 32" src="https://github.com/chachohee/spboot_project/assets/83406032/6d5b924c-3f4f-4176-acb5-919190ba3c93">

## ⚙️ 테마 변경(다크 테마/라이트 테마)
![테마변경](https://github.com/chachohee/spboot_project/assets/83406032/6e37aaa0-abb2-4523-9a51-3330b3799c29)
