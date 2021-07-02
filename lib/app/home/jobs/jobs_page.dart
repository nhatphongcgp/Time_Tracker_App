import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/common_widgets/show_alert_dialogs.dart';
import 'package:time_tracker_app/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_app/app/home/jobs/job_list_title.dart';
import 'package:time_tracker_app/app/home/model/jobs_models.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialogs(
      context,
      title: 'Log out',
      content: 'Are you sure that you want to logout',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          ElevatedButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Log out' ,             style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            final children = jobs
                .map((job) => JobListTile(
                      job: job,
                      onTap:() => EditJobPage.show(context,job: job),
                    ))
                .toList();
            return ListView(
              children: children,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error occured'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}