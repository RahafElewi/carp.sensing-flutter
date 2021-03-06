/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of communication;

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CalendarMeasure extends Measure {
  static const int DEFAULT_NUMBER_OF_DAYS = 1;

  /// The time duration back in time to collect calendar events.
  Duration past;

  /// The time duration ahead in time to collect calendar events.
  Duration future;

  CalendarMeasure(
    MeasureType type, {
    name,
    enabled,
    this.past = const Duration(days: DEFAULT_NUMBER_OF_DAYS),
    this.future = const Duration(days: DEFAULT_NUMBER_OF_DAYS),
  })
      : super(type, enabled: enabled, name: name);

  static Function get fromJsonFunction => _$CalendarMeasureFromJson;
  factory CalendarMeasure.fromJson(Map<String, dynamic> json) => FromJsonFactory
      .fromJson(json[Serializable.CLASS_IDENTIFIER].toString(), json);
  Map<String, dynamic> toJson() => _$CalendarMeasureToJson(this);
}
