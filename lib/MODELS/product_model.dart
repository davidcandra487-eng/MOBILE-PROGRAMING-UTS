import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String audience;
  final String description;
  final List<String> availableSizes;
  final List<Color> availableColors;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.audience,
    required this.description,
    required this.availableSizes,
    required this.availableColors,
  });

  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    )}';
  }
}

class CartItem {
  final Product product;
  final String selectedSize;
  final Color selectedColor;

  int quantity;
  bool isChecked;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
    this.isChecked = true,
  });
}