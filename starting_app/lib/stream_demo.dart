import 'dart:async';

StreamController<int> controller = StreamController<int>.broadcast();

void streamDemo() {
  controller.sink.add(1);
}

void cartCount() {
  controller.stream.listen((value) {
    print("From cartCount $value");
  });
}

void cartPage() {
  controller.stream.listen((value) {
    print('From cart page $value');
  });
}

void buyNowPage() {
  controller.stream.listen((value) {
    print('From buy now page page $value');
  });
}
