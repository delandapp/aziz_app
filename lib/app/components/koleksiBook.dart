import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easylibrary/app/data/models/response_koleksi.dart';
import 'package:get/get.dart';
import 'package:easylibrary/app/routes/app_pages.dart';

class KoleksiBook extends StatelessWidget {
  const KoleksiBook({
    super.key,
    required this.dataKoleksi,
  });

  final List<DataKoleksi> dataKoleksi;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "daftar favorit",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 17.0,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.18,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: dataKoleksi
                    .map((e) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: GestureDetector(
                            onTap: () => Get.toNamed(Routes.DETAILBOOK, parameters: {"idbook" : e.bukuID.toString()}),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      e.coverBuku.toString(),
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width *
                                          0.24,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.26,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    e.judul.toString(),
                                    style: TextStyle(
                                      height: 1.2,
                                      fontWeight: FontWeight.w900,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontSize: 12.0,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
