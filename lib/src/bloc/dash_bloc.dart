import 'package:fast_app_v2_1/src/models/carousel_item.dart';
import 'package:fast_app_v2_1/src/models/community_item.dart';
import 'package:fast_app_v2_1/src/models/item.dart';
import 'package:fast_app_v2_1/src/models/vendor.dart';
import 'package:fast_app_v2_1/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DashBloc {
  final _repo = Repository();
  final BehaviorSubject<Vendor> _featuredVendorSubject =
      BehaviorSubject<Vendor>();
  Stream<Vendor> get featuredVendor => _featuredVendorSubject.stream;
  Function(Vendor) get changeFeaturedVendor => _featuredVendorSubject.sink.add;
  Stream<List<CommunityItem>> getCommunityItems() => _repo.getCommunityItems();

  Stream<List<CarouselItem>> getCarouselItems() => _repo.getCarouselItems();
  Stream<List<MenuItem>> getFeaturedMenuItems(String vendorName) =>
      _repo.getVendorFeaturedMenu(vendorName);

  getFeaturedVendor() {
    _repo.getFeaturedVendor().listen(
      (vendor) {
        changeFeaturedVendor(vendor);
      },
    );
  }

  dispose() {
    _featuredVendorSubject.close();
  }
}
