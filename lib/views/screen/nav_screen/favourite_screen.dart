import 'package:aliyamart/provider/favourite_provider.dart';
import 'package:aliyamart/views/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class FavouriteItemsScreen extends ConsumerStatefulWidget {
  const FavouriteItemsScreen({super.key});

  @override
  ConsumerState<FavouriteItemsScreen> createState() =>
      _FavouriteItemsScreenState();
}

class _FavouriteItemsScreenState extends ConsumerState<FavouriteItemsScreen> {
  @override
  Widget build(BuildContext context) {
    final favrtData = ref.watch(favrtProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * .20,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/icons/cartb.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 100,
              top: 50,
              child: Text(
                'My Cart',
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: badges.Badge(
                badgeContent: Text(favrtData.length.toString()),
                child: Image.asset(
                  height: 30,
                  width: 30,
                  'assets/icons/not.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: favrtData.isEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Your favourites list is empty, start adding items!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MainScreen(); // Navigate to MainScreen
                            },
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Shop Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You have ${favrtData.length} items in your favourites',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favrtData.length,
                      itemBuilder: (context, index) {
                        final favrtItem = favrtData.values.toList()[index];
                        final imageUrl = favrtItem.imageUrls.isNotEmpty
                            ? favrtItem.imageUrls[0]
                            : 'https://via.placeholder.com/100'; // Fallback placeholder image

                        return Card(
                          color: Colors.white,
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(imageUrl),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(favrtItem.productName,
                                          style: GoogleFonts.lato()),
                                      Text('\$${favrtItem.productPrice}',
                                          style: GoogleFonts.lato()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
