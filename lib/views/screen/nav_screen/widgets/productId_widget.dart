import 'package:aliyamart/views/screen/innner_screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductidWidget extends StatelessWidget {
  final dynamic productData;

  const ProductidWidget({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetails(
              productData: productData,
            );
          },
        ));
      },
      child: Container(
        height: 245,
        width: 145,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 13,
              top: 10,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent.shade100,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 15,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amberAccent.shade200,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 15,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      productData['imageUrls'][0],
                    ),
                  ),
                ),
              ),
            ),

            // Positioned(
            //   left: 20,
            //   top: 18,
            //   child: CachedNetworkImage(height: 80,
            //       width: 80,
            //       imageUrl: productData['imageUrls'][0]),
            // ),

            Positioned(
              right: 15,
              top: 12,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade300,
                ),
              ),
            ),
            Positioned(
              right: 6,
              top: 4,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 130,
              child: Text(productData['productName'],
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            Positioned(
              left: 10,
              top: 160,
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.amber,
                  ),
                  Text(
                    '4.9 ',
                    style: GoogleFonts.lato(color: Colors.grey),
                  ),
                  Text(
                    '| >500 Sold',
                    style: GoogleFonts.lato(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 180,
              child: Text(productData['category'],
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),

            Positioned(
              left: 10,
              top: 200,
              child: Text('\$${productData['productPrice']}',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),
            Positioned(
              left: 60,
              top: 200,
              child: Text('\$${productData['discount']}',
                  style: const TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                  )),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10)),
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 5,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_checkout_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
