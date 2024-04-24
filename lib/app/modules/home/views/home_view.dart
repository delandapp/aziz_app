import 'package:easylibrary/app/components/bookRekomendasi.dart';
import 'package:easylibrary/app/components/bookSearch.dart';
import 'package:easylibrary/app/components/koleksiBook.dart';
import 'package:easylibrary/app/components/myInput.dart';
import 'package:easylibrary/app/components/navProfil.dart';
import 'package:easylibrary/app/components/searchInput.dart';
import 'package:easylibrary/app/components/slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightFullBody =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final widthFullBody = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: heightFullBody,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFFFF), Color(0xFFA6F6FF)])),
        // width: widthFullBody,
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const navProfil(title: "Beranda"),
                SizedBox(
                  height: heightFullBody * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyInputSearch(
                    prefixIcon: Icons.search,
                    validator: controller.validator,
                    controller: controller,
                    controllerField: controller.search,
                    height: 10,
                    width: 10,
                    hintText: "Temukan Buku Kesukaanmu",
                    autoFocus: false,
                  ),
                ),
                Obx(
                  () => controller.searchLenght.value == 1
                      ? controller.loading.value == false ? controller.listDataBuku.isEmpty ? const Center(child: Text("Tidak Ada Buku",style: TextStyle(color: Colors.white),)) : BookSearch(data: controller.listDataBuku) : const Center(child: CircularProgressIndicator())
                      : buildHome(heightFullBody: heightFullBody,state: state,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class buildHome extends StatelessWidget {
  const buildHome({
    super.key,
    required this.heightFullBody,
    required this.state,
  });

  final double heightFullBody;
  final state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: heightFullBody * 0.04,
        ),
        const MySlider(),
        SizedBox(
          height: heightFullBody * 0.04,
        ),
        BookRekomendasi(dataBookPopular: state!.state2!),
        SizedBox(
          height: heightFullBody * 0.04,
        ),
        KoleksiBook(dataKoleksi: state.state1!),
        SizedBox(
          height: heightFullBody * 0.04,
        ),
      ],
    );
  }
}
