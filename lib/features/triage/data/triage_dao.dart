import 'package:floor/floor.dart';
import 'triage_model.dart';

@dao
abstract class TriageDao {
  @Query('SELECT * FROM TriageRecord ORDER BY timestamp DESC')
  Future<List<TriageRecord>> getAllRecords(); // For the "Sejarah Kes" page

  @insert
  Future<void> insertRecord(TriageRecord record); // Save "Kes Baru"

  @delete
  Future<void> deleteRecord(TriageRecord record);
}
