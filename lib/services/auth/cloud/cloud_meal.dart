import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_storage_constants.dart';

@immutable
//properties of the class couldnt changue
class CloudMeal {
  final String documentId;
  final String ownerUserId;
  final String mealName;
  final String mealid;
  final String mealCategory;
  final String mealArea;
  final String mealImage;
  final String mealInstructions;

  const CloudMeal(
      {required this.documentId,
      required this.ownerUserId,
      required this.mealid,
      required this.mealName,
      required this.mealCategory,
      required this.mealArea,
      required this.mealImage,
      required this.mealInstructions});

  CloudMeal.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName] as String,
        mealName = snapshot.data()[mealNameCloud] as String? ?? '',
        mealid = snapshot.data()[mealidCloud] as String? ?? '',
        mealCategory = snapshot.data()[mealCategoryCloud] as String? ?? '',
        mealArea = snapshot.data()[mealAreaCloud] as String? ?? '',
        mealImage = snapshot.data()[mealImageCloud] as String? ?? '',
        mealInstructions =
            snapshot.data()[mealInstructionsCloud] as String? ?? '';
}
