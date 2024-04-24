import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/pinjam_controller.dart';

class PinjamView extends GetView<PinjamController> {
  const PinjamView({Key? key}) : super(key: key);
  @override
   Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: kontenData(width, height),
          ),
        )
    );
  }

  Widget kontenData(double width, double height){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Obx((){
          String asalHalaman = Get.parameters['asalHalaman'].toString();

          if (controller.detailPeminjaman.value == null){
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2F88FF)),
                ),
              ),
            );
          }else{
            var dataPeminjaman = controller.detailPeminjaman.value;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 30, left: 30, right: 30),
                        child: Column(
                          children: [

                            const SizedBox(
                              height: 10,
                            ),

                            FittedBox(
                              child: Text(
                                'Peminjaman Buku Berhasil',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 20.0
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * 0.010,
                            ),

                            Divider(
                              color: Colors.black.withOpacity(0.10),
                              thickness: 1,
                            ),

                            SizedBox(
                              height: height * 0.025,
                            ),

                            FittedBox(
                              child: Text(
                                dataPeminjaman!.kodePeminjaman.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF2F88FF),
                                    fontSize: 36.0
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * 0.040,
                            ),

                            kontenBuktiPeminjaman(
                                'Nama Peminjam', dataPeminjaman.username.toString()
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            kontenBuktiPeminjaman(
                                'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            kontenBuktiPeminjaman(
                                'Deadline Peminjaman', dataPeminjaman.deadline.toString()
                            ),

                            SizedBox(
                              height: height * 0.040,
                            ),

                            Divider(
                              color: Colors.black.withOpacity(0.10),
                              thickness: 1,
                            ),

                            SizedBox(
                              height: height * 0.030,
                            ),

                            kontenBuktiPeminjaman(
                                'Nama Buku', dataPeminjaman.judulBuku.toString()
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            kontenBuktiPeminjaman(
                                'Penulis Buku', dataPeminjaman.penulisBuku.toString()
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            kontenBuktiPeminjaman(
                                'Tahun Terbit', dataPeminjaman.tahunBuku.toString()
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: FractionalTranslation(
                        translation: const Offset(0.01, -0.50),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: SvgPicture.asset(
                            'assets/images/icon_check.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: height * 0.050,
                ),

                kontenButton(
                        (){
                      String asalHalaman = Get.parameters['asalHalaman'].toString();
                      if (asalHalaman == 'detailBuku') {
                        Get.offAllNamed(Routes.DASHBOARD); // Navigasi ke halaman detail buku
                      } else if (asalHalaman == 'historyPeminjaman') {
                        Get.back();
                      }
                    },
                    Text(
                      asalHalaman == 'detailBuku' ? 'Kembali ke Beranda' : 'Kembali',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    10.0,
                    const Color(0xFF2F88FF)
                ),
              ],
            );
          }
        })
    );
  }

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16.0
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
      final double radius,
      final Color buttonColor,){
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }

}
