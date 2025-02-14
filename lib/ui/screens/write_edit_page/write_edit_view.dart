import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/repository/controller/topic_controller.dart';
import 'package:to_morrow_front/ui/component/speech_bubble.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';

class WriteEditView extends StatefulWidget {
  final String source;

  WriteEditView({super.key, required this.source});

  @override
  _WriteEditViewState createState() => _WriteEditViewState();
}

class _WriteEditViewState extends State<WriteEditView> {
  final WriteEditViewModel viewModel = Get.put(WriteEditViewModel());
  final MainTabController tabController = Get.find();
  final TopicController topicController = Get.put(TopicController('title'));
  final AuthService authService = AuthService();
  late TextEditingController _titleController;

  final List<Map<String, Object>> fonts = [
    {"family": "NotoSans", "weight": FontWeight.w900, "name": "NotoSans Black"},
    {"family": "NotoSans", "weight": FontWeight.w700, "name": "NotoSans Bold"},
    {"family": "NotoSans", "weight": FontWeight.w500, "name": "NotoSans Medium"},
    {"family": "NotoSans", "weight": FontWeight.w400, "name": "NotoSans Regular"},
    {"family": "NotoSans", "weight": FontWeight.w300, "name": "NotoSans Light"},
    {"family": "NotoSans", "weight": FontWeight.w100, "name": "NotoSans Thin"},
    {"family": "KoPubBatangPro", "weight": FontWeight.w900, "name": "KoPub Batang Bold"},
    {"family": "KoPubBatangPro", "weight": FontWeight.w700, "name": "KoPub Batang Light"},
    {"family": "KoPubBatangPro", "weight": FontWeight.w500, "name": "KoPub Batang Medium"},
    {"family": "KoPub Dotum", "weight": FontWeight.w400, "name": "KoPub Dotum Bold"},
    {"family": "KoPub Dotum", "weight": FontWeight.w300, "name": "KoPub Dotum Light"},
    {"family": "KoPub Dotum", "weight": FontWeight.w100, "name": "KoPub Dotum Medium"},
  ];

  @override
  void initState() {
    super.initState();
    tabController.isMain.value = false;
    _titleController = TextEditingController();
    tabController.currentPage.value = 'WriteEdit';

    // 필명 불러오기
    authService.loadServiceName().then((name) {
      viewModel.userName.value = name ?? '투모로우';
    });


    // 현재 topic 값 ViewModel에 저장
    final topicController = Get.find<TopicController>();

    // title일 경우에만 적용
    if (topicController.type.value == 'title') {
      final currentTitle = topicController.topic.value;
      _titleController.text = currentTitle;
      viewModel.updateTitle(currentTitle);
    } else {
      // title 아닐 경우 값 비움
      _titleController.clear();
      viewModel.updateTitle('');
    }

    // topic이 변경될 때마다 업데이트
    ever(topicController.topic, (String? newTitle) {
      if (topicController.type.value == 'title') {
        _titleController.text = newTitle ?? '';
        viewModel.updateTitle(newTitle ?? '');
      }
    });
  }

