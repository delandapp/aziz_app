import 'package:easylibrary/app/data/models/response_bookSearch.dart';
import 'package:flutter/material.dart';
import 'package:easylibrary/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookSearch extends StatelessWidget {
  const BookSearch({
    super.key,
    required this.data,
  });

  final List<DataBukuSearch> data;
  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xff000000);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.5,
              // mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.toNamed(Routes.DETAILBOOK,
                  parameters: {"idbook": data[index].bukuID.toString()}),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(Get.context!).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10)),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Gambar di sebelah kiri
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            // Lebar gambar 40% dari layar
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 2 / 2,
                                child: Image.network(
                                  data[index].coverBuku.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].judul!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF121212),
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                data[index].deskripsi!,
                                style: GoogleFonts.plusJakartaSans(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                ),
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Penulis : ${data[index].penulis!}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
