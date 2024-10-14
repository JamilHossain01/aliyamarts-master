import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/favourite_mode.dart';

final favrtProvider =
    StateNotifierProvider<FavouriteNotifier, Map<String, FavouriteModel>>(
  (ref) {
    return FavouriteNotifier();
  },
);

class FavouriteNotifier extends StateNotifier<Map<String, FavouriteModel>> {
  FavouriteNotifier() : super({});

  void addFavouriteItem({
    required String productName,
    required String productId, // Corrected spelling
    required List imageUrls,
    required int productPrice, // Corrected spelling
  }) {
    // Always add or update the item in favorites

    state[productId] = FavouriteModel(
      productName: productName,
      productId: productId, // Corrected spelling

      productPrice: productPrice,
      imageUrls: imageUrls, // Corrected spelling
    );
    state = {
      ...state,
    };
  }

  void removeAll() {
    state.clear();

    state = {...state};
  }

  Map<String, FavouriteModel> get favrtItem => state;
}
