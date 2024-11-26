import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler/ui/cubit/anasayfa_cubit.dart';
import 'package:urunler/ui/cubit/urun_detay_sayfa_cubit.dart';
import 'package:urunler/ui/cubit/urun_sepet_sayfa_cubit.dart';
import 'package:urunler/ui/views/anasayfa.dart';
import 'package:urunler/ui/views/animasyon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => UrunDetaySayfaCubit()),
        BlocProvider(create: (context) => UrunSepetSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  AnimationScreen(),
      ),
    );
  }
}