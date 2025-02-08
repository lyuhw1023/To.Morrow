# AI 기반 창작 중심 SNS 플랫폼, To.Morrow

<br><br>

## 팀원구성
### 기획자 : 1명
### 디자이너 : 1명
### Frontend(Flutter) : 3명
### Backend & AI : 2명

<br>

## Tech
<img src="https://skillicons.dev/icons?i=flutter,dart,androidstudio,dcomponents&perline="/>

<br>


## 1. 프로젝트 명
AI 기반 창작 중심 SNS 플랫폼, To.Morrow <br><br>
<img width="181" alt="splash" src="https://github.com/user-attachments/assets/46772e1e-97df-4500-bc13-e7970491635f" />


<img width="181" alt="splash" src="https://github.com/user-attachments/assets/4e7906e8-3ac8-4fc1-a709-9f1ec06fb303" />
<img width="187" alt="main" src="https://github.com/user-attachments/assets/e57c5fd7-34f1-4114-83d5-b40f555c413d" />
<img width="180" alt="write_edit_view" src="https://github.com/user-attachments/assets/3f40d16d-6f08-4184-8a37-1d98ed194a50" />
<img width="180" alt="write_edit_view_2" src="https://github.com/user-attachments/assets/3b309008-971a-4dec-90e4-dafdffd5dddf" />
<img width="190" alt="loading" src="https://github.com/user-attachments/assets/a56cfc3b-fc86-4461-be1a-8cdb11980a34" />

## 2. 프로젝트 소개
> To.Morrow는 사용자의 감정 상태에 따라 AI가 적절한 시와 글을 추천하고, 이를 기반으로 창작할 수 있도록 돕는 감성 중심의 창작 SNS 플랫폼입니다.
또한, 사용자가 직접 작성한 창작물을 공유하고, 음성 낭독 기능을 활용해 더 깊은 감동을 경험할 수 있도록 지원합니다.




## 3. 프로젝트 목적 
>감성 기반 추천 시스템을 활용하여 사용자가 자신의 감정에 맞는 시와 글을 발견할 수 있도록 지원 <br>
AI를 활용하여 시 창작 및 편집 기능을 제공하고, 감정 태그를 기반으로 새로운 창작물을 만들어낼 수 있도록 돕기<br>
음성 낭독 기능을 통해 시각적 경험을 넘어 청각적인 감동까지 전달<br>
창작자들이 자신의 작품을 SNS 형태로 공유하고, 독자들과 소통할 수 있는 창작 생태계 구축
<img src="https://github.com/lyuhw1023/EyeForYouapp_FrontEnd/assets/52669844/80f61c30-6472-42d5-9f41-b1c0885caf34" width="330px"/>
<img src="https://github.com/lyuhw1023/EyeForYouapp_FrontEnd/assets/52669844/3c7c3eb9-7276-4c0e-b1fa-9b89756955b8" width="330px"/>
<img src="https://github.com/lyuhw1023/EyeForYouapp_FrontEnd/assets/52669844/d5fc1193-07ed-4bf9-9168-d9f54fac011e" width="330px"/>


## 4. 프로젝트 기능 소개
1️⃣ Emotion Select (감정 선택) 페이지
💡 기능 개요

사용자는 7가지 감정 중 현재 자신의 상태에 맞는 감정을 선택
AI가 감정을 분석하여, 해당 감정과 연관된 시 및 창작 글을 추천
서버에서 감정 데이터를 받아와 화면에 표시하고, 사용자가 선택한 감정을 다시 서버로 전송
2️⃣ Write Edit (창작 및 편집) 페이지
💡 기능 개요

AI가 추천한 글감을 기반으로 사용자가 직접 편집 가능
글 정렬, 글자 크기 변경, 폰트 선택 기능을 제공하여 창작물의 완성도를 높임
작성된 창작물은 서버에 저장되어, 이후 다시 수정 가능
3️⃣ Loading (로딩) 페이지
💡 기능 개요

AI가 데이터를 분석하고 추천하는 동안 로딩 화면 제공
서버에서 데이터를 성공적으로 받아오면 확인 버튼이 활성화됨
FutureBuilder 및 Lottie 애니메이션을 활용하여 UI/UX 개선
4️⃣ Main (메인) 페이지 및 결과 페이지
💡 기능 개요

사용자는 시 또는 창작물을 선택하여 감상
감상한 후, 공유하거나 피드백을 남길 수 있음
감정 기반 추천을 강화하여 더 개인화된 창작 경험 제공
5️⃣ Voice Narration (음성 낭독) 기능
💡 기능 개요

AI 또는 사용자가 직접 낭독한 음성을 제공
시각적 텍스트 + 청각적 경험을 조합하여 더욱 몰입감 있는 감상 가능
추후 AI 더빙 시스템 개발을 통해 프리미엄 오디오북 서비스로 확장 가능
6️⃣ SNS 공유 및 피드 시스템
💡 기능 개요

사용자가 직접 작성한 창작물을 SNS 형식의 피드로 공유
다른 사용자의 피드를 감상하고 좋아요, 댓글 기능을 통해 교류 가능
감성 기반 태그 추천을 통해 비슷한 감성을 가진 창작자 및 독자 연결



