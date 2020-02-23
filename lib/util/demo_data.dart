class ProductData {

  final String title;
  final int requiredPoints;
  final String iconImage;

  ProductData(this.title, this.requiredPoints, this.iconImage);
}

class DemoData{

  //how many points this user has earned, in a real app this would be loaded from an online service.
  int earnedPoints = 150;

  //List of available drinks
  List<ProductData> drinks = [
    ProductData("Salgadinho Doritos", 100, "assets/products/doritos.png"),
    ProductData("Refrigerante Coca Cola", 150, "assets/products/coca-cola_2l_.png"),
    ProductData("Detergente Ype", 250, "assets/products/ype.jpg"),
    ProductData("Shampoo Seda", 350, "assets/products/seda.jpeg"),
    ProductData("Sabão em pó Omo", 450, "assets/products/omo.jpeg"),
  ];

}
