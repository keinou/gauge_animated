import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gaugeanimated/gaugeanimated.dart';

void main() {
  test('adds one to input values', () {
    Driver _driver = Driver();
    expect(
        GaugeAnimated.build(
            driver: _driver,
            centerWidget: Text("Teste"),
            fullColor: Colors.black,
            percentColor: Colors.red,
            fullWidth: 8,
            percentWidth: 8),
        '42');
  });
}
