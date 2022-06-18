import 'dart:io';
import '/utils/utils.dart';

main() async {

  
  one();
  two();
}

num fat(int n) {
  if (n == 1) {
    return n;
  } else
    return n * fat(n - 1);
}
