import 'package:clean_architecture/data/repository/impl/counter_repo_firebase_impl.dart';
import 'package:clean_architecture/data/repository/impl/counter_repo_impl.dart';
import 'package:clean_architecture/data/repository/interface/counter_repo.dart';
import 'package:clean_architecture/domain/use_cases/impl/counter_case_impl.dart';
import 'package:clean_architecture/domain/use_cases/interfaces/counter_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DI {
  static DI? instance;

  late CounterRepository counterRepository;
  late CounterRepository firebaseRepository;
  late CounterCase counterCase;

  DI._();

  static DI getInstance() {
    return instance ?? (instance = DI._());
  }

  Future<void> init() async {
    final directory = await getTemporaryDirectory();

    Hive.init(directory.path);
    await Firebase.initializeApp();
    DocumentReference collection = FirebaseFirestore.instance
        .collection('counters')
        .doc('wH6NdMaMhHeeWuXpazZA5pySq8F3');
    counterRepository = CounterRepositoryImpl(await Hive.openBox('counter'));
    firebaseRepository =
        FirebaseCounterRepositoryImpl(collection, await collection.get());

    // counterCase = CounterCaseImpl(counterRepository);
    counterCase = CounterCaseImpl(firebaseRepository);
  }
}
