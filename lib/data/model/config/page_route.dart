//페이지 정의
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/ui/screens/sentiment_analysis_page/sentiment_main_page.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page/emotion_analysis_loading.dart';
import 'package:to_morrow_front/ui/component/emotion_view.dart';
import 'package:to_morrow_front/ui/screens/modal_page/EmotionAnalysisModal.dart';
import '../../../ui/screens/main_page/main_home_page.dart';
import '../../../ui/screens/main_page/sound_write.dart';
import '../../../ui/screens/main_page/title_writing_material.dart';
import '../../../ui/screens/main_page/video_write.dart';
import '../../../ui/screens/main_page/word_writing_material.dart';
import '../../../ui/screens/modal_page/EmotionAnalysisModal.dart';
import '../../../ui/screens/my_page/my_profile.dart';
import '../../../ui/screens/poem_loeading_page/poem_loading_page.dart';
import '../../../ui/screens/recording_page/recording_page.dart';
import '../../../ui/screens/sentiment_analysis_page/user_sentiment_tag_page.dart';
import '../../../ui/screens/write_edit_page/write_edit_view.dart';
import '../../../ui/view_model/write_edit_view_model.dart';

//이동할 페이지를 정의
Map<String, Widget Function(String)> pages = {
  'Home': (emotion) => HomePage(emotion: emotion),
  'Profile': (_) => MyProfile(),
  'TitleWritingMaterial': (_) => TitleWritinMaterial(),
  'VideoWrite': (_) => VideoWrite(),
  'WordWritingMaterial': (_) => WordWritingMaterial(),
  'SoundWrite': (_) => SoundWrite(),
  'Emotion': (_) => EmotionView(),
  'WriteEdit': (source) => WriteEditView(source: source),
  'EmotionAnalysisModal': (_) => EmotionAnalysisModal(),
  'EmotionAnalysisLoading': (_) => EmotionAnalysisLoading(),
  'SentimentMainPage': (_) => SentimentMainPage(),
  'PoemLoadingPage': (_) => PoemLoadingPage(),
  'UserSentimentTagPage': (_) => UserSentimentTagPage(),
  'RecordingPage': (_) {
    final WriteEditViewModel controller = Get.find();
    return RecordingPage(
      title: controller.title.value,
      author: controller.userName.value,
      contents: controller.bodyContent.value,
    );
  },
};
