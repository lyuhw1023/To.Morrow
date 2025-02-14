import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart'; // AuthService import

class EmotionAnalysisController extends GetxController {
  var isLoading = false.obs; // 로딩 상태를 관리하는 변수
  final AuthService authService = AuthService(); // AuthService 인스턴스화

  var themes = <String>[].obs;
  var interactions = <String>[].obs;

  var oldThemes = <String>[].obs;
  var oldInteractions = <String>[].obs;

  var oldContent = ''.obs;
  var tempContent = ''.obs;



  // 시 태그 분석을 위해 서버에 요청을 보내는 메서드
  Future<bool> analyzePoem(String title, String content) async {
    try {
      isLoading.value = true; // 로딩 시작
      final token = await authService.loadServiceTokens(); // 서비스 토큰 불러오기


      final uri = Uri.parse(
          'https://api.leemhoon.com/poems/analyze'); // 실제 API base URL로 변경


      final headers = {
        'Authorization': 'Bearer $token', // 토큰을 헤더에 포함
        'Content-Type': 'application/json',
      };

      final body = json.encode({
        'title': title,
        'content': content
      });

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('themes')) {
          themes.value = List<String>.from(jsonResponse['themes']);
        }
        if (jsonResponse.containsKey('interactions')) {
          interactions.value = List<String>.from(jsonResponse['interactions']);
        }

        return true;
      } else {
        print('시 태그 분석 실패: ${response.statusCode}');
        return false; // 요청 실패
      }
    } catch (e) {
      print('예외 발생: $e');
      return false; // 요청 실패
    } finally {
      isLoading.value = false; // 로딩 종료
    }
  }
}
