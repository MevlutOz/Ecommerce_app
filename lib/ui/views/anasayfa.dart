import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/entity/urunler.dart';
import 'package:urunler/ui/views/urun_detay_sayfa.dart';
import 'package:urunler/ui/views/urun_sepet_sayfa.dart';

import '../cubit/anasayfa_cubit.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().urunleriYukle();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Merhaba', style: TextStyle(color: Colors.white)),
            Row(
              children: [
                const Text('Sepetim', style: TextStyle(color: Colors.white)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UrunSepetSayfa(),
                          ));
                    },
                    icon: const Icon(Icons.shopping_bag_outlined)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<AnasayfaCubit, List<Urunler>>(
          builder: (context, urunlerListesi) {
            if(urunlerListesi.isNotEmpty) {
              return GridView.builder(
                  itemCount: urunlerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1/1.25),
                  itemBuilder: (context, indeks) {
                    var urunler = urunlerListesi[indeks];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UrunDetaySayfa(urunler: urunler,)));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.network("http://kasimadalan.pe.hu/urunler/resimler/${urunler.resim}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${urunler.ad} \n ${urunler.fiyat} TL", style: const TextStyle(fontSize: 16),),
                                Column(
                                  children: [
                                   IconButton(onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => UrunDetaySayfa(urunler: urunler,)));
                                   }, icon: Icon(Icons.add_circle, color: Colors.blue,))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
              );
            }
            else
              return Center();
          }),
    );
  }
}
