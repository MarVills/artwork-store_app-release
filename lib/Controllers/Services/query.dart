import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hquery {
  String id = "";
  final db = FirebaseFirestore.instance;
  final dbs = FirebaseStorage.instance;

  Future<String> push(root, data) async {
    DocumentReference ref = await db.collection(root).add(data);
    id = ref.id;
    return ref.id.toString();
  }

  Future<bool> pushf(file, fileName, {folder: ""}) async {
    var dir = folder.length == 0 ? folder : "/" + folder + "/";
    var fsr = dbs.ref().child(dir + fileName);
    var task = fsr.putFile(file);
    await task.whenComplete(() => null);
    return true;
  }

  Future<String> pushf2(file, fileName, {folder: ""}) async {
    var dir = folder.length == 0 ? folder : "/" + folder + "/";
    var ref = dbs.ref().child("$dir$fileName");
    UploadTask uploadTask = ref.putFile(file);

    var dowurl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    var url = dowurl.toString();

    return url;
  }

  Future<bool> update(root, key, data) async {
    await db.collection(root).doc(key).update(data).whenComplete(() => null);
    return true;
  }

  Stream<QuerySnapshot> getSnap(String root) {
    return FirebaseFirestore.instance.collection(root).snapshots();
  }
}
