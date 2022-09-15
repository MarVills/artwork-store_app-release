import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<Map<String, dynamic>>> loadImages({path: ""}) async {
  List<Map<String, dynamic>> files = [];
  FirebaseStorage storage = FirebaseStorage.instance;

  final ListResult result = await storage.ref().child(path).list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await (await file).getDownloadURL();
    // final FullMetadata fileMeta = await file.getMetadata();
    files.add({
      "url": fileUrl,
      "path": file.fullPath,
    });
  });

  return files;
}
