import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/entity/urunler.dart';
import 'package:urunler/data/repo/urunlerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Urunler>> {
  AnasayfaCubit() : super(<Urunler>[]);

  var urepo = UrunlerDaoRepository();

  Future<void> urunleriYukle() async{
    var liste = await urepo.urunleriYukle();
    emit(liste);
  }
}