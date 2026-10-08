import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../PROVIDERS/app_state.dart';

import 'homepage_uniqlo.dart';
import 'cart_page.dart';

import 'wishlist_page.dart';

import 'daftarprodukpage_uniqlo.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UniqloHomePage(),
    const ProductListPage(),
    const WishlistPage(),
    const CartPage(),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Keanggotaan Uniqlo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('${appState.wishlist.length}'),
              isLabelVisible: appState.wishlist.isNotEmpty,
              child: const Icon(Icons.favorite_border),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('${appState.cart.length}'),
              isLabelVisible: appState.cart.isNotEmpty,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            label: 'Keranjang',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Keanggotaan',
          ),
        ],
      ),
    );
  }
}
