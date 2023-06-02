import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String mealName;
  final String mealCategory;
  final String mealArea;
  final String mealImage;

  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.mealName,
    required this.mealCategory,
    required this.mealArea,
    required this.mealImage,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        mealName = snapshot.data()[mealNameCloud] as String,
        mealCategory = snapshot.data()[mealCategoryCloud] as String,
        mealArea = snapshot.data()[mealAreaCloud] as String,
        mealImage = snapshot.data()[mealImageCloud] as String;
}
