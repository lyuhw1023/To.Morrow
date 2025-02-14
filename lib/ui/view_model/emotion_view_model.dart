import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:to_morrow_front/data/model/emotion_model.dart';
import 'package:to_morrow_front/repository/constant/emotion_repository.dart';
import 'dart:convert';

import '../../repository/controller/get_emotion_controller.dart';

class EmotionViewModel extends GetxController {
  var emotions = <EmotionModel>[].obs;
  var selectedEmotion = Rxn<EmotionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchEmotions();
  }

  Future<void> fetchEmotions() async {
    final GetEmotionController controller = Get.put(GetEmotionController());
    final fetchedEmotions =  await controller.fetchEmotion();

    // "모르겠음" 추가
    final unknownEmotion = EmotionModel.defaultUnknownEmotion();
    emotions.value = [...fetchedEmotions, unknownEmotion];
  }


  void selectEmotion(EmotionModel emotion) async{
    if (selectedEmotion.value == emotion) {
      //이미 선택된 감정 다시 누른 경우
      selectedEmotion.value = null;
    } else {
      //새로운 감정을 선택한 경우
      selectedEmotion.value = emotion;
    }
  }

  Future<void> sendEmotionToServer(EmotionModel emotion) async {
    final url = Uri.parse('');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': emotion.title,
      }),
    );

    if (response.statusCode == 200) {
      print('서버 연결 성공');
    } else {
      print('서버 연결 실패');
    }
  }

}