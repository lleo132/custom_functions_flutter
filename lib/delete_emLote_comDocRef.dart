Future batchDelete(String? collectionName, DocumentReference docuRef) async {
  collectionName = collectionName ?? 'funcionarios';

  // Obtenha a instancia do FireBase
  final firestore = FirebaseFirestore.instance;

  // Pegue a referencia da sua coleção
  final collectionRef = firestore.collection(collectionName);

  // Pegue a lista de documentos da sua coleção
  final QuerySnapshot snapshot = await collectionRef.get();

  
  snapshot.docs.forEach((document) async {
    // Obtenha o campo onde tem a referencia do seu docRef
    final documentRefFieldValue = document['docRef'];

    // Compare os campos
    if (documentRefFieldValue is DocumentReference &&
        documentRefFieldValue == docuRef) {
      // Se tudo dê certo, apague somente o documento correto
      await document.reference.delete();
    }
  });
}