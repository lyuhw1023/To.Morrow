import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteEditViewModel extends GetxController {

  // 텍스트 정렬 -> 'left', 'center', 'right'
  var textAlign = 'left'.obs;

  // 폰트 크기 -> 14(기본), 16(큰), 12(작은)
  var fontSize = 14.0.obs;

  // 선택된 폰트 패밀리
  var selectedFont = <String, Object>{
    "family": "KoPubBatangPro",
    "weight": FontWeight.w400,
    "name": "KoPub Batang Medium"
  }.obs;

  // 임시 선택된 폰트
  var tempSelectedFont = <String, Object>{}.obs;

  // 사용자 이름을 관리할 변수
  var userName = ''.obs;

  // 제목 저장 변수
  var title = ''.obs;

  // 본문 내용 저장 변수
  var bodyContent = ''.obs;

  // 제목과 본문이 모두 입력되었는지 확인하는 변수
  var isFormComplete = false.obs;

  // 원본 내용
  var originalContent = ''.obs;

  // 원본 제목
  var originalTitle = ''.obs;

  // 영감 ID
  var inspirationId = ''.obs;

  // 오디오 파일
  var audioFile = ''.obs;

  // 테마 리스트
  var themes = <String>[].obs;

  // 사용자 인터랙션 리스트
  var interactions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    tempSelectedFont.value = Map<String, Object>.from(selectedFont);

    // 제목 또는 본문이 변경될 때마다 isFormComplete 상태를 업데이트
    everAll([title, bodyContent], (_) {
      checkFormCompletion();
    });
  }

  // 텍스트 정렬 변경
  void toggleTextAlign() {
    if (textAlign.value == 'left') {
      textAlign.value = 'center';
    } else if (textAlign.value == 'center') {
      textAlign.value = 'right';
    } else {
      textAlign.value = 'left';
    }
  }

  // 폰트 크기 변경
  void toggleFontSize() {
    if (fontSize.value == 14.0) {
      fontSize.value = 16.0;
    } else if (fontSize.value == 16.0) {
      fontSize.value = 12.0;
    } else {
      fontSize.value = 14.0;
    }
  }

  // 폰트 변경 적용
  void applyFontChange() {
    selectedFont.value = Map<String, Object>.from(tempSelectedFont);
  }

  // 폰트 변경 취소
  void cancelFontChange() {
    tempSelectedFont.value = Map<String, Object>.from(selectedFont);
  }

  // 제목 업데이트
  void updateTitle(String newTitle) {
    title.value = newTitle;
    checkFormCompletion();
  }

  // 본문 내용 업데이트
  void updateBodyContent(String newContent) {
    bodyContent.value = newContent;
    checkFormCompletion();
  }

  // 제목과 본문이 모두 입력되었는지 확인하는 함수
  void checkFormCompletion() {
    isFormComplete.value = title.value.isNotEmpty && bodyContent.value.isNotEmpty;
  }

  // 원본 내용 업데이트
  void updateOriginalContent(String newOriginalContent) {
    originalContent.value = newOriginalContent;
  }

  // 원본 제목 업데이트
  void updateOriginalTitle(String newOriginalTitle) {
    originalTitle.value = newOriginalTitle;
  }

  // 영감 ID 업데이트
  void updateInspirationId(String newInspirationId) {
    inspirationId.value = newInspirationId;
  }

  // 오디오 파일 업데이트
  void updateAudioFile(String newAudioFile) {
    audioFile.value = newAudioFile;
  }

  // 테마 추가
  void addTheme(String theme) {
    themes.add(theme);
  }

  // 테마 제거
  void removeTheme(String theme) {
    themes.remove(theme);
  }

  // 인터랙션 추가
  void addInteraction(String interaction) {
    interactions.add(interaction);
  }

  // 인터랙션 제거
  void removeInteraction(String interaction) {
    interactions.remove(interaction);
  }

  // 값 초기화
  void resetValues() {
    textAlign.value = 'left';
    fontSize.value = 14.0;
    selectedFont.value = {
      "family": "KoPubBatangPro",
      "weight": FontWeight.w400,
      "name": "KoPub Batang Medium"
    };
    tempSelectedFont.value = Map<String, Object>.from(selectedFont);  // 임시 선택된 폰트도 초기화
    title.value = '';  // 제목 초기화
    bodyContent.value = '';  // 본문 내용 초기화
    isFormComplete.value = false;  // 폼 완료 상태 초기화
    originalContent.value = '';  // 원본 내용 초기화
    originalTitle.value = '';  // 원본 제목 초기화
    inspirationId.value = '';  // 영감 ID 초기화
    audioFile.value = '';  // 오디오 파일 초기화
    themes.clear();  // 테마 리스트 초기화
    interactions.clear();  // 인터랙션 리스트 초기화

  }
}
