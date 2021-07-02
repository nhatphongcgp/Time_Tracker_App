import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/app/home/model/jobs_models.dart';
import 'package:time_tracker_app/services/api_auth.dart';
import 'package:time_tracker_app/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdfromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;
  @override
  Future<void> setJob(Job job) => _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );
  @override
  Future<void> deleteJob(Job job) async {
    _service.deleteData(path: APIPath.job(uid, job.id));
  }

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );
}
