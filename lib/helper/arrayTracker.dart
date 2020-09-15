class ArrayTracker {
  List array1;
  List array2;

  challengeIsFinished(array1, array2) {
    bool flag1 = true;
    bool flag2 = true;
    for (int i = 0; i < array1.length; i++) {
      if (array1[i] == false) flag1 = false;
    }
    for (int i = 0; i < array2.length; i++) {
      if (array2[i] == false) flag2 = false;
    }
    if (flag2 || flag1)
      return true;
    else
      return false;
  }

  bool challengeIsFinishedforLoggedInUser(array1) {
    bool flag1 = true;
    for (int i = 0; i < array1.length; i++) {
      if (array1[i] == false) flag1 = false;
    }

    if (flag1)
      return true;
    else
      return false;
  }
}
