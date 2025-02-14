import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_morrow_front/repository/controller/emotion_view_controller.dart';
import 'package:to_morrow_front/repository/controller/get_emotion_controller.dart';
import 'package:to_morrow_front/repository/controller/global_controller.dart';
import 'package:to_morrow_front/repository/controller/login_controller.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/repository/controller/sound_write_controller.dart';
import 'package:to_morrow_front/ui/component/emotion_view.dart';
import 'package:to_morrow_front/ui/screens/main_page/main_home_page.dart';
import 'package:to_morrow_front/ui/screens/main_page/sound_write.dart';
import 'package:to_morrow_front/ui/screens/poem_loeading_page/poem_loading_page.dart';
import 'package:to_morrow_front/ui/screens/recording_page/recording_page.dart';
import 'package:to_morrow_front/ui/screens/splash_page/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page/emotion_analysis_loading.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page/write_edit_view.dart';
import 'package:to_morrow_front/ui/view_model/emotion_view_model.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';



Future<void> main() async {
  runApp(const tomorrow());

  Get.put(GlobalController());
  Get.put(LoginController());
  Get.put(MainTabController());
  Get.put(EmotionViewController());
  Get.put(WriteEditViewModel());
  Get.put(SoundWriteController());




  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
}


class  tomorrow extends StatelessWidget {
  const tomorrow({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "tomorrow",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'KoPubBatangPro',
      ),
      // home: RecordingPage(title: 'aaa', author: 'bbb', contents: 'ccc',),
      home : EmotionView(),
    );

  }
}