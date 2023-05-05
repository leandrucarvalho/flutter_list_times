Explicação do código:

ThemeController com a palavra-chave with ChangeNotifier indica que a classe usa ChangeNotifier para notificar mudanças de estado.

isDark é uma propriedade pública que retorna o estado atual do tema escuro.

themeModes é um mapa que associa uma string (nome do tema) a um valor de ThemeMode (classe que representa o modo de tema do Flutter).

prefs é uma instância de SharedPreferences (classe para armazenar dados no dispositivo do usuário) que será usada para armazenar o estado atual do tema escuro.

initPrefs é um método assíncrono que inicializa o objeto prefs e recupera o estado atual do tema escuro. Se o estado atual do tema escuro não estiver definido no objeto prefs, ele será definido como false.

toggleTheme é um método que alterna o estado do tema escuro entre true e false. Além disso, atualiza o objeto prefs com o novo estado do tema escuro e notifica todos os ouvintes de mudança de estado.

Com o provider você pode recuperar a instância do ThemeController em qualquer widget filho usando Provider.of<ThemeController>(context). Por exemplo, para usar o método toggleTheme em um botão

class ThemeController with ChangeNotifier {
var \_isDark = false;

Map<String, ThemeMode> themeModes = {
'light': ThemeMode.light,
'dark': ThemeMode.dark,
};

SharedPreferences? prefs;

ThemeController() {
initPrefs();
}

bool get isDark => \_isDark;

Future<void> initPrefs() async {
prefs = await SharedPreferences.getInstance();
\_isDark = prefs?.getBool('isDark') ?? false;
notifyListeners();
}

void toggleTheme() {
\_isDark = !\_isDark;
prefs?.setBool('isDark', \_isDark);
notifyListeners();
}
}
