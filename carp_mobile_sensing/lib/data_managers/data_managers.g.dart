// GENERATED CODE - DO NOT MODIFY BY HAND

part of data_managers;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDataEndPoint _$FileDataEndPointFromJson(Map<String, dynamic> json) {
  return FileDataEndPoint(
    type: json['type'] as String,
    bufferSize: json['buffer_size'] as int,
    zip: json['zip'] as bool,
    encrypt: json['encrypt'] as bool,
    publicKey: json['public_key'] as String,
  )..$type = json[r'$type'] as String;
}

Map<String, dynamic> _$FileDataEndPointToJson(FileDataEndPoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(r'$type', instance.$type);
  writeNotNull('type', instance.type);
  writeNotNull('buffer_size', instance.bufferSize);
  writeNotNull('zip', instance.zip);
  writeNotNull('encrypt', instance.encrypt);
  writeNotNull('public_key', instance.publicKey);
  return val;
}
