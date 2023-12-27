import 'package:js/js.dart';

@JS()
external int test();
void executeScraper() {
  int result = test(); // Call the JS function
  print(result); // Should print 32
}
