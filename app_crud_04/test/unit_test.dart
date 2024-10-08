import 'package:app_crud_04/pages/add_person.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Se valida el nombre del producto correctamente', () {
    String productNameTestValid = 'papel';
    expect(isValidProductName(productNameTestValid), true);
    String productNameTestInvalid = 'torn@ditos';
    expect(isValidProductName(productNameTestInvalid), true);
    String? productNameTestNull;
    expect(isValidProductName(productNameTestNull), false);
  });

  test('Se valida el precio del producto correctamente', () {
    String productPriceTestValid = '0.65';
    expect(isValidProductPrice(productPriceTestValid), true);
    String productPriceTestInvalid = '23.4v';
    expect(isValidProductPrice(productPriceTestInvalid), false);
    String? productPriceTestNull;
    expect(isValidProductPrice(productPriceTestNull), false);
  });
}
