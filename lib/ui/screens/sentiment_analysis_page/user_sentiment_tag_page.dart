import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repository/controller/emotion_analysis_controller.dart';
import '../../../repository/controller/get_tags_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../component/custom_text_button.dart';
import '../../view_model/write_edit_view_model.dart';
import '../modal_page/wait_for_change_theme.dart';

class UserSentimentTagPageController extends GetxController {
  var wantGobak = false.obs; //돌아가기 버튼을 위한 상태변화 감지 변수

}

class UserSentimentTagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EmotionAnalysisController emotionController = Get.find();
    final WriteEditViewModel getPoemDetail = Get.find<WriteEditViewModel>();
    final MainTabController tabController = Get.find();
    final UserSentimentTagPageController setGoback =
    Get.put(UserSentimentTagPageController());

    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                SvgPicture.asset('assets/icons/writing_page/icon_test.svg'),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Text(
                    '감정태그를 클릭해서 원하는 감정태그로\n변경하시면 시를 일부분 수정해드립니다.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'KoPubBatangPro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),

            //테마랑 상호작용
            Obx(() {
              getPoemDetail.themes.value = emotionController.themes.value;
              getPoemDetail.interactions.value =
                  emotionController.interactions.value;

              if (emotionController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  _buildTagRow(
                      '테마', emotionController.themes.toList(), context),
                  const Divider(color: Colors.grey, thickness: 1.0),
                  _buildTagRow(
                      '상호작용', emotionController.interactions.toList(), context),
                  const Divider(color: Colors.grey, thickness: 1.0),
                ],
              );
            }),

            //글 제목
            Obx(() {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                child: Center(
                  child: Text(
                    getPoemDetail.title.value,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'KoPubBatangPro',
                    ),
                  ),
                ),
              );
            }),

            // 작가이름
            Obx(() {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    getPoemDetail.userName.value,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'KoPubBatangPro',
                    ),
                  ),
                ),
              );
            }),

            //본문 내용
            Obx(() {
              emotionController.tempContent.value =
                  getPoemDetail.bodyContent.value;
              return Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE6E2DB),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          child: Text(
                            getPoemDetail.bodyContent.value,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff373430),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            Container(
                height: 74,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => CustomTextButton(
                      text: '돌아가기',
                      hasIcon: true,
                      width: 152,
                      height: 44,
                      textStyle: TextStyle(
                        fontFamily: 'KoPubBatangPro',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.125,
                        // CSS의 line-height와 동일
                        color: setGoback.wantGobak.value
                            ? Color(0xFF3B3731)
                            : Color(0xFF7F7B75), // 버튼 텍스트 색상
                      ),
                      borderColor: setGoback.wantGobak.value
                          ? Color(0xFF3B3731)
                          : Color(0xFF7F7B75),
                      icon: Icon(Icons.undo_outlined),
                      onPressed: setGoback.wantGobak.value == true
                          ? () {
                        setGoback.wantGobak.value = false;

                        emotionController.themes.value =
                            emotionController.oldThemes.value;

                        emotionController.interactions.value =
                            emotionController.oldInteractions.value;

                        getPoemDetail.bodyContent.value =
                            emotionController.oldContent.value;
                      }
                          : null,
                    )),
                    CustomTextButton(
                        text: '탈고하기',
                        width: 152,
                        height: 44,
                        isHighlighted: true,
                        textStyle: TextStyle(
                          fontFamily: 'KoPubBatangPro',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.125,
                          // CSS의 line-height와 동일
                          color: Color(0xFF3B3731), // 버튼 텍스트 색상
                        ),
                        //탈고하기 버튼 클릭 시 모달창
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                content: Container(
                                  width: 280.0,
                                  height: 274.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E2DB),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Column(
                                    children: [
                                      // 닫기 버튼
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon:
                                          const Icon(Icons.close, size: 24),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // 텍스트 메시지
                                      const Flexible(
                                        child: Text(
                                          '낭독한 시는 독자들에게\n더 큰 공감을 받을 수 있습니다.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'KoPubBatangPro',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Color(0xFF373430),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      const Text(
                                        '* 탈고한 이후에는 작품 수정이 불가능합니다.',
                                        style: TextStyle(
                                          fontFamily: 'KoPubBatangPro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Color(0xFFDF0232),
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      // 버튼들
                                      Column(
                                        children: [
                                          CustomTextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              tabController.pageName.value =
                                              'PoemLoadingPage';
                                            },
                                            text: '낭독없이 탈고하겠습니다.',
                                            isHighlighted: false,
                                          ),
                                          const SizedBox(height: 16),
                                          CustomTextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              tabController.pageName.value =
                                              'RecordingPage';
                                            },
                                            text: '낭독한 시를 탈고하겠습니다.',
                                            isHighlighted: true,
                                          ),
                                          const SizedBox(height: 24),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        })
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTagRow(
      String title, List<String> apiTags, BuildContext context) {
    print(apiTags);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            height: 36.0,
            decoration: BoxDecoration(
              color: const Color(0xFFD0CDC8),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'KoPubBatangPro',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF373430),
                ),
              ),
            ),
          ),
          SizedBox(width: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: apiTags.map((tag) {
                final taggedString = tag;
                return GestureDetector(
                    onTap: () {
                      _showTagSelectionModal(
                          apiTags, taggedString, title, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(13, 7, 6, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(color: Color(0xff6D675F))),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                taggedString,
                                style: const TextStyle(
                                  fontFamily: 'KoPubBatangPro',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF373430),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 14,
                                color: Color(0xff6D675F),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

//태그 바꾸고싶을때
void _showTagSelectionModal(List<String> apiTags, String apiTagsString,
    String title, BuildContext context) async {
  final GetTagsController getTagsCtrl = Get.put(GetTagsController());

  // 데이터 로딩 완료를 기다림
  await getTagsCtrl.fetchData();

  List<String> availableTags;
  if (title == '테마') {
    availableTags = getTagsCtrl.themes.value;
  } else if (title == '상호작용') {
    availableTags = getTagsCtrl.interactions.value;
  } else {
    availableTags = [];
  }

  if (availableTags.isEmpty) {
    print('태그 목록이 비어있습니다.');
    return;
  }

  // 선택된 태그를 위한 옵저버블 변수
  var tempSelectedTag = ''.obs;

  // 태그의 선택 상태를 추적하는 Map
  Map<String, bool> tagSelectionMap = {
    for (var tag in availableTags) tag: false,
  };

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: 414,
            decoration: const BoxDecoration(
              color: Color(0xFFE6E2DB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12.0),
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
                Center(
                  child: Text(
                    title == '테마' ? '변경할 감정태그를 선택해주세요.' : '변경할 상호작용을 선택해주세요.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF373430),
                      fontSize: 18.0,
                      fontFamily: 'KoPubBatangPro',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEDEB),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: ListView(
                        children: availableTags.map((tag) {
                          final isSelected = tagSelectionMap[tag] ?? false;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  tempSelectedTag.value = tag;
                                  tagSelectionMap.updateAll((key, value) =>
                                  key == tag ? true : false);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: isSelected
                                      ? const Color(0xFF373430)
                                      : const Color(0xFFEFEDEB),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  title: Text(
                                    tag,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'KoPubBatangPro',
                                      fontWeight: FontWeight.w400,
                                      color: isSelected
                                          ? const Color(0xFFE6E2DB)
                                          : const Color(0xFF373430),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            onPressed:

                                () async {

                              // 새로운 리스트로 변경하고
                              if (apiTags.contains(apiTagsString)) {
                                apiTags.remove(apiTagsString);
                                if (tempSelectedTag.value.isNotEmpty) {
                                  apiTags.add(tempSelectedTag.value);
                                }
                              }

                              Get.back();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    WaitingInfoModal(title, apiTags),
                              );

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
    },
  );
}
