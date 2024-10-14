import 'package:aliyamart/views/screen/nav_screen/widgets/productId_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendProductWidgets extends StatelessWidget {
  RecommendProductWidgets({super.key});

  // Stream to listen to the Firestore 'products' collection
  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          // Error handling
          return const Center(
            child: Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display loading indicator while waiting for data
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Render product list when data is available
        return SizedBox(
          height: 250,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length, // Handling null safety
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
              // Pass productData to the ProductidWidget
              return ProductidWidget(productData: productData, );
            },
          ),
        );
      },
    );
  }
}
