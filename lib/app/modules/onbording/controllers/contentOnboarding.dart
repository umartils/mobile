class UnbordingContent {
  String title;
  String description;
  String image;

  UnbordingContent(
      {required this.title, required this.description, required this.image});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: "Real-Time Absensi",
      description:
          "Catat kehadiran otomatis dan simpan data absensi real-time dengan mudah",
      image: "asset/images/waktu.png"),
  UnbordingContent(
      title: "Absensi dengan Foto Selfie",
      description:
          "Teknologi pengenalahan wajah untuk memastikan kehadiran tercatat dengan akurat",
      image: "asset/images/selfie.png"),
  UnbordingContent(
      title: "Deteksi Lokasi untuk Verifikasi Absensi",
      description:
          "Deteksi Lokasi untuk memastikan absensi dilakukan hanya di lokasi yang sesuai dengan kebijakan Sekolah",
      image: "asset/images/lokasi.png"),
];
