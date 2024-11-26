import 'package:urunler/data/entity/urunler.dart';

class UrunlerSepeti {
  Urunler urunler;
  int sepetId;
  int siparisAdedi;
  String kullaniciAdi;

  UrunlerSepeti({
    required this.urunler,
    required this.sepetId,
    required this.siparisAdedi,
    required this.kullaniciAdi
  });

  factory UrunlerSepeti.fromJson(Map<String, dynamic> json) {
    return UrunlerSepeti(
    urunler: Urunler(
      id: json['id'] ?? 0,
      ad: json['ad'] ?? '',
      resim: json['resim'] ?? '',
      kategori: json['kategori'] ?? '',
      fiyat: json['fiyat'] ?? 0,
      marka: json['marka'] ?? '',
    ),
      siparisAdedi: json['siparisAdeti'] ?? 1,
      kullaniciAdi: json['kullaniciAdi'] ?? "Mevlüt",
      sepetId: json['sepetId'] ?? 0,
    );
  }



}