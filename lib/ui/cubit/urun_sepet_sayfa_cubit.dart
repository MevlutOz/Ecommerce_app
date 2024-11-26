import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/entity/urunler.dart';
import 'package:urunler/data/entity/urunler_sepeti.dart';
import 'package:urunler/data/repo/urunlerdao_repository.dart';

class UrunSepetSayfaCubit extends Cubit<List<UrunlerSepeti>> {
  UrunSepetSayfaCubit() : super(<UrunlerSepeti>[]);

  var urepo = UrunlerDaoRepository();

  Future<void> sepetListele() async {
    var liste = await urepo.sepetListele();
    print(liste);
    print("sepet listelendi");
    emit(liste);
  }

  Future<void> urunSil(String kullaniciAdi, int sepetId) async {
    await urepo.urunSil(kullaniciAdi, sepetId);
    await sepetListele();
  }

  int toplamFiyat(List<UrunlerSepeti> urunlerSepeti) {
    int toplam = 0;
    for (var urun in urunlerSepeti) {
      toplam +=  urun.urunler.fiyat * urun.siparisAdedi;
    }
    return toplam;
  }

}