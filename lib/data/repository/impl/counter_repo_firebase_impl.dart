import 'package:clean_architecture/data/repository/interface/counter_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCounterRepositoryImpl extends CounterRepository {
  static const boxKey = 'counter';

  late DocumentSnapshot date;
  late DocumentReference _ref;

  FirebaseCounterRepositoryImpl(DocumentReference _ref, DocumentSnapshot data) {
    this.date = data;
    this._ref = _ref;
  }

  @override
  int getLastCount() {
    if (date.get('counter') == null) {
      return 0;
    } else {
      return date.get('counter');
    }
  }

  @override
  Future<int> saveCount(int count) async {
    return _ref.set({
      'counter': count,
    }).then((value) => count);
  }
}