  @override
  void dispose() {
    tabController.isMain.value = true;
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // 상단 광고 배너 공간
                Container(
                  height: 66,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    'assets/images/banner.svg', // 이미지 파일 경로
                    fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 설정
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // 왼쪽 사이드바
                      Container(
                        width: 50,
                        color: const Color(0xFF6D675F),
                        child: Stack(
                          children: [
                            // 텍스트 정렬 변경
                            Positioned(
                              top: 42,
                              left: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE6E2DB),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/img/format_align_left.svg',
                                    width: 24,
                                  ),
                                  onPressed: viewModel.toggleTextAlign,
                                ),
                              ),
                            ),
                            // 폰트 크기 변경
                            Positioned(
                              top: 88,
                              left: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE6E2DB),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/img/format_size.svg',
                                    width: 24,
                                  ),
                                  onPressed: viewModel.toggleFontSize,
                                ),
                              ),
                            ),
                            // 글꼴 변경
                            Positioned(
                              top: 134,
                              left: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE6E2DB),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/img/brand_family.svg',
                                    width: 24,
                                  ),
                                  onPressed: () {
                                    _showFontSelection(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 오른쪽 입력 부분
                      Expanded(
                        child: Container(
                          color: const Color(0xFFE6E2DB),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            hintText: '제목을 입력해주세요',
                                            hintStyle: TextStyle(
                                                color: Color(0xFFB8B4AD)),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFB8B4AD)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF373430)),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: viewModel.selectedFont['family'] as String?,
                                            fontWeight: viewModel.selectedFont['weight'] as FontWeight?,
                                          ),
                                          controller: _titleController,
                                          // 텍스트 정렬 적용
                                          textAlign: _getTextAlign(
                                              viewModel.textAlign.value),
                                          onChanged: (value) {
                                            viewModel.updateTitle(value); // 제목이 변경될 때 ViewModel에 업데이트
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Obx(() {
                                          return Text(
                                            viewModel.userName.value,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'KoPubBatangPro',
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF373430),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: '본문을 입력해주세요',
                                            hintStyle:
                                            TextStyle(color: Color(0xFFB8B4AD)),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            // 폰트 크기 적용
                                            fontSize: _getFontSize(
                                                viewModel.fontSize.value),
                                            fontFamily: viewModel.selectedFont['family'] as String?,
                                            fontWeight: viewModel.selectedFont['weight'] as FontWeight?,
                                          ),
                                          // 텍스트 정렬 적용
                                          textAlign: _getTextAlign(
                                              viewModel.textAlign.value),
                                          maxLines: null,
                                          expands: true,
                                          keyboardType: TextInputType.multiline,
                                          textInputAction: TextInputAction.newline,
                                          onChanged: (value) {
                                            viewModel.updateBodyContent(value); // 본문 내용이 변경될 때 ViewModel에 업데이트
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 하단 중앙에 말풍선 추가
          // 하단 중앙에 말풍선 추가 - isFormComplete에 따라 표시 여부 결정
          Obx(() {
            return viewModel.isFormComplete.value
                ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBubbleWidget(
                    comment: '원고가 완성되었다면 버튼을 클릭해주세요.'),
              ),
            )
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  // 텍스트 정렬 변경
  TextAlign _getTextAlign(String value) {
    switch (value) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  // 폰트 크기 변경
  double _getFontSize(double value) {
    return value;
  }

  // 글꼴 변경
  void _showFontSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return Container(
          height: 414,
          decoration: const BoxDecoration(
            color: Color(0xFFE6E2DB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              // 상단 막대
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4,
                  width: 32,
                  margin: const EdgeInsets.only(bottom: 32.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF373430),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // 제목
              const Align(
                alignment: Alignment.center,
                child: Text(
                  '변경할 폰트를 선택해주세요.',
                  style: TextStyle(
                    color: Color(0xFF373430),
                    fontSize: 18.0,
                    fontFamily: 'KoPubBatangPro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // 폰트 목록
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEDEB),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListView.builder(
                      itemCount: fonts.length,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          bool isSelected = fonts[index]["family"] ==
                              viewModel.tempSelectedFont['family'] &&
                              fonts[index]["weight"] ==
                                  viewModel.tempSelectedFont['weight'];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 4.0,
                            ).copyWith(
                              top: index == 0 ? 10.0 : 4.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                viewModel.tempSelectedFont.value =
                                Map<String, Object>.from(fonts[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF373430)
                                      : const Color(0xFFEFEDEB),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding:
                                const EdgeInsets.symmetric(vertical: 12.0),
                                alignment: Alignment.center,
                                child: Text(
                                  fonts[index]["name"] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                    fonts[index]["family"] as String?,
                                    fontWeight:
                                    fonts[index]["weight"] as FontWeight?,
                                    color: isSelected
                                        ? const Color(0xFFE6E2DB)
                                        : const Color(0xFF373430),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              // 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.only(bottom: 24.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE3DED4),
                            foregroundColor: const Color(0xFF3B3731),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          onPressed: () {
                            viewModel.cancelFontChange();
                            Get.back();
                          },
                          child: const Text('닫기'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.only(bottom: 24.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B3731),
                            foregroundColor: const Color(0xFFE3DED4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            viewModel.applyFontChange();
                            Get.back();
                          },
                          child: const Text('변경'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
