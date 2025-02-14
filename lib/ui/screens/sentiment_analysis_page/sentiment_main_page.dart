import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/ui/screens/sentiment_analysis_page/user_sentiment_tag_page.dart';


//글쓰기페이지(감정분석)
class SentimentMainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/writing_page/to_morrow_mini_icon.svg',
              ),
              SizedBox(height: 24.0),
              Text(
                'TO.MORROW가\n~님이 탈고하신\n‘시 제목’의 마음을\n읽어내는 중입니다..',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'KoPubBatangPro',
                ),
              ),
              SizedBox(height: 68.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {


                    // 페이지 이동
                    Get.to(() => UserSentimentTagPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF373430),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'KoPubBatangPro',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

