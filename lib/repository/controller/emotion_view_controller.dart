import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/model/poem.dart';
import 'auth_service.dart';
import 'maintab_controller.dart';

class EmotionViewController extends GetxController {
  final MainTabController tabController = Get.find();

  RxList<Poem> poems = <Poem>[].obs;
  var currentIndex = 0.obs;

  Future<void> getPoems(String emotion) async {
    var _baseUrl = 'https://api.leemhoon.com/poems';

    try {
      poems.clear();
      currentIndex.value = 0;

      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'index': '$currentIndex',
          if (emotion != '모르겠음') 'emotion': emotion,
        },
      );

      final authService = AuthService();
      final token = await authService.loadServiceTokens();

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Poem> newPoems =
        jsonData.map((poemJson) => Poem.fromJson(poemJson)).toList();

        // 페이지를 업데이트합니다.
        poems.addAll(newPoems);

        // 다음 페이지를 위한 인덱스 업데이트
        currentIndex.value += newPoems.length;
      } else {
        // 에러 처리
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
    }
  }

  Future<void> sendEmotionToServer(String emotion) async {
    var _baseUrl = 'https://api.leemhoon.com/emotions/select';

    try {
      // 감정 정보를 서버에 전송합니다.
      if (emotion == '모르겠음') {
        return;
      } else {

        final uri = Uri.parse(_baseUrl);
        final AuthService authService = AuthService(); // AuthService 인스턴스화

        final token = await authService.loadServiceTokens(); // 서비스 토큰 불러오기


        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        Map<String, String> body = {"emotion": emotion};

        final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

        if (response.statusCode >= 200 && response.statusCode < 300) {
          print('감정선택내역저장api 성공 : ${response.statusCode}');
        } else {
          print('감정선택내역저장api 실패 : ${response.statusCode}');
        }
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
    }
  }
}
