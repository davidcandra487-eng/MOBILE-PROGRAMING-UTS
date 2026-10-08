import 'dart:async';
import 'package:flutter/material.dart';

import '../MODELS/product_model.dart';

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

class AppState extends ChangeNotifier {
  // DAFTAR TOTAL 18 PRODUK DENGAN GAMBAR INTERNET AKTIF
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'AIRism Cotton T-Shirt',
      price: 199000,
      image:
      'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=900',
      category: 'T-Shirts',
      audience: 'Men',
      description:
      'T-shirt bergaya clean dengan material yang terasa lembut dan nyaman untuk aktivitas harian.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.white,
        Colors.black,
        Colors.blueGrey,
        Colors.grey,
      ],
    ),

    Product(
      id: '2',
      name: 'Extra Fine Cotton Shirt',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?q=80&w=900',
      category: 'Shirts',
      audience: 'Men',
      description:
      'Kemeja katun dengan tampilan rapi dan mudah dipadukan untuk gaya kasual maupun smart casual.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.white,
        Colors.blue,
        Colors.black,
      ],
    ),

    Product(
      id: '3',
      name: 'Parka UV Protection',
      price: 499000,
      image:
      'https://images.unsplash.com/photo-1548883354-7622d03aca27?q=80&w=900',
      category: 'Outerwear',
      audience: 'Men',
      description:
      'Jaket ringan untuk aktivitas luar ruang dengan siluet praktis dan mudah dilipat.',
      availableSizes: ['M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.white,
        Colors.blue,
      ],
    ),

    Product(
      id: '4',
      name: 'Celana Chino Slim Fit',
      price: 499000,
      image:
      'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?q=80&w=900',
      category: 'Pants',
      audience: 'Men',
      description:
      'Celana chino dengan potongan slim dan bahan yang fleksibel untuk digunakan sehari-hari.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.brown,
        Colors.grey,
      ],
    ),

    Product(
      id: '5',
      name: 'HEATTECH Crew Neck T-Shirt',
      price: 249000,
      image:
      'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?q=80&w=900',
      category: 'HEATTECH',
      audience: 'Men',
      description:
      'Layering shirt bergaya sederhana yang cocok digunakan saat cuaca lebih dingin.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.grey,
        Colors.white,
      ],
    ),

    // 6. AIRism Cotton Polo Pique (Gambar Rusak Diperbaiki)
    Product(
      id: '6',
      name: 'AIRism Cotton Polo Pique',
      price: 349000,
      image:
      'https://images.unsplash.com/photo-1586363104862-3a5e2ab60d99?q=80&w=900',
      category: 'Polo',
      audience: 'Men',
      description:
      'Polo dengan tampilan pique yang rapi, cocok untuk gaya santai sampai smart casual.',
      availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
      availableColors: [
        Colors.black,
        Colors.white,
        Colors.blue,
        Colors.pink,
      ],
    ),

    Product(
      id: '7',
      name: 'Ultra Light Down Jacket',
      price: 999000,
      image:
      'https://images.unsplash.com/photo-1544441893-675973e31985?q=80&w=900',
      category: 'Outerwear',
      audience: 'Men',
      description:
      'Jaket down ringan dengan desain minimalis yang mudah dipakai sebagai outer layer.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.blueGrey,
        Colors.red,
      ],
    ),

    Product(
      id: '8',
      name: 'Wide Straight Jeans',
      price: 599000,
      image:
      'https://images.unsplash.com/photo-1542272604-787c3835535d?q=80&w=900',
      category: 'Pants',
      audience: 'Women',
      description:
      'Jeans dengan potongan wide straight yang memberi ruang gerak dan siluet modern.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.blue,
        Colors.indigo,
        Colors.black,
      ],
    ),

    Product(
      id: '9',
      name: 'Rayon Blouse',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?q=80&w=900',
      category: 'Blouses',
      audience: 'Women',
      description:
      'Blouse ringan dengan tampilan clean yang cocok untuk pekerjaan maupun kegiatan santai.',
      availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.white,
        Colors.black,
        Colors.pink,
        Colors.blueGrey,
      ],
    ),

    Product(
      id: '10',
      name: 'Pleated Wide Pants',
      price: 499000,
      image:
      'https://images.unsplash.com/photo-1509631179647-0177331693ae?q=80&w=900',
      category: 'Pants',
      audience: 'Women',
      description:
      'Celana wide dengan detail pleats yang memberi kesan rapi dan tetap nyaman bergerak.',
      availableSizes: ['XS', 'S', 'M', 'L'],
      availableColors: [
        Colors.black,
        Colors.grey,
        Colors.brown,
      ],
    ),

    Product(
      id: '11',
      name: 'Mini Shoulder Bag',
      price: 299000,
      image:
      'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=900',
      category: 'Accessories',
      audience: 'LifeWear',
      description:
      'Tas bahu compact untuk membawa kebutuhan kecil saat bepergian.',
      availableSizes: ['One Size'],
      availableColors: [
        Colors.black,
        Colors.white,
        Colors.brown,
      ],
    ),

    Product(
      id: '12',
      name: 'Round Mini Shoulder Bag',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?q=80&w=900',
      category: 'Accessories',
      audience: 'LifeWear',
      description:
      'Tas mini dengan bentuk rounded yang praktis untuk aktivitas harian.',
      availableSizes: ['One Size'],
      availableColors: [
        Colors.black,
        Colors.blue,
        Colors.green,
      ],
    ),

    Product(
      id: '13',
      name: 'Kids Dry Sweatshirt',
      price: 299000,
      image:
      'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?q=80&w=900',
      category: 'Kids',
      audience: 'Kids',
      description:
      'Sweatshirt anak dengan desain sederhana dan nyaman untuk kegiatan sehari-hari.',
      availableSizes: ['110', '120', '130', '140'],
      availableColors: [
        Colors.blue,
        Colors.grey,
        Colors.pink,
      ],
    ),

    Product(
      id: '14',
      name: 'Ribbed Crew Socks',
      price: 79000,
      image:
      'https://images.unsplash.com/photo-1582966772680-860e372bb558?q=80&w=900',
      category: 'Accessories',
      audience: 'LifeWear',
      description:
      'Kaos kaki ribbed sederhana untuk melengkapi kebutuhan basic sehari-hari.',
      availableSizes: ['M', 'L'],
      availableColors: [
        Colors.white,
        Colors.black,
        Colors.grey,
      ],
    ),

    Product(
      id: '15',
      name: 'Dry Stretch Sweat Pants',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1552902865-b72c031ac5ea?q=80&w=900',
      category: 'Pants',
      audience: 'Men',
      description:
      'Celana sweat lentur dan cepat kering, ideal untuk dipakai berolahraga maupun santai.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.grey,
        Colors.white,
      ],
    ),

    Product(
      id: '16',
      name: 'Fleece Full-Zip Jacket',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1578587018452-892bacefd3f2?q=80&w=900',
      category: 'Outerwear',
      audience: 'Women',
      description:
      'Jaket fleece lembut berbahan hangat yang nyaman dipakai di cuaca dingin.',
      availableSizes: ['S', 'M', 'L'],
      availableColors: [
        Colors.pink,
        Colors.white,
        Colors.black,
      ],
    ),

    Product(
      id: '17',
      name: 'Kando Jacket Lightweight',
      price: 899000,
      image:
      'https://images.unsplash.com/photo-1507679799987-c73779587ccf?q=80&w=900',
      category: 'Outerwear',
      audience: 'Men',
      description:
      'Jas blazer modern yang sangat ringan, elastis, dan nyaman untuk acara formal maupun kerja.',
      availableSizes: ['S', 'M', 'L', 'XL'],
      availableColors: [
        Colors.black,
        Colors.yellow,
      ],
    ),

    Product(
      id: '18',
      name: 'Pocketable UV Protection Parka',
      price: 399000,
      image:
      'https://images.unsplash.com/photo-1534215754734-18e55d13e346?q=80&w=900',
      category: 'Outerwear',
      audience: 'Women',
      description:
      'Parka wanita pelindung sinar UV yang ringkas dan mudah dimasukkan ke dalam kantong.',
      availableSizes: ['S', 'M', 'L'],
      availableColors: [
        Colors.purple,
        Colors.teal,
        Colors.white,
      ],
    ),
  ];

  final List<Product> _wishlist = [];
  final List<CartItem> _cart = [];

  final List<String> _notifications = [
    'Koleksi LifeWear terbaru sudah tersedia.',
    'Temukan item AIRism dan HEATTECH untuk kebutuhan harian.',
    'Wishlist dan keranjang tersimpan selama aplikasi berjalan.',
  ];

  String _searchQuery = '';

  List<Product> get allProducts =>
      List.unmodifiable(_allProducts);

  List<Product> get wishlist =>
      List.unmodifiable(_wishlist);

  List<CartItem> get cart =>
      List.unmodifiable(_cart);

  List<String> get notifications =>
      List.unmodifiable(_notifications);

  String get searchQuery => _searchQuery;

  int get cartCount =>
      _cart.fold(0, (sum, item) => sum + item.quantity);

  List<Product> get filteredProducts {
    if (_searchQuery.trim().isEmpty) {
      return _allProducts;
    }

    final query = _searchQuery.toLowerCase().trim();

    return _allProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.audience.toLowerCase().contains(query);
    }).toList();
  }

  List<Product> productsByAudience(String audience) {
    if (audience == 'Semua') {
      return filteredProducts;
    }

    return filteredProducts
        .where((product) => product.audience == audience)
        .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  bool isWishlisted(Product product) {
    return _wishlist.any((p) => p.id == product.id);
  }

  void toggleWishlist(
      Product product,
      BuildContext context,
      ) {
    final exists = isWishlisted(product);

    if (exists) {
      _wishlist.removeWhere(
            (p) => p.id == product.id,
      );

      _showTopToast(
        context,
        '${product.name} dihapus dari wishlist',
        Colors.grey.shade900,
      );
    } else {
      _wishlist.add(product);

      _showTopToast(
        context,
        'Item ditambahkan ke wishlist',
        const Color(0xFF16A34A),
      );
    }

    notifyListeners();
  }

  void addToCart(
      Product product,
      String size,
      Color color,
      BuildContext context,
      ) {
    final index = _cart.indexWhere(
          (item) =>
      item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor.value == color.value,
    );

    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(
        CartItem(
          product: product,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }

    _showTopToast(
      context,
      'Item ditambahkan ke keranjang',
      const Color(0xFF16A34A),
    );

    notifyListeners();
  }

  void toggleCartCheck(int index) {
    _cart[index].isChecked =
    !_cart[index].isChecked;

    notifyListeners();
  }

  void updateQuantity(
      int index,
      int change,
      ) {
    _cart[index].quantity += change;

    if (_cart[index].quantity <= 0) {
      _cart.removeAt(index);
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  double get selectedCartTotal {
    double total = 0;

    for (final item in _cart) {
      if (item.isChecked) {
        total +=
            item.product.price * item.quantity;
      }
    }

    return total;
  }

  List<CartItem> get checkedCartItems {
    return _cart
        .where((item) => item.isChecked)
        .toList();
  }

  void clearCheckedCart() {
    _cart.removeWhere(
          (item) => item.isChecked,
    );

    notifyListeners();
  }

  void _showTopToast(
      BuildContext context,
      String message,
      Color color,
      ) {
    final overlay = Overlay.maybeOf(context);

    if (overlay == null) {
      return;
    }

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        final top =
            MediaQuery.of(context).padding.top + 12;

        return Positioned(
          top: top,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: _TopToast(
              message: message,
              color: color,
              onFinished: () {
                if (entry.mounted) {
                  entry.remove();
                }
              },
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
  }
}

class _TopToast extends StatefulWidget {
  final String message;
  final Color color;
  final VoidCallback onFinished;

  const _TopToast({
    required this.message,
    required this.color,
    required this.onFinished,
  });

  @override
  State<_TopToast> createState() =>
      _TopToastState();
}

class _TopToastState extends State<_TopToast> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 3),
      widget.onFinished,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}