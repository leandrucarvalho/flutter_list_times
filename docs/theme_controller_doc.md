Explicação do código:

ThemeController estende a classe ChangeNotifier, que é a classe básica para gerenciamento de estado no Flutter.

isDark é uma variável observável (observável com obs do pacote GetX) que armazena o estado atual do tema escuro.

themeModes é um mapa que associa uma string (nome do tema) a um valor de ThemeMode (classe que representa o modo de tema do Flutter).

prefs é uma instância de SharedPreferences (classe para armazenar dados no dispositivo do usuário) que será usada para armazenar o estado atual do tema escuro.

initPrefs é um método assíncrono que inicializa o objeto prefs e recupera o estado atual do tema escuro. Se o estado atual do tema escuro não estiver definido no objeto prefs, ele será definido como false.

toggleTheme é um método que alterna o estado do tema escuro entre true e false. Além disso, atualiza o objeto prefs com o novo estado do tema escuro e notifica todos os ouvintes de mudança de estado.

of é um método estático que recebe um objeto de contexto BuildContext e retorna uma instância de ThemeController usando o Provider.of.

Com o of você pode recuperar a instância do ThemeController em qualquer widget filho usando ThemeController.of(context). Por exemplo, para usar o método toggleTheme em um botão
