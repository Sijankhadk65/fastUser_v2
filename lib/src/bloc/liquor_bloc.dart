import 'package:fast_app_v2_1/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class LiquorBloc {
  final _repo = Repository();

  getLiquors(String category) => _repo.getLiquor(category);

  dispose() {}
}
