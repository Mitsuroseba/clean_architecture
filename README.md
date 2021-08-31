# clean_architecture
Clean architecture with block library example.
With this arc, we can easily change counter repository: local database or cloud firebase database.

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

![image](https://user-images.githubusercontent.com/1174171/131537377-9471124b-f5c7-4396-b7fc-8a9bffe0c5ae.png)
