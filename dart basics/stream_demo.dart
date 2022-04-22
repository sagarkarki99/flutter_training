import 'dart:async';

StreamController<int> controller = StreamController<int>.broadcast();

Future<void> streamDemo() async {
  controller.sink.add(343);
  await Future.delayed(const Duration(seconds: 2));
  controller.sink.add(99);
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
