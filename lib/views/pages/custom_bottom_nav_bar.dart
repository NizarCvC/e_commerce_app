import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/views/pages/favorite_page.dart';
import 'package:e_commerce_app/views/pages/homepage.dart';
import 'package:e_commerce_app/views/pages/cart_page.dart';
import 'package:e_commerce_app/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int tabViewIndex = 0;

  List<PersistentTabConfig> _buildTaps(BuildContext context) {
    return [
      PersistentTabConfig(
        screen: Homepage(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: Icon(Icons.home),
          title: 'Home',
          textStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      PersistentTabConfig(
        screen: CartPage(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: Icon(Icons.shopping_cart),
          title: 'Cart',
          textStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      PersistentTabConfig(
        screen: FavoritePage(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: Icon(Icons.favorite),
          title: 'Favorite',
          textStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      PersistentTabConfig(
        screen: ProfilePage(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: Icon(Icons.person),
          title: 'Profile',
          textStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
    ];
  }

  AppBar _buildAppBarItems(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromARGB(255, 8, 44, 73),
            foregroundImage: CachedNetworkImageProvider(
              'https://t4.ftcdn.net/jpg/04/31/64/75/360_F_431647519_usrbQ8Z983hTYe8zgA7t1XVc5fEtqcpa.jpg',
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Nizar Omar', style: Theme.of(context).textTheme.titleLarge),
              Text(
                'Let\'s go shopping',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (tabViewIndex == 0) ...[
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            ],
          ),
        ] else ...[
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined)),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBarItems(size, context),
      body: PersistentTabView(
        tabs: _buildTaps(context),
        onTabChanged: (value) => setState(() => tabViewIndex = value),
        stateManagement: false,
        navBarBuilder: (navBarConfig) =>
            Style9BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
