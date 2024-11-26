import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/repo/urunlerdao_repository.dart';

class UrunDetaySayfaCubit extends Cubit<void> {
  UrunDetaySayfaCubit() :super(0);

  var urepo = UrunlerDaoRepository();

  Future<void> sepeteEkle(String ad, String resim, String kategori, int fiyat,
      String marka, int siparisAdeti) async {
    await urepo.sepeteEkle(ad, resim, kategori, fiyat, marka, siparisAdeti);

  }
}