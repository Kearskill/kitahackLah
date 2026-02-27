import 'triage_dao.dart';
import 'triage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TriageRepository {
  final TriageDao localDataSource;
  final FirebaseFirestore remoteDataSource = FirebaseFirestore.instance;

  TriageRepository(this.localDataSource);

  // 1. Save locally first (Always works, even offline in Bario!)
  Future<void> saveTriage(TriageRecord record) async {
    await localDataSource.insertRecord(record);

    // 2. Try to sync to Firebase if internet is available
    try {
      await remoteDataSource.collection('cases').add(record.toMap());
    } catch (e) {
      print(
        "Offline: Saved to local DB only.",
      ); // Handled by Firebase offline sync later
    }
  }

  // Fetch all history for the "Sejarah Kes" view
  Future<List<TriageRecord>> getHistory() async {
    return await localDataSource.getAllRecords();
  }
}
