import 'package:aliyamart/provider/cart_provider.dart';
import 'package:aliyamart/views/screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref
        .read(cartProvider.notifier)
        .calculateTotalAmount(); // Watching the cart data

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
                badgeContent: Text(cartData.length.toString()),
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
      body: cartData.isEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
              child: SingleChildScrollView(
                // Wrapping the empty cart message
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Your cart is empty, shop now!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20), // Space between text and button
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
              // Wrapping the cart items
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You have ${cartData.length} items in your cart',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                      itemCount: cartData.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartData.values.toList()[index];
                        final imageUrl = cartItem.imageUrls.isNotEmpty
                            ? cartItem.imageUrls[0]
                            : null;

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
                                      child: Image.network(cartItem
                                          .imageUrls) // Fallback placeholder image
                                      ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(cartItem.productName),
                                      Text(cartItem.productSize),
                                      Text(cartItem.productPrice
                                          .toRadixString(3)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                            color: Colors.blue),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _cartProvider.decrementItem(
                                                    cartItem.productID);
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.minus,
                                              ),
                                              color: Colors.white,
                                            ),
                                            Text(cartItem.quantity.toString()),
                                            IconButton(
                                              onPressed: () {
                                                _cartProvider.incrementItem(
                                                    cartItem.productID);
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.plus,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                            onPressed: () {
                                              _cartProvider.removeItem(
                                                  cartItem.productID);
                                            },
                                            icon: const Icon(Icons.delete)),
                                      )
                                    ],
                                  )
                                  // Add additional details for each cart item here
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
      bottomNavigationBar: Container(
        height: 79,
        width: double
            .infinity, // To ensure it stretches to the width of the screen
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.black45),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Adds some padding to the sides
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Aligns content to the left and right
            children: [
              Align(
                alignment: Alignment.centerLeft, // Aligns the text to the left
                child: Text(
                  'Total Amount:',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment:
                    Alignment.centerRight, // Aligns the total to the right
                child: Text(
                  totalAmount.toStringAsFixed(
                      2), // Example total amount (replace with dynamic value)
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
