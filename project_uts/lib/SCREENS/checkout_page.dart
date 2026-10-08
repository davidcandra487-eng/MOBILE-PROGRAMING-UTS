import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../PROVIDERS/app_state.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'Virtual Account BCA';

  String _formatRupiah(num number) {
    String str = number.round().toString();
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return 'Rp ${str.replaceAllMapped(reg, mathFunc)}';
  }

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'Virtual Account BCA',
      'name': 'Virtual Account BCA',
      'icon': Icons.account_balance,
      'category': 'Transfer Bank',
    },
    {
      'id': 'Mandiri Virtual Account',
      'name': 'Virtual Account Mandiri',
      'icon': Icons.account_balance,
      'category': 'Transfer Bank',
    },
    {
      'id': 'QRIS / GoPay / OVO',
      'name': 'QRIS / E-Wallet (GoPay, OVO, ShopeePay)',
      'icon': Icons.qr_code_scanner,
      'category': 'E-Wallet & QRIS',
    },
    {
      'id': 'Kartu Kredit / Debit',
      'name': 'Kartu Kredit / Debit (Visa/Mastercard)',
      'icon': Icons.credit_card,
      'category': 'Kartu Kredit',
    },
    {
      'id': 'COD (Bayar di Tempat)',
      'name': 'COD (Bayar di Tempat)',
      'icon': Icons.payments_outlined,
      'category': 'Tunai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final items = appState.checkedCartItems;
    final subtotal = appState.selectedCartTotal;
    const shippingFee = 15000.0;
    final totalAmount = subtotal > 0 ? subtotal + shippingFee : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text(
          'CHECKOUT & PEMBAYARAN',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: items.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 12),
            const Text('Tidak ada produk yang dipilih untuk dibayar'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Keranjang'),
            ),
          ],
        ),
      )
          : SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alamat Pengiriman
                  _buildSectionCard(
                    title: 'Alamat Pengiriman',
                    icon: Icons.location_on_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mahasiswa Untar | (+62) 812-3456-7890',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jl. Let. Jend. S. Parman No.1, Gedung R Lantai XI, Jakarta Barat 11440',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ringkasan Pesanan Produk
                  _buildSectionCard(
                    title: 'Ringkasan Pesanan (${items.length} Item)',
                    icon: Icons.shopping_bag_outlined,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                item.product.image,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Ukuran: ${item.selectedSize} | Qty: ${item.quantity}',
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.product.formattedPrice,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Pilihan Metode Pembayaran
                  _buildSectionCard(
                    title: 'Metode Pembayaran',
                    icon: Icons.payment,
                    child: Column(
                      children: _paymentMethods.map((method) {
                        final isSelected = _selectedPaymentMethod == method['id'];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? const Color(0xFFEC1C24) : Colors.grey.shade300,
                              width: isSelected ? 1.5 : 1,
                            ),
                            color: isSelected ? const Color(0xFFFFF5F5) : Colors.white,
                          ),
                          child: RadioListTile<String>(
                            value: method['id'] as String,
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedPaymentMethod = value;
                                });
                              }
                            },
                            activeColor: const Color(0xFFEC1C24),
                            secondary: Icon(method['icon'] as IconData, color: isSelected ? const Color(0xFFEC1C24) : Colors.black87),
                            title: Text(
                              method['name'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            dense: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ringkasan Rincian Pembayaran
                  _buildSectionCard(
                    title: 'Rincian Pembayaran',
                    icon: Icons.receipt_long_outlined,
                    child: Column(
                      children: [
                        _buildCostRow('Subtotal Produk', _formatRupiah(subtotal)),
                        const SizedBox(height: 6),
                        _buildCostRow('Biaya Pengiriman', _formatRupiah(shippingFee)),
                        const Divider(height: 20),
                        _buildCostRow(
                          'Total Pembayaran',
                          _formatRupiah(totalAmount),
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol Bayar Sekarang
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC1C24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        _showPaymentSuccessDialog(context, appState, totalAmount);
                      },
                      child: const Text(
                        'BAYAR SEKARANG',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFFEC1C24)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const Divider(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 13 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFFEC1C24) : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Popup Status Pembayaran Berhasil
  void _showPaymentSuccessDialog(
      BuildContext context, AppState appState, double totalAmount) {
    final orderId = 'UNQ-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Terima kasih telah berbelanja di Uniqlo.',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildDialogRow('No. Pesanan', orderId),
                      const SizedBox(height: 6),
                      _buildDialogRow('Metode', _selectedPaymentMethod),
                      const SizedBox(height: 6),
                      _buildDialogRow('Total Bayar', _formatRupiah(totalAmount)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC1C24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      appState.clearCheckedCart();
                      Navigator.of(context).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('KEMBALI KE BERANDA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}