validInput(String val, int min, int max) {
  if (val.length > max) {
    return "can not be more than $max";
  }
  if (val.length < min) {
    return "can not be less than $min";
  }
  if (val.isEmpty) {
    return "can not be empty";
  }
}
