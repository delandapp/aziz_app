import 'dart:convert';

import 'package:easylibrary/app/components/customTextFieldPeminjaman.dart';
import 'package:easylibrary/app/data/models/response_peminjaman.dart';
import 'package:easylibrary/app/data/models/response_ulasan.dart';
import 'package:dio/dio.dart';
import 'package:easylibrary/app/modules/history/controllers/history_controller.dart';
import 'package:easylibrary/app/modules/home/controllers/home_controller.dart';
import 'package:easylibrary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easylibrary/app/data/constans/endpoint.dart';
import 'package:easylibrary/app/data/models/response_detailsbook.dart';
import 'package:easylibrary/app/data/provider/api_provider.dart';
import 'package:easylibrary/app/data/provider/storage_provider.dart';

class MyState<T1,T2> {
  T1? state1;
  T2? state2;
  // T3? state3;
  MyState({this.state1,this.state2});
}
class DetailbookController extends GetxController with StateMixin<MyState<DataBookDetails, List<DataUlasan>>> {
  //TODO: Implement DetailbookController
  final detailBuku = DataBookDetails().obs;
   late String formattedToday;
   final idPinjam = 0.obs;
   final HistoryController historyController = Get.put(HistoryController());
  late String formattedTwoWeeksLater;
  final HomeController homeController = Get.put(HomeController());
  final judulBuku = "".obs;
  final count = 0.obs;
    final loading = false.obs;
    final id = Get.parameters['idbook'];
      var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }
  @override
  void onInit() {
    super.onInit();
    getData();
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 7));

    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getData() async{
    change(null, status: RxStatus.loading());

    try {
        final bearerToken = StorageProvider.read(StorageKey.bearerToken);
        final response = await ApiProvider.instance().get('${Endpoint.book}/${id}',options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
        final responseUlasanData = await ApiProvider.instance().get('${Endpoint.ulasan}/${id}',options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
        if (response.statusCode == 200 && responseUlasanData.statusCode == 200) {
          final ResponseDetailsbook responseDetailsbook = ResponseDetailsbook.fromJson(response.data);
          final ResponseUlasan responseUlasan = ResponseUlasan.fromJson(responseUlasanData.data);
          if(responseDetailsbook.data!.deskripsi!.isEmpty ) {
            change(null, status: RxStatus.empty());
          } else {
            final newData = MyState(state1: responseDetailsbook.data, state2: responseUlasan.data);
            change(newData, status: RxStatus.success());
            detailBuku.value = responseDetailsbook.data!;
            judulBuku.value = responseDetailsbook.data!.judulBuku.toString();
          }
        } else {
          change(null, status: RxStatus.error("Gagal mengambil data"));
        }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  addKoleksiBuku() async {
    if(detailBuku.value.koleksi == true) {
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Pemberitahuan",
        "Buku ini sudah ada di koleksi",
        "Ok",
      );
      return;
    }
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id;
      final bearerToken = StorageProvider.read(StorageKey.bearerToken);

      var response = await ApiProvider.instance().post(
        Endpoint.koleksi,
        options: Options(headers: {"Authorization": "Bearer $bearerToken"}),
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBukuDialog = judulBuku.value;
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Buku berhasil disimpan",
          "Buku $judulBukuDialog berhasil disimpan di koleksi buku",
          "Oke",
        );
        getData();
        homeController.getData();
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal disimpan, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

   Future<void> showMyPinjam(final onPressed, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Form Peminjaman Buku',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListBody(
                children: <Widget>[

                  Divider(
                    height: 2,
                    color: Colors.grey.withOpacity(0.20),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextFieldPeminjaman(
                    InitialValue: detailBuku.value.judulBuku.toString(),
                    labelText: 'Judul Buku',
                    obsureText: false,
                  ),
                  CustomTextFieldPeminjaman(
                    InitialValue: detailBuku.value.penerbitBuku.toString(),
                    labelText: 'Penerbit',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: const Icon(Icons.calendar_today),
                    InitialValue: formattedToday.toString(),
                    labelText: 'Tanggal Peminjaman',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: const Icon(Icons.calendar_today),
                    InitialValue: formattedTwoWeeksLater.toString(),
                    labelText: 'Deadline Pengembalian',
                    obsureText: false,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          toggleCheckBox();
                        },
                        activeColor: const Color(0xFFFD5B35),
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan waktu peminjaman buku",
                          maxLines: 1,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(
                              color: Color(0xFFFD5B35),
                              width: 1,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                          },
                          child: Text(
                            'Batal',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFD5B35),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: const Color(0xFFFD5B35),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            if (!isChecked.value) {
                              return;
                            }
                            Navigator.pop(Get.context!, 'OK');
                            addPinjam();
                          },
                          child: Text(
                            nameButton,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  addPinjam({String? idBuku}) async {
    loading(true);
    idBuku ??= id;
    try {
      final bearerToken = StorageProvider.read(StorageKey.bearerToken);
      String data = jsonEncode({"BukuID": idBuku});
      FocusScope.of(Get.context!).unfocus();
      final response = await ApiProvider.instance().post(Endpoint.pinjam,
          data: data,
          options: Options(headers: {"Authorization": "Bearer $bearerToken"}));

      if (response.statusCode == 200) {
        final ResponsePeminjaman responsePeminjaman =
            ResponsePeminjaman.fromJson(response.data);
        if (responsePeminjaman.message.toString() == "Buku Masih Di Pinjam") {
          loading(false);
          Get.snackbar("Information", "Maaf Buku Anda Belum Anda Kembalikan",
              backgroundColor: Colors.red);
          // Get.offAllNamed(Routes.LOGIN);
          _showMyDialog(
            () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "Buku Masih Di Pinjam",
            "Ok",
          );
          return;
        }
        loading(false);
        historyController.getDataPeminjaman();
        idPinjam.value = responsePeminjaman.data!.peminjamanID!;
        Get.snackbar("Information", "Peminjaman Succes",
            backgroundColor: Colors.green);
        showSucsesPinjam();
        return;
      } else {
        Get.snackbar("Sorry", "Peminjaman Gagal", backgroundColor: Colors.red);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> showSucsesPinjam() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0XFFFFFFFF),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xFF00D193),
                    size: 200,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "BERHASIL !",
                    style: GoogleFonts.inriaSans(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF00D193),
                        fontSize: 26.0),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: Text(
                    "NOTE !",
                    style: GoogleFonts.inriaSans(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 26.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Harap segera ke Perpustakaan untuk mengambil buku beserta menyerahkan bukti laporan",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inriaSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 17.0),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  autofocus: true,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF00D193),
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                  onPressed: () {
                    Navigator.pop(Get.context!, 'OK');
                    Get.toNamed(Routes.PINJAM, parameters: {"idPinjam" : idPinjam.value.toString()});
                  },
                  child: Text(
                    "Generate laporan",
                    style: GoogleFonts.inriaSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}

 Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF03010E),
          title: Text(
            'EasyBook',
            style: GoogleFonts.inriaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFF3ED04C),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  judul,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20.0
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              autofocus: true,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF3ED04C),
                animationDuration: const Duration(milliseconds: 300),
              ),
              onPressed: onPressed,
              child: Text(
                nameButton,
                style: GoogleFonts.inriaSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

