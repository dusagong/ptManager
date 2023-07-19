class Food{
  final String menu;
  final String imageUrl;

  const Food({
    required this.menu,
    required this.imageUrl,
  });

  static const List<Food> foods = [
    Food(
      menu: 'apple',
      imageUrl: ''
    )
  ];

}