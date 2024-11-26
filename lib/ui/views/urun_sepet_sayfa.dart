import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/entity/urunler_sepeti.dart';
import 'package:urunler/data/repo/urunlerdao_repository.dart';
import 'package:urunler/ui/cubit/urun_sepet_sayfa_cubit.dart';

class UrunSepetSayfa extends StatefulWidget {
  const UrunSepetSayfa({super.key});

  @override
  State<UrunSepetSayfa> createState() => _UrunSepetSayfaState();
}

class _UrunSepetSayfaState extends State<UrunSepetSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<UrunSepetSayfaCubit>().sepetListele();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCardProduct(),
          ),
          bottom(),
        ],
      ),
    );
  }

  BlocBuilder<UrunSepetSayfaCubit, List<UrunlerSepeti>> _buildCardProduct() {
    return BlocBuilder<UrunSepetSayfaCubit, List<UrunlerSepeti>>(
      builder: (context, cartProducts) {
        return cartProducts.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sepetinizde Ürün Bulunmamaktadır!"),
            ],
          ),
        )
            : ListView.builder(
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            var cartProduct = cartProducts[index];
            var product = cartProduct.urunler;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Image.network(
                      "http://kasimadalan.pe.hu/urunler/resimler/${product.resim}",
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.ad,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Adet: ${cartProduct.siparisAdedi}"),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Ürün Sil"),
                                content: const Text(
                                    "Bu ürünü sepetinizden silmek istediğinizden emin misiniz?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Hayır"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<UrunSepetSayfaCubit>().urunSil("Mevlüt", cartProduct.sepetId);
                                      Navigator.pop(context);
                                      },
                                    child: const Text("Evet"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        Text(
                          "Fiyat: ${cartProduct.urunler.fiyat * cartProduct.siparisAdedi} ₺",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  BlocBuilder<UrunSepetSayfaCubit, List<UrunlerSepeti>> bottom() {
    return BlocBuilder<UrunSepetSayfaCubit, List<UrunlerSepeti>>(
      builder: (context, cartProducts) {
        int toplam = context.read<UrunSepetSayfaCubit>().toplamFiyat(cartProducts);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Toplam: $toplam ₺",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: cartProducts.isEmpty
                    ? null // Sepet boşsa buton devre dışı
                    : () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Sepeti Onayla"),
                      content: const Text(
                          "Sepetinizi onaylamak istediğinizden emin misiniz?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Hayır"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Sepet Onaylandı!"),
                              ),
                            );
                          },
                          child: const Text("Evet"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Sepeti Onayla",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
