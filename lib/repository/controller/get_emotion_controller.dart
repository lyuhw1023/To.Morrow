import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:to_morrow_front/data/model/emotion_model.dart';
import 'auth_service.dart';

class GetEmotionController extends GetxController {
  var _baseUrl = 'https://api.leemhoon.com';

  Future<List<EmotionModel>> fetchEmotion() async {
    try {
      final uri = Uri.parse('$_baseUrl/emotions');
      final authService = AuthService();
      final token = await authService.loadServiceTokens(); // 서비스 토큰 불러오기

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) {
          final emotionModel = EmotionModel.fromJson(e);
          return emotionModel.copyWith(
            iconPath: _getIconPathForEmotion(emotionModel.title),
          );
        }).toList();
      } else {
        print('GetEmotionController 에러 발생: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
      return [];
    }
  }

  String _getIconPathForEmotion(String emotion) {
    switch (emotion) {
      case '기쁨':
        return 'assets/images/icon-happy.svg';
      case '슬픔':
        return 'assets/images/icon-sad.svg';
      case '두려움':
        return 'assets/images/icon-fear.svg';
      case '분노':
        return 'assets/images/icon-anger.svg';
      case '기대':
        return 'assets/images/icon-expect.svg';
      case '신뢰':
        return 'assets/images/icon-trust.svg';
      case '모르겠음':
        return 'assets/images/icon-dontno.svg';
      default:
        return 'assets/images/icon-happy.svg';
    }
  }
}
