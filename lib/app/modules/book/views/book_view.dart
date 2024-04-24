import 'package:easylibrary/app/components/bookSearch.dart';
import 'package:easylibrary/app/components/buildSection.dart';
import 'package:easylibrary/app/components/koleksiBook.dart';
import 'package:easylibrary/app/components/myInput.dart';
import 'package:easylibrary/app/components/navProfil.dart';
import 'package:easylibrary/app/components/searchInput.dart';
import 'package:easylibrary/app/data/models/response_buku.dart';
import 'package:easylibrary/app/data/models/response_koleksi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightFullBody =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final widthFullBody = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFFFF), Color(0xFFA6F6FF)])),
        // width: widthFullBody,
        height: heightFullBody,
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const navProfil(title: "Buku"),
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
                      : SearchBookBuild(heightFullBody: heightFullBody, widthFullBody: widthFullBody,state: state!.state2!, state1: state.state1!,),
                ),
                            
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBookBuild extends StatelessWidget {
  const SearchBookBuild({
    super.key,
    required this.heightFullBody,
    required this.widthFullBody,
    required this.state,
    required this.state1,
  });

  final double heightFullBody;
  final double widthFullBody;
  final List<DataBuku> state;
  final List<DataKoleksi> state1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: heightFullBody * 0.02,
        ),
        KoleksiBook(dataKoleksi: state1),
        SizedBox(
          height: heightFullBody * 0.02,
        ),
        Column(
          children: state.map((data) {
            return SizedBox(
              width: widthFullBody,
              height: heightFullBody * 0.3,
              child: buildSection(data: data),
            );
          }).toList(),
        ),
      ],
    );
  }
}
