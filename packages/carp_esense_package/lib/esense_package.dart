/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of esense;

/// This is the base class for this eSense sampling package.
///
/// To use this package, register it in the [carp_mobile_sensing] package using
///
/// ```
///   SamplingPackageRegistry.register(ESenseSamplingPackage());
/// ```
class ESenseSamplingPackage implements SamplingPackage {
  static const String BUTTON = "esense.button";
  static const String SENSOR = "esense.sensor";

  List<String> get dataTypes => [BUTTON, SENSOR];

  Probe create(String type) {
    switch (type) {
      case BUTTON:
        return ESenseButtonProbe();
      case SENSOR:
        return ESenseSensorProbe();
      default:
        return null;
    }
  }

  void onRegister() => FromJsonFactory.registerFromJsonFunction(
      "ESenseMeasure", ESenseMeasure.fromJsonFunction);

  List<Permission> get permissions =>
      [Permission.location, Permission.microphone];

  SamplingSchema get common => SamplingSchema()
    ..type = SamplingSchemaType.COMMON
    ..name = 'Common (default) eSense sampling schema'
    ..powerAware = true
    ..measures.addEntries([
      MapEntry(
          BUTTON,
          ESenseMeasure(MeasureType(NameSpace.CARP, BUTTON),
              name: 'eSense - Button',
              enabled: true,
              deviceName: '',
              samplingRate: 10)),
      MapEntry(
          SENSOR,
          ESenseMeasure(MeasureType(NameSpace.CARP, SENSOR),
              name: 'eSense - Sensors',
              enabled: true,
              deviceName: '',
              samplingRate: 10)),
    ]);

  SamplingSchema get light => common
    ..type = SamplingSchemaType.LIGHT
    ..name = 'Light eSense sampling';

  SamplingSchema get minimum => light
    ..type = SamplingSchemaType.MINIMUM
    ..name = 'Minimum eSense sampling'
    ..measures[BUTTON].enabled = false
    ..measures[SENSOR].enabled = false;

  SamplingSchema get normal => common;

  // This is the debug sampling schema used by bardram
  // His eSense devices are
  //
  //            name         id
  //  right  eSense-0917  00:04:79:00:0F:4D
  //  left   eSense-0332  00:04:79:00:0D:04
  //
  // As recommended;:
  //   "it would be better to use the right earbud to record only sound samples
  //    and the left earbud to record only IMU data."
  // Hence, connect the right earbud (eSense-0917) to the phone.
  SamplingSchema get debug => SamplingSchema()
    ..type = SamplingSchemaType.DEBUG
    ..name = 'Debugging eSense sampling schema'
    ..powerAware = false
    ..measures.addEntries([
      MapEntry(
          BUTTON,
          ESenseMeasure(MeasureType(NameSpace.CARP, BUTTON),
              name: 'eSense - Button',
              enabled: true,
              deviceName: 'eSense-0332')),
      MapEntry(
          SENSOR,
          ESenseMeasure(MeasureType(NameSpace.CARP, SENSOR),
              name: 'eSense - Sensors',
              enabled: true,
              deviceName: 'eSense-0332',
              samplingRate: 5)),
    ]);
}
