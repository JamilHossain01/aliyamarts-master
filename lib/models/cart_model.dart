class CartModel {
  final String productName;
  final int productPrice; // Corrected typo
  final String productSize; // Corrected typo
  final String productID;
  final int inStock;
  final int discount;

  final int quantity;
  final String description;
  final String category;
  final String imageUrls;

  CartModel(
      {required this.productName,
      required this.productPrice,
      required this.productSize,
      required this.productID,
      required this.quantity,
      required this.description,
      required this.category,
      required this.imageUrls,
      required this.inStock,
      required this.discount});
}
