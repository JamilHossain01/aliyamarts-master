import 'package:aliyamart/models/favourite_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider =
StateNotifierProvider<FavoriteNotifier, Map<String, FavouriteModel>>(
      (ref) {
    return FavoriteNotifier();
  },
);

class FavoriteNotifier extends StateNotifier<Map<String, FavouriteModel>> {
  FavoriteNotifier() : super({});

  //is to add product to favorite

  void addProductToFavorite({
    required String productName,
    required String productId,
    required List imageUrl,
    required int productPrice,
  }) {
    state[productId] = FavouriteModel(
        productName: productName,
        productId: productId,
        imageUrls: imageUrl,
        productPrice: productPrice);

    //notify listeners that the state has changed

    state = {...state};
  }

  //remove all item from favorite

  void removeAllItem() {
    state.clear();

    //notify listeners that the state has changed

    state = {...state};
  }

//remove favorite item

  void removeItem(String productId) {
    state.remove(productId);

    //notify listeners that the state has changed

    state = {...state};
  }

//retrive value from the state object
  Map<String, FavouriteModel> get getFavoriteItem => state;


}
