import 'package:aliyamart/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:aliyamart/views/screens/nav_screens/widgets/category_item.dart';
import 'package:aliyamart/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:aliyamart/views/screens/nav_screens/widgets/recommended_product_widget.dart';
import 'package:aliyamart/views/screens/nav_screens/widgets/reuseable_text_widget.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItem(),
            ReuseableTextWidget(
                title: 'Recommended For you', subtitle: 'View all'),
            RecommenedProductWidget(),
            ReuseableTextWidget(
                title: 'Popular Products', subtitle: 'View all'),
          ],
        ),
      ),
    );
  }
}
