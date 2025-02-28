import 'package:isar/isar.dart';

part 'location_model.g.dart';

@Collection()
class Location {
  Id id = Isar.autoIncrement;

  late String address;
  late double latitude;
  late double longitude;
}
