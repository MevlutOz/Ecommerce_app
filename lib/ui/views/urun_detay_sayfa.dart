import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/data/entity/urunler.dart';
import 'package:urunler/main.dart';
import 'package:urunler/ui/cubit/urun_detay_sayfa_cubit.dart';
import 'package:urunler/ui/views/urun_sepet_sayfa.dart';

class UrunDetaySayfa extends StatefulWidget {

  Urunler urunler;


  UrunDetaySayfa({required this.urunler});

  @override
  State<UrunDetaySayfa> createState() => _UrunDetaySayfaState();
}

class _UrunDetaySayfaState extends State<UrunDetaySayfa> {
  int sayac = 1;
  void sayacArttir() {
    setState(() {
      sayac++;
    });
  }
  void sayacAzalt() {
    setState(() {
      sayac--;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.urunler.ad),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UrunSepetSayfa(),
                      ));
                },
                icon: const Icon(Icons.shopping_bag_outlined)),
          )
        ],),

      body: BlocBuilder<UrunDetaySayfaCubit, void> (
        builder: (context, state) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "http://kasimadalan.pe.hu/urunler/resimler/${widget.urunler.resim}",
                  height: 400,
                  width: MediaQuery.of(context).size.width - 32,
                  fit: BoxFit.contain,
                ),
                Text(
                  widget.urunler.ad,
                  style: const TextStyle(
                      fontSize: 25,),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.urunler.marka,
                  style: TextStyle(
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kategori: ${widget.urunler.kategori}",
                      style: TextStyle(
                          fontSize: 16, ),
                    ),
                    const SizedBox(width: 20),
                    Text("₺${widget.urunler.fiyat}",),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      sayacAzalt();
                    }, icon: Icon(Icons.remove_circle, color: Colors.blue,)),
                    Text("$sayac"),
                    IconButton(onPressed: (){
                      sayacArttir();
                    }, icon: Icon(Icons.add_circle, color: Colors.blue,))
                  ],
                ),
                ElevatedButton(onPressed: () {
                  context.read<UrunDetaySayfaCubit>().sepeteEkle(
                    widget.urunler.ad,
                    widget.urunler.resim,
                    widget.urunler.kategori,
                    widget.urunler.fiyat,
                    widget.urunler.marka,
                    sayac,
                  );
                }, child: Text("Sepete Ekle")),
              ],
            ),
          );
        },

      ),
    );
  }
}