1. 실시간 상품 인식 및 음성 안내
> 카메라 촬영 : 사용자가 홈 화면의 카메라를 터치하여 상품을 촬영합니다.<br>
> AI 상품 인식 : 촬영된 이미지에서 AI 모델이 자동으로 상품을 인식합니다.<br>
> 음성 안내 : 인식된 상품의 이름과 세부 정보를 음성으로 안내합니다.<br>
> 코너 인식 : 상품 코너가 인식될 경우, AI가 현재 위치가 스낵 코너인지 음료 코너인지를 음성으로 안내합니다.
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/11c4f423-f342-4ce6-b761-509086ceea3a" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/f720da3b-a894-40a1-953e-bb6fbe4a2b63" width="200px"/>
<br><br>

2. 복지 혜택 정보 제공
> 간편 검색 : 시각 장애인들이 받을 수 있는 다양한 복지 혜택 정보를 한 곳에 모아 제공합니다.<br>
> 맞춤 정보 제공 : 사용자는 복잡한 절차 없이 자신에게 맞는 혜택 정보를 쉽게 얻을 수 있습니다.<br>
> 카테고리 분류 : 생애 주기, 복지 서비스, 중증 및 경증 등으로 나누어 정보를 제공하여 필요한 정보를 빠르게 찾을 수 있도록 도와줍니다.<br>
> 음성 안내 : 혜택 정보도 보이스 오버 기능을 통해 음성으로 안내하여 시각 장애인들이 쉽게 접근할 수 있도록 합니다. <br>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/39946a94-423c-4400-a83a-630a0bce6348" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/fc01894d-a79e-4a0f-8953-cd8d553ea6d5" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/e54c839f-6d51-431b-9bb8-cd860ef9abc9" width="200px"/>
<br>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/8ca249cf-56a1-475a-807f-6e6436ec717c" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/18137006-faf7-43e1-88e9-9a8f765b43cc" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/39b109fc-ef2c-468d-9963-823388d2ef04" width="200px"/>
<br><br>

3. 도움말 기능
> 접근성 : 모든 화면에는 도움말 기능이 포함되어 있습니다. 사용자는 언제든지 도움말 아이콘을 통해 각 화면에 대한 상세한 설명을 받을 수 있습니다.
> 음성 안내 : 모든 도움말 내용은 보이스 오버 기능을 통해 음성으로 안내됩니다. 이는 시각 장애인들이 어플리케이션을 더욱 쉽게 이해하고 사용할 수 있도록 돕습니다.
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/9c8f4a02-e107-4715-9722-75d569e12d40" width="200px"/>
<img src="https://github.com/lyuhw1023/lyuhw1023/assets/52669844/fcb4e5a5-a3c1-4d28-ab7f-8158b58ebfb6" width="200px"/>
<br><br>

## 5. 프로젝트 기대효과 
> 본 프로젝트는 시각 장애인분들의 오프라인 쇼핑에서 편의성과 자립성을 높이기 위해 기획되었다.

> 주요 서비스로 이미지 인식을 통한 상품 식별 기능을 제공하는 앱을 개발하였다. 사용자가 카메라로 상품을 촬영하면 앱은 이미지 인식 기술을 활용하여 상품을 식별하고, 음성으로 상품 이름과, 세부 정보를 제공하여 사용자가 더욱 독립적으로 쇼핑을 할 수 있도록 지원한다. 더불어 부가 기능으로는 경증/중증 혜택 모아보기 서비스는 사용자들이 자신의 상황에 맞는 다양한 혜택과 지원을 쉽게 찾아볼 수 있도록 도와준다. 이러한 기능들이 탑재된 이 앱을 통해 오프라인 쇼핑 경험을 향상시킬 수 있을 것이라 기대되며, 이미지 인식 기능을 활용하여 사용자들은 보다 안전하고 편리하게 쇼핑을 할 수 있을 것으로 예상된다.

> 또한, 다양한 혜택을 쉽게 찾아볼 수 있는 서비스를 통해 사용자들은 필요한 정보를 보다 쉽게 얻을 수 있을 것으로 기대된다. 이 앱은 시각 장애인들의 삶을 보다 더 편안하게 만들기 위한 노력의 일환으로, 오프라인 쇼핑 경험을 향상시키는 데 중요한 역할을 할 것으로 기대된다.

## 6. 프로젝트 시연 영상
> AI 카메라 시연 영상
- https://youtube.com/shorts/tCxOXFQCtCA?feature=share
> 중증, 경증 해택 모아보기
- https://youtube.com/shorts/EYVD3zvKUJY

## 7. 시스템 아키텍처
<img src="https://github.com/user-attachments/assets/b0c9ff95-3471-4eab-a20e-9eef8e074ab2"/>


> 클라이언트 (모바일/웹): 사용자가 상품을 촬영하고 복지 혜택 정보를 검색합니다.<br>
> 서버: FastAPI 기반의 서버에서 이미지 데이터를 처리하고, AI 모델을 통해 상품을 인식하며, 결과를 클라이언트에 전달합니다.<br>





