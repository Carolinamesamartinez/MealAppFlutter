class CloudStorageException implements Exception {
  const CloudStorageException();
}
//could not add meal to favorites

class CouldNotCreateMeal extends CloudStorageException {}

class CouldNotGetAllMeals extends CloudStorageException {}

class CouldNotDeleteMeal extends CloudStorageException {}
