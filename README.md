# 🎃 Mirinaeman Halloween Candy Catch Game

미리내맨 할로윈 캔디 캐치 게임 - Flutter + Flame 게임 엔진으로 제작

## 🎮 게임 소개

할로윈 테마의 캔디 캐치 게임입니다. 떨어지는 캔디와 호박을 잡아서 점수를 얻으세요!

### 게임 특징
- 🍬 **6가지 색상의 막대사탕**: 나선 무늬와 막대기가 있는 귀여운 캔디
- 🎃 **할로윈 호박**: 30% 확률로 등장하는 잭오랜턴
- 🎵 **배경음악**: 신나는 할로윈 테마 BGM (30초 루프)
- 🔊 **효과음 3가지**: 캔디 수집, 캔디 놓침, 게임오버
- ❤️ **생명 시스템**: 3개의 생명
- 📊 **점수 시스템**: 캔디를 잡을 때마다 10점
- 🚀 **난이도 자동 증가**: 점수가 높을수록 캔디가 빨리 떨어짐
- 💻 **PC 중앙 배치**: 450x932px 스마트폰 화면 크기

### 조작 방법
- **웹(PC)**: 방향키 ← → 로 이동
- **모바일**: 화면 터치 (왼쪽/오른쪽)

## 📱 앱 정보

- **앱 이름**: Mirinaeman Halloween Candy
- **패키지명**: com.mirinaeman001.app
- **버전**: 1.0
- **개발자**: 미리내맨 김준호 (동서울대학교 전기공학과)

## 📦 다운로드

### APK 파일
릴리즈 APK 파일은 저장소의 `releases` 섹션에서 다운로드할 수 있습니다.

파일 크기: 약 42MB

### 프로젝트 백업
전체 프로젝트 백업 (APK 포함):
- [프로젝트 백업 다운로드](https://page.gensparksite.com/project_backups/mirinaeman_halloween_candy_complete.tar.gz)

## 🛠️ 개발 환경

- **Flutter**: 3.35.4
- **Dart**: 3.9.2
- **게임 엔진**: Flame 1.32.0
- **오디오**: audioplayers 6.1.0

## 🚀 빌드 방법

### 웹 빌드
```bash
flutter build web --release
```

### Android APK 빌드
```bash
flutter build apk --release
```

## 📂 프로젝트 구조

```
lib/
  ├── main.dart                          # 앱 진입점
  ├── screens/
  │   ├── menu_screen.dart              # 메인 메뉴 화면
  │   └── game_screen.dart              # 게임 화면
  └── components/
      ├── candy_catch_game.dart         # 메인 게임 로직
      ├── player_character.dart         # 플레이어 캐릭터
      ├── candy.dart                    # 캔디 오브젝트
      └── pumpkin.dart                  # 호박 오브젝트

assets/
  └── audio/
      ├── halloween_bgm.mp3             # 배경음악
      ├── candy_collect.mp3             # 캔디 수집 효과음
      ├── candy_miss.mp3                # 캔디 놓침 효과음
      └── game_over.mp3                 # 게임오버 효과음
```

## 🎨 게임 디자인

### 캔디 색상
1. 핑크 (#ff0066 / #ffccdd)
2. 하늘색 (#00ccff / #ccf0ff)
3. 초록 (#00ff66 / #ccffdd)
4. 노랑 (#ffcc00 / #fff4cc)
5. 주황 (#ff6600 / #ffddcc)
6. 보라 (#cc00ff / #f0ccff)

### 게임 화면
- 배경색: 어두운 보라 (#1a0033)
- UI 색상: 주황색 (할로윈 테마)
- 점수/생명 표시: 화면 상단

## 📄 라이선스

이 프로젝트는 교육 목적으로 제작되었습니다.

## 👨‍💻 개발자

**미리내맨 김준호**
- 소속: 동서울대학교 전기공학과
- GitHub: [@hegler02](https://github.com/hegler02)

---

🎃 Happy Halloween! 🍬
