import 'dart:async';
import 'package:fast_app_v2_1/src/models/item.dart';
import 'package:fast_app_v2_1/src/models/vendor.dart';
import 'package:fast_app_v2_1/src/resources/repository.dart';
import 'package:rxdart/subjects.dart';

class SearchBloc {
  final _repo = Repository();

  final BehaviorSubject<String> _searchFilterSubject =
      BehaviorSubject<String>();
  Stream<String> get searchFilter => _searchFilterSubject.stream;
  Function(String) get changeSearchFilter => _searchFilterSubject.sink.add;

  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();
  Stream<String> get query => _querySubject.stream;
  Function(String) get changeQuery => _querySubject.sink.add;

  final BehaviorSubject<List<Vendor>> _queryVendorsSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get queryVendors => _queryVendorsSubject.stream;
  Function(List<Vendor>) get changeQueryVendors =>
      _queryVendorsSubject.sink.add;
  final BehaviorSubject<List<MenuItem>> _queryMenuSubject =
      BehaviorSubject<List<MenuItem>>();
  Stream<List<MenuItem>> get queryMenu => _queryMenuSubject.stream;
  Function(List<MenuItem>) get changeQueryMenu => _queryMenuSubject.sink.add;

  SearchBloc() {
    changeSearchFilter("resturant");
  }

  Stream<List<Vendor>> getVendors(String name) {
    return _repo.getVendors("all").transform(StreamTransformer.fromHandlers(
        handleData: (List<Vendor> vendors, sink) {
      List<Vendor> namedVendors = [];
      for (var vendor in vendors) {
        if (vendor.name!.toLowerCase().contains(name.toLowerCase())) {
          namedVendors.add(vendor);
        }
      }
      sink.add(namedVendors);
    }));
  }

  Stream<List<MenuItem>> getMenuItems(String category) {
    return _repo.getVendorMenu("all", "all").transform(
        StreamTransformer.fromHandlers(
            handleData: (List<MenuItem> menuItems, sink) {
      List<MenuItem> categorizedItems = [];
      for (var item in menuItems) {
        if (item.category!.toLowerCase().contains(category.toLowerCase())) {
          categorizedItems.add(item);
        }
      }
      sink.add(categorizedItems);
    }));
  }

  dispose() {
    _searchFilterSubject.close();
    _querySubject.close();
  }
}

SearchBloc searchBloc = SearchBloc();
