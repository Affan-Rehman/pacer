// ignore_for_file: prefer_const_constructors, avoid_renaming_method_parameters

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import 'classes.dart';

class HourAdapter extends TypeAdapter<Hour> {
  @override
  final int typeId = 5;

  @override
  Hour read(BinaryReader reader) {
    return Hour(
      hour: reader.readInt(),
      steps: reader.readInt(),
      calories: reader.readDouble(),
      distance: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Hour obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
  }
}

class DailyAdapter extends TypeAdapter<Daily> {
  @override
  final int typeId = 6;

  @override
  Daily read(BinaryReader reader) {
    return Daily(
      hourList: reader.readList().cast<Hour>(),
      day: reader.readString(),
    )
      ..steps = reader.readInt()
      ..calories = reader.readDouble()
      ..distance = reader.readDouble()
      ..avgCal = reader.readDouble();
  }

  @override
  void write(BinaryWriter writer, Daily obj) {
    writer.writeList(obj.hourList);
    writer.writeString(obj.day);
    writer.writeInt(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
    writer.writeDouble(obj.avgCal);
  }
}

class WeeklyAdapter extends TypeAdapter<Weekly> {
  @override
  final int typeId = 7;

  @override
  Weekly read(BinaryReader reader) {
    return Weekly(
      name: reader.readString(),
      startDate: DateTime.parse(reader.readString()),
      endDate: DateTime.parse(reader.readString()),
      dailyList: reader.readList().cast<Daily>(),
      steps: reader.readInt(),
      calories: reader.readDouble(),
      distance: reader.readDouble(),
    )..avgCal = reader.readDouble();
  }

  @override
  void write(BinaryWriter writer, Weekly obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.startDate.toIso8601String());
    writer.writeString(obj.endDate.toIso8601String());
    writer.writeList(obj.dailyList);
    writer.writeInt(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
    writer.writeDouble(obj.avgCal);
  }
}

class MonthlyAdapter extends TypeAdapter<Monthly> {
  @override
  final int typeId = 8;

  @override
  Monthly read(BinaryReader reader) {
    return Monthly(
      startDate: DateTime.parse(reader.readString()),
      endDate: DateTime.parse(reader.readString()),
      weeklyList: reader.readList().cast<Weekly>(),
      steps: reader.readInt(),
      calories: reader.readDouble(),
      distance: reader.readDouble(),
      name: reader.readString(),
    )..avgCal = reader.readDouble();
  }

  @override
  void write(BinaryWriter writer, Monthly obj) {
    writer.writeString(obj.startDate.toIso8601String());
    writer.writeString(obj.endDate.toIso8601String());
    writer.writeList(obj.weeklyList);
    writer.writeInt(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
    writer.writeString(obj.name);
    writer.writeDouble(obj.avgCal);
  }
}

class YearlyAdapter extends TypeAdapter<Yearly> {
  @override
  final int typeId = 9;

  @override
  Yearly read(BinaryReader reader) {
    return Yearly(
      year: DateTime.parse(reader.readString()),
      monthlyList: reader.readList().cast<Monthly>(),
      steps: reader.readInt(),
      calories: reader.readDouble(),
      distance: reader.readDouble(),
    )..avgCal = reader.readDouble();
  }

  @override
  void write(BinaryWriter writer, Yearly obj) {
    writer.writeString(obj.year.toIso8601String());
    writer.writeList(obj.monthlyList);
    writer.writeInt(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
    writer.writeDouble(obj.avgCal);
  }
}

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 1;

  @override
  Place read(BinaryReader reader) {
    final fields = reader.readMap();
    return Place(
      id: fields['id'] as String,
      name: fields['name'] as String,
      type: fields['type'] as String,
      address: fields['address'] as String,
      latitude: fields['latitude'] as double,
      longitude: fields['longitude'] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer.writeMap({
      'id': obj.id,
      'name': obj.name,
      'type': obj.type,
      'address': obj.address,
      'latitude': obj.latitude,
      'longitude': obj.longitude,
    });
  }
}

class WalkAdapter extends TypeAdapter<Walk> {
  @override
  final int typeId = 2;

  @override
  Walk read(BinaryReader reader) {
    final fields = reader.readMap();
    return Walk(
      id: fields['id'] as String,
      distance: fields['distance'] as double,
      steps: fields['steps'] as int,
      kcal: fields['kcal'] as double,
      datetimeStart: fields['datetimestart'] as String,
      datetimeFinish: fields['datetimefinish'] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Walk obj) {
    writer.writeMap({
      'id': obj.id,
      'distance': obj.distance,
      'steps': obj.steps,
      'kcal': obj.kcal,
      'datetimestart': obj.datetimeStart,
      'datetimefinish': obj.datetimeFinish,
    });
  }
}

class DayDataAdapter extends TypeAdapter<DayData> {
  @override
  final typeId = 3;

  @override
  DayData read(BinaryReader reader) {
    return DayData(
      name: reader.readString(),
      steps: reader.readDouble(),
      calories: reader.readDouble(),
      distance: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, DayData obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.steps);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.distance);
  }
}

class PolylineAdapter extends TypeAdapter<Polyline> {
  @override
  final int typeId =
      10; // Replace with a unique identifier for your Polyline class

  @override
  Polyline read(BinaryReader reader) {
    final pointCount = reader.readByte();
    final points = <LatLng>[];

    for (var i = 0; i < pointCount; i++) {
      final lat = reader.readDouble();
      final lng = reader.readDouble();
      points.add(LatLng(lat, lng));
    }

    return Polyline(points: points, polylineId: PolylineId("poly"));
  }

  @override
  void write(BinaryWriter writer, Polyline polyline) {
    writer.writeByte(polyline.points.length);
    for (final point in polyline.points) {
      writer.writeDouble(point.latitude);
      writer.writeDouble(point.longitude);
    }
  }
}
