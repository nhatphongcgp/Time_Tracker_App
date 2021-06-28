import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/app/model/jobs_models.dart';
import 'package:time_tracker_app/services/api_auth.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
  // void readJobs();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  Future<void> createJob(Job job) async {
    await _setData(
      path: APIPath.job(uid, 'job_abc'),
      data: job.toMap(),
    );
  }

  // void readJobs() {
  //   final path = APIPath.jobs(uid);
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   snapshots.listen((snapshot) {
  //     snapshot.docs.forEach((element) {
  //       print(element.data());
  //     });
  //   });
  // }
  Stream<List<Job>> jobsStream() =>
    _collectionsStream(
      path: APIPath.jobs(uid),
      builder: (data)=>Job.fromMap(data)
    );
  

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('path:$path');
    await reference.set(data);
  }

  Stream<List<T>> _collectionsStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic>) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((snapshot) => builder(snapshot.data())).toList());
  }
}
