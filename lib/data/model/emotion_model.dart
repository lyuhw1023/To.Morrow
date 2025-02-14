import 'dart:convert';

class EmotionModel {
  final String title;
  final String iconPath;
  final List<String> detail;

  EmotionModel({
    required this.title,
    required this.iconPath,
    required this.detail,
  });

  factory EmotionModel.fromJson(Map<String, dynamic> json) {
    return EmotionModel(
      title: json['emotion'] as String,
      iconPath: '',
      detail: List<String>.from(json['description']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emotion': title,
      'iconPath': iconPath,
      'description': detail,
    };
  }

  EmotionModel copyWith({
    String? emotion,
    String? iconPath,
    List<String>? description,
  }) {
    return EmotionModel(
      title: emotion ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      detail: description ?? this.detail,
    );
  }

  //항상 추가할 모르겠음
  static EmotionModel defaultUnknownEmotion() {
    return EmotionModel(
      title: '모르겠음',
      iconPath: 'assets/images/icon-dontno.svg',
      detail: [],
    );
  }



}
