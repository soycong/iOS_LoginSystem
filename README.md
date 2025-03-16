# iOS 로그인 시스템
사용자 로그인, 회원가입 시스템을 구현한 애플리케이션입니다.

## 버전 요구사항
- Xcode 버전: 16.1 이상
- iOS 지원 버전: iOS 16.0 이상
- Swift 버전: Swift 5 이상

## 기술 스택
- **아키텍처**: MVVM (Model-View-ViewModel)
- **반응형 프로그래밍**: RxSwift, RxCocoa
- **데이터 저장**: CoreData
- **UI 구성**: UIKit, SnapKit

## 주요 기능
- **회원가입**: 이메일, 비밀번호, 닉네임으로 계정 생성
- **로그인**: CoreData에 저장된 계정으로 로그인
- **프로필**: 사용자 정보 조회
- **로그아웃 & 회원탈퇴**: 계정 관리 기능

## 스크린샷
<div style="display: flex; justify-content: space-between;">
    <img width="240" alt="화면 1" src="https://github.com/user-attachments/assets/9d051c46-117e-4452-93cc-38880a14d308">
    <img width="240" alt="화면 2" src="https://github.com/user-attachments/assets/21c2fee7-ffae-477d-8ff1-dd2f1c672062">
    <img width="240" alt="화면 3" src="https://github.com/user-attachments/assets/8e50381d-bfa3-43f4-9247-9f86bd3d1f76">
    <img width="240" alt="화면 4" src="https://github.com/user-attachments/assets/d8a211c3-dd0c-4b57-b5e9-67c5e4d12f02">
</div>

## 구현 내용

### 화면 구성
- **초기 화면**: 로그인 성공 화면/회원가입 화면 이동
- **회원가입 화면**: 유효성 검사를 통한 사용자 등록
- **메인 화면**: 사용자 정보 표시 및 계정 관리

### 데이터 관리
- CoreData를 활용한 사용자 정보 저장 및 관리
- RxSwift를 통한 데이터 바인딩 및 상태 관리

## 커밋 컨벤션
| 타입 | 설명 |
|------|------|
| add | 새로운 파일 및 폴더 추가 |
| feat | 화면, 컴포넌트, 기능 추가 및 수정 (주요 변경사항) |
| fix | 버그 수정 |
| update | 간단한 변경 사항 |
| refactor | 코드 정리 및 단순화/ 파일·폴더 이름이나 위치 변경 / 주석·콘솔 관리 |
| delete | 폴더 및 파일 삭제 |
| docs | 문서 추가, 수정, 삭제 (예: README.md) |
| test | 테스트 코드 작성, 수정, 삭제 |
| chore | 패키지·라이브러리 추가, 버전 변경, 삭제 |
| style | 스타일, 에셋 추가 |

## 브랜치 전략
1. **메인 브랜치**: 프로젝트 기본 세팅
2. **개발 브랜치**: 메인 브랜치를 기준으로 생성
3. **기능 브랜치**:  
   - 브랜치 이름 형식: `작업번호-작업-제목` (예: `feature/signupView`)
4. **작업 관리**:
   - 작업을 백로그에 [기록 → 할 일 → 진행 중 → PR → 완료] 로 관리
