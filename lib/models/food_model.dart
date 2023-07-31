class Food{
  final String menu;
  final String imageUrl;
  
  const Food({required this.imageUrl, required this.menu});

  static const List<Map<String, dynamic>> foodData = [
    {
      "date": "7월 19일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_01.jpg",
        "assets/food/KakaoTalk_20230713_013044286_02.jpg",
        "assets/food/KakaoTalk_20230713_013044286_03.jpg",
      ],
    },
    {
      "date": "7월 18일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_04.jpg",
        "assets/food/KakaoTalk_20230713_013044286_05.jpg",
        "assets/food/KakaoTalk_20230713_013044286_06.jpg",
      ],
    },
    {
      "date": "7월 17일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_07.jpg",
        "assets/food/KakaoTalk_20230713_013044286_08.jpg",
      ],
    },
    {
      "date": "7월 16일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_09.jpg",
        "assets/food/KakaoTalk_20230713_013044286_10.jpg",
      ],
    },
  ];
}