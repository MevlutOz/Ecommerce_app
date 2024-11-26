import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:urunler/data/entity/urunler.dart';
import 'package:http/http.dart' as http;
import 'package:urunler/data/entity/urunler_cevap.dart';
import 'package:urunler/data/entity/urunler_sepeti.dart';

class UrunlerDaoRepository {

  List<Urunler> parseUrunlerCevap(String cevap) {
    return UrunlerCevap.fromJson(json.decode(cevap)).urunler;
  }


  Future<void> sepeteEkle(String ad, String resim, String kategori, int fiyat,
      String marka, int siparisAdeti) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var kullaniciAdi = "Mevlüt";
    var veri = {
      "ad": ad,
      "resim": resim,
      "kategori": kategori,
      "fiyat": fiyat,
      "marka": marka,
      "siparisAdeti": siparisAdeti,
      "kullaniciAdi": kullaniciAdi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    sepetListele();
    print("ürün eklendi");
  }

  Future<List<Urunler>> urunleriYukle() async{
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";
    var cevap = await Dio().get(url);
    return parseUrunlerCevap(cevap.data.toString());
  }

  Future<List<UrunlerSepeti>> sepetListele() async{
    /*var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    String? kullaniciAdi = "Mevlüt";
    var veri = {"kullaniciAdi": kullaniciAdi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    var jsonResult = json.decode(cevap.data.toString());

    var sepetListesi = (jsonResult['urunler_sepeti'] as List?)
        ?.map((item) => UrunlerSepeti.fromJson(item)).toList() ?? [];

    if(sepetListesi.isEmpty) {
      print("Sepete ürün ekleyiniz");
      return[];
    }

    print("ürünler listelendi");
    return sepetListesi;*/

    var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    String? kullaniciAdi = "Mevlüt";
    var veri = {"kullaniciAdi": kullaniciAdi};
    try {
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));
      var jsonResult = json.decode(cevap.data.toString());

      var sepetListesi = (jsonResult['urunler_sepeti'] as List?)
          ?.map((item) => UrunlerSepeti.fromJson(item))
          .toList() ??
          [];

      return sepetListesi;
    } catch (e) {
      print("$e");
      return [];
    }


  }

  Future<void> urunSil(String kullaniciAdi,int sepetId) async{
    var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
    var kullaniciAdi = "Mevlüt";
    var veri = {"kullaniciAdi": kullaniciAdi, "sepetId": sepetId};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("ürün sil");
  }






}