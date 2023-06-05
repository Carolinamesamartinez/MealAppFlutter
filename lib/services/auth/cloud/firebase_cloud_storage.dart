import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_meal.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_storage_constants.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final meals = FirebaseFirestore.instance.collection('meals');

  Future<void> deleteMeal({required String documentId}) async {
    try {
      await meals.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteMeal();
    }
  }

  // stream which that make an event for each changue
//a iterable that read each element one by one with specific conditions
//of type cloudnote for the structure that wants to see in the collection

//nots.snapshots return events for each changue in collection notes map do the next work (function)
//events.docs -> a list of documents . map each one to cloudnote where the user equals the specified user
  Stream<Iterable<CloudMeal>> allFavoritesMeals(
          {required String ownerUserId}) =>
      meals.snapshots().map(((event) => event.docs
          .map((doc) => CloudMeal.fromSnapshot(doc))
          .where((meal) => meal.ownerUserId == ownerUserId)));

  Future<CloudMeal> createNewFavoriteMeal(
      {required String ownerUserId,
      required String mealid,
      required String mealName,
      required String mealArea,
      required String mealCategory,
      required String mealImage,
      required String mealInstructions}) async {
    final existingMeal = await meals
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .where(mealidCloud, isEqualTo: mealid)
        .limit(1)
        .get();

    if (existingMeal.docs.isNotEmpty) {
      throw Exception();
    }
    //we add a document to firestore
    // the '' in textfieldname is for not give an error in the code in the future we changued it
    final document = await meals.add({
      ownerUserIdFieldName: ownerUserId,
      mealidCloud: mealid,
      mealNameCloud: mealName,
      mealAreaCloud: mealArea,
      mealCategoryCloud: mealCategory,
      mealImageCloud: mealImage,
      mealInstructionsCloud: mealInstructions
    });
    final fetchedNote = await document.get();
    // get the document created to make a instance of cloudnote
    return CloudMeal(
        documentId: fetchedNote.id,
        ownerUserId: ownerUserId,
        mealName: mealName,
        mealCategory: mealCategoryCloud,
        mealArea: mealAreaCloud,
        mealImage: mealImage,
        mealInstructions: mealInstructions,
        mealid: mealid);
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
