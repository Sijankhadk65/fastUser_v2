import 'package:fast_app_v2_1/src/models/add_on.dart';
import 'package:fast_app_v2_1/src/models/varient.dart';
import 'package:rxdart/rxdart.dart';

class CartItemBloc {
  List<AddOn> _selectedAddOns = [];

  final BehaviorSubject<Varient?> _currentSelectedVarientSubject =
      BehaviorSubject<Varient?>();
  Stream<Varient?> get currentSelectedVarient =>
      _currentSelectedVarientSubject.stream;
  Function(Varient?) get changeCurrentSelectedVarient =>
      _currentSelectedVarientSubject.sink.add;

  final BehaviorSubject<int?> _currentUnitPriceSubject =
      BehaviorSubject<int?>();
  Stream<int?> get currentUnitPrice => _currentUnitPriceSubject.stream;
  Function(int?) get changeCurrentUnitPrice =>
      _currentUnitPriceSubject.sink.add;

  final BehaviorSubject<int?> _currentTotalPriceSubject =
      BehaviorSubject<int?>();
  Stream<int?> get currentTotalPrice => _currentTotalPriceSubject.stream;
  Function(int?) get changeCurrentTotalPrice =>
      _currentTotalPriceSubject.sink.add;

  final BehaviorSubject<int?> _currentItemCountSubject =
      BehaviorSubject<int?>();
  Stream<int?> get currentItemCount => _currentItemCountSubject.stream;
  Function(int?) get changeCurrentItemCount =>
      _currentItemCountSubject.sink.add;

  final BehaviorSubject<List<AddOn?>> _currentSelectedAddonsSubject =
      BehaviorSubject<List<AddOn?>>();
  Stream<List<AddOn?>> get currentSelectedAddons =>
      _currentSelectedAddonsSubject.stream;
  Function(List<AddOn?>) get changeCurrentSelectedAddons =>
      _currentSelectedAddonsSubject.sink.add;

  changeTotalPrice() {
    changeCurrentTotalPrice(
        _currentItemCountSubject.value! * _currentUnitPriceSubject.value!);
  }

  void manageAddOn(AddOn? addOn) {
    if (_currentSelectedAddonsSubject.value.contains(addOn)) {
      changeCurrentUnitPrice(_currentUnitPriceSubject.value! - addOn!.price!);
      changeTotalPrice();
      _selectedAddOns.remove(addOn);
      changeCurrentSelectedAddons(_selectedAddOns);
    } else {
      changeCurrentUnitPrice(_currentUnitPriceSubject.value! + addOn!.price!);
      changeTotalPrice();
      _selectedAddOns.add(addOn);
      changeCurrentSelectedAddons(_selectedAddOns);
    }
  }

  Map<String, dynamic> getItem(String itemName, String photoURI) => {
        "name": itemName,
        "totalPrice": _currentTotalPriceSubject.value,
        "quantity": _currentItemCountSubject.value,
        "price": _currentUnitPriceSubject.value,
        "addOns": _currentSelectedAddonsSubject.hasValue
            ? _currentSelectedAddonsSubject.value
                .map(
                  (addOn) => addOn!.toNewAddOnJson(),
                )
                .toList()
            : [],
        "varient": _currentSelectedVarientSubject.hasValue
            ? _currentSelectedVarientSubject.value!.toNewVarientJson()
            : {},
        "photoURI": photoURI,
      };

  dispose() {
    _currentSelectedVarientSubject.close();
    _currentUnitPriceSubject.close();
    _currentTotalPriceSubject.close();
    _currentItemCountSubject.close();
    _currentSelectedAddonsSubject.close();
  }
}
