import 'package:cloud_firestore/cloud_firestore.dart';

class VideosRepository {
  static final VideosRepository _videosRepository =
      VideosRepository._internal();

  factory VideosRepository() {
    return _videosRepository;
  }

  VideosRepository._internal();

  Future<List<Map<String, dynamic>>> getVideosBiceps() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("videosBiceps").get();

      List<Map<String, dynamic>> list = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data["id"] = doc.id;
        return data;
      }).toList();

      return list;
    } catch (e) {
      print(e);

      return [];
    }
  }
}
