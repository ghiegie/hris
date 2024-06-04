class Config {
  Database database;

  Config({required this.database});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(database: Database.fromJson(json['database']));
  }
}

class Database {
  String location;

  Database({required this.location});

  factory Database.fromJson(Map<String, dynamic> json) {
    return Database(location: json['location']);
  }
}