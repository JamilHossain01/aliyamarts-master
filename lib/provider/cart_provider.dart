import 'package:aliyamart/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider<CartNotifire, Map<String, CartModel>>((ref) {
  return CartNotifire();
});

class CartNotifire extends StateNotifier<Map<String, CartModel>> {
  CartNotifire() : super({});

  void addProductToCart({
    required String productName,
    required int productPrice, // Corrected typo
    required String productSize, // Corrected typo
    required String productId,
    required int inStock,
    required int discount,
    required int quantity,
    required String description,
    required String category,
    required String imageUrls,
  }) {
    if (state.containsKey(productId)) {
      // Update existing product, increasing quantity
      state = {
        ...state,
        productId: CartModel(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice, // Fixed typo
          productSize: state[productId]!.productSize, // Fixed typo

          // selectedSize: state[productID]!.selectedSize,
          quantity: state[productId]!.quantity + 1, // Increment quantity
          description: state[productId]!.description,
          category: state[productId]!.category,
          imageUrls: state[productId]!.imageUrls,
          inStock: state[productId]!.inStock,
          discount: state[productId]!.discount,
          productID: state[productId]!.productID,
        ),
      };
    } else {
      // Add new product to cart
      state = {
        ...state,
        productId: CartModel(
          productName: productName,
          productPrice: productPrice, // Fixed typo
          productSize: productSize, // Fixed typo
          productID: productId,
          // selectedSize: selectedSize,
          quantity: quantity,
          description: description,
          category: category,
          imageUrls: imageUrls,
          inStock: inStock,
          discount: discount,
        ),
      };
    }
  }

  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
    }
    state = {...state};
  }

  void decrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
    }
    state = {...state};
  }

  void removeItem(String productId) {
    state.remove(productId);
    state = {...state};
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.discount;
    });
    return totalAmount;
  }

  Map<String, CartModel> get cartItem => state;
}
