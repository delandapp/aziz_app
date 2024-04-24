/// Status : 200
/// Message : "Berhasil Get Koleksi"
/// data : [{"BukuID":1,"CoverBuku":"http://127.0.0.1:8000/storage/images/coverbook/AI Masa Depan.jpeg","Judul":"AI Masa Depan","Penulis":"Deland Arjuna","Penerbit":"Athila davin","TahunTerbit":"2009","JumlahHalaman":"214","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Kategori":["Teknologi","Pendidikan"]},{"BukuID":2,"CoverBuku":"http://127.0.0.1:8000/storage/images/coverbook/Modern AI.jpeg","Judul":"Modern AI","Penulis":"Yogha Irgi","Penerbit":"Athila davin","TahunTerbit":"2009","JumlahHalaman":"214","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0,"Kategori":["Teknologi","Pendidikan"]}]

class ResponseKoleksi {
  ResponseKoleksi({
      this.status, 
      this.message, 
      this.data,});

  ResponseKoleksi.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataKoleksi.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataKoleksi>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BukuID : 1
/// CoverBuku : "http://127.0.0.1:8000/storage/images/coverbook/AI Masa Depan.jpeg"
/// Judul : "AI Masa Depan"
/// Penulis : "Deland Arjuna"
/// Penerbit : "Athila davin"
/// TahunTerbit : "2009"
/// JumlahHalaman : "214"
/// Rating : 5
/// Total_ulasan : 1
/// JumlahRating : 5
/// JumlahPeminjam : 0
/// Kategori : ["Teknologi","Pendidikan"]

class DataKoleksi {
  DataKoleksi({
      this.bukuID, 
      this.coverBuku, 
      this.judul, 
      this.penulis, 
      this.penerbit, 
      this.tahunTerbit, 
      this.jumlahHalaman, 
      this.rating, 
      this.totalUlasan, 
      this.jumlahRating, 
      this.jumlahPeminjam, 
      this.kategori,});

  DataKoleksi.fromJson(dynamic json) {
    bukuID = json['BukuID'];
    coverBuku = json['CoverBuku'];
    judul = json['Judul'];
    penulis = json['Penulis'];
    penerbit = json['Penerbit'];
    tahunTerbit = json['TahunTerbit'];
    jumlahHalaman = json['JumlahHalaman'];
    rating = json['Rating'];
    totalUlasan = json['Total_ulasan'];
    jumlahRating = json['JumlahRating'];
    jumlahPeminjam = json['JumlahPeminjam'];
    kategori = json['Kategori'] != null ? json['Kategori'].cast<String>() : [];
  }
  int? bukuID;
  String? coverBuku;
  String? judul;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? jumlahHalaman;
  int? rating;
  int? totalUlasan;
  int? jumlahRating;
  int? jumlahPeminjam;
  List<String>? kategori;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BukuID'] = bukuID;
    map['CoverBuku'] = coverBuku;
    map['Judul'] = judul;
    map['Penulis'] = penulis;
    map['Penerbit'] = penerbit;
    map['TahunTerbit'] = tahunTerbit;
    map['JumlahHalaman'] = jumlahHalaman;
    map['Rating'] = rating;
    map['Total_ulasan'] = totalUlasan;
    map['JumlahRating'] = jumlahRating;
    map['JumlahPeminjam'] = jumlahPeminjam;
    map['Kategori'] = kategori;
    return map;
  }

}