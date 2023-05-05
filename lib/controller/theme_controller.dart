import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ThemeController extends ChangeNotifier {
  @HiveField(0)
  bool isDark = false;

  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  late Box box;

  ThemeController() {
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThemeControllerAdapter());
    box = await Hive.openBox('theme');
    isDark = box.get('isDark') ?? false;
    notifyListeners();
  }

  void toggleTheme() {
    isDark = !isDark;
    box.put('isDark', isDark);
    notifyListeners();
  }
}

class ThemeControllerAdapter extends TypeAdapter<ThemeController> {
  @override
  final typeId = 0;

  @override
  ThemeController read(BinaryReader reader) {
    final obj = ThemeController();
    obj.isDark = reader.readBool();
    return obj;
  }

  @override
  void write(BinaryWriter writer, ThemeController obj) {
    writer.writeBool(obj.isDark);
  }
}
