import 'package:get/get.dart';

class CircleController extends GetxController {
  Rx<double> questionProgressWidth = 10.0.obs;
  Rx<int> weightHq = 50.obs;
  int questionOriginalSize = 4;
  Rx<int> questionSize = 4.obs;
  Rx<int> currentSectionId = 0.obs;
  Rx<bool> isLoading = false.obs;
  int currentQuestion = 0;
  Rx<int> questionPercentage = 0.obs;
  var weightOptions = ["KG", "LB"];
  var genderOptions = ["Male", "Female", "Other"];

  var heightValue = "0".obs;
  var heightUnit = "cm".obs;
  var weightUnit = "kg".obs;
  var selectedGender = "Male".obs;
  var initialValue = "50".obs;


  getPercentage(int? points) {
    return points != null ? (points / 100) : 0.0;
  }

  setWeight(val) {
    weightHq.value = val;
  }
}
