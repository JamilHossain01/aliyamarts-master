import 'package:aliyamart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetails extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetails({super.key, required this.productData});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  String selectedSize = ''; // State variable for selected size

  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData['productName'],
          style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              badgeContent: const Text('1'), // Replace with actual cart count
              child: IconButton(
                onPressed: () {}, // Navigate to the cart page
                icon: const Icon(Icons.favorite_border),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Center(
              child: SizedBox(
                height: 260,
                width: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 50,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.shade200,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 65,
                      top: 8,
                      child: Container(
                        height: 230,
                        width: 170,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade100,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 250,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.productData['imageUrls'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Image.network(
                                    widget.productData['imageUrls'][index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Name and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.productData['productName'],
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${widget.productData['productPrice']}',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Product Category
            Text(
              widget.productData['category'],
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            // Product Sizes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Size:'),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['productSize'].length,
                    itemBuilder: (context, index) {
                      String size = widget.productData['productSize'][index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size; // Update selected size
                            });
                          },
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedSize == size
                                  ? Colors.blue
                                  : Colors.blueGrey, // Change color if selected
                            ),
                            child: Center(
                              child: Text(
                                size,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // About Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.productData['description'],
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Add to Cart Button
            Center(
              child: SizedBox(
                height: 50,
                width: 300,
                child: GestureDetector(
                  onTap: () {
                    if (selectedSize.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        // ignore: prefer_const_constructors
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: const Text(
                            'Please select a size before adding to cart.',
                          ),
                        ),
                      );
                      return; // Exit if no size is selected
                    }

                    _cartProvider.addProductToCart(
                      productName: widget.productData['productName'],
                      productPrice: widget.productData['productPrice'],
                      productSize: selectedSize, // Use selected size


                      quantity: 4, // Default quantity is 1
                      description: widget.productData['description'],
                      category: widget.productData['category'],
                      imageUrls: widget.productData['imageUrls']
                          [0], // First image
                      inStock: widget.productData['quantity'],
                      discount: widget.productData['discount'],
                      productId: widget.productData['productId'],
                    );setState(() {
                      selectedSize = '';
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey,
                        content: Text(
                          '${widget.productData["productName"]} added to cart',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Text(
                      "Add to Cart",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
