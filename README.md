# 유지보수 계약 관리 시스템

외부 업체와의 유지보수 계약을 등록·관리하고, 만료 임박 계약을 한눈에 파악하여 갱신 협상을 준비할 수 있는 웹 애플리케이션입니다.

## 주요 기능

| 기능 | 설명 |
|------|------|
| **대시보드** | 계약 현황 요약, 만료 임박 계약 강조 표시 (30일 이내 주황색, 만료 빨간색) |
| **계약 목록** | 계약 검색·필터링, 상세 조회 |
| **계약 등록/수정/삭제** | 업체명, 시스템/장비명, 계약기간, 금액 등 CRUD |
| **만료 알림** | 만료 30일/7일/1일 이내 자동 감지 및 갱신 협상 필요 여부 표시 |
| **엑셀 가져오기** | 기존 엑셀 데이터를 시스템으로 일괄 이전 |
| **엑셀 내보내기** | 계약 데이터를 Excel 파일로 다운로드 |

## 기술 스택

- **Frontend**: Vue.js 3 + Vue Router
- **상태 관리**: Pinia
- **스타일링**: Tailwind CSS
- **빌드 도구**: Vite
- **데이터 저장**: localStorage (추후 Supabase 전환 예정)
- **문서 처리**: ExcelJS, FileSaver

## 설치 및 실행

### 간편 실행 (Windows)

`유지보수관리.exe.bat` 파일을 더블클릭하면 앱이 실행됩니다.

### 수동 실행

```bash
# 1. 패키지 설치
npm install

# 2. 개발 서버 실행
npm run dev

# 3. 빌드
npm run build
```

## 파일 구조

```
maintenance-app/
├── src/
│   ├── components/        # UI 컴포넌트
│   │   ├── common/        # 공통 컴포넌트
│   │   ├── contract/      # 계약 관련 컴포넌트
│   │   ├── dashboard/     # 대시보드 컴포넌트
│   │   ├── import/        # 엑셀 가져오기 컴포넌트
│   │   └── layout/        # 레이아웃 컴포넌트
│   ├── views/             # 페이지 뷰
│   ├── stores/            # Pinia 상태 관리
│   ├── services/          # 저장소 로직 (storage.js)
│   ├── composables/       # Vue Composables
│   ├── constants/         # 상수 정의
│   ├── utils/             # 유틸리티 함수
│   ├── router/            # 라우터 설정
│   ├── App.vue            # 루트 컴포넌트
│   └── main.js            # 앱 진입점
├── data/                  # 엑셀 원본 데이터
├── public/                # 정적 파일
├── package.json           # 프로젝트 설정 및 의존성
├── vite.config.js         # Vite 설정
├── tailwind.config.js     # Tailwind CSS 설정
├── 유지보수관리.exe.bat   # Windows 간편 실행 스크립트
└── README.md              # 프로젝트 설명
```

## 설계 특징

- **저장소 분리**: 데이터 접근 로직이 `services/storage.js`에 집중되어 있어, 추후 Supabase 등 외부 DB로 전환 시 이 파일만 수정하면 됩니다.
- **만료일 관리**: 계약 만료 임박 여부를 자동으로 감지하여 대시보드에서 시각적으로 강조 표시합니다.
