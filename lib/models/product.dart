class Product {
  final id;
  final title;
  final description;
  final price;
  final imageURL;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageURL,
      this.isFavorite = false});
}
