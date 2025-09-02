# ✨ TidyTimer - Items List Timer

Um aplicativo simples e elegante construído com Flutter para ajudar você a nunca mais se esquecer das tarefas domésticas recorrentes.

*Substitua por um screenshot ou GIF do seu app.*

---

## 🧹 Sobre o Projeto

Você já se perguntou "Qual foi a última vez que eu limpei o ar-condicionado?" ou "Já está na hora de lavar as cortinas de novo?". O **TidyTimer** nasceu para resolver exatamente esse problema.

Este aplicativo permite que você cadastre tarefas domésticas, defina com que frequência elas precisam ser feitas e, a partir daí, ele gerencia um timer em contagem regressiva para cada uma. Com uma interface limpa e focada, você sempre saberá qual é a próxima tarefa que precisa da sua atenção.

Este projeto foi construído como um exercício prático, explorando conceitos modernos de desenvolvimento Flutter, desde o gerenciamento de estado com Cubit até a persistência de dados com um banco de dados local.

---

## 🚀 Funcionalidades Principais

* **Adicionar Tarefas:** Crie novas tarefas com nome, categoria e frequência de repetição.
* **Contagem Regressiva Automática:** Cada tarefa exibe um timer "vivo" (ex: `12d 8h 3min`) para o próximo vencimento.
* **Feedback Visual:** As tarefas mudam de cor para indicar status de urgência (laranja) ou atraso (vermelho).
* **Marcar como Concluído:** Ao concluir uma tarefa, o timer é automaticamente reiniciado com base na frequência definida.
* **Deslizar para Deletar:** Gerencie sua lista de forma rápida e intuitiva.
* **Desfazer Exclusão:** Deletou uma tarefa por engano? Um clique e ela está de volta!
* **Persistência Local:** Suas tarefas são salvas no seu dispositivo. Elas estarão lá quando você fechar e abrir o app novamente.
* **Suporte a Tema Escuro:** Interface adaptada para modos claro e escuro.

---

## 🔧 Tecnologias Utilizadas

* **Framework:** [Flutter](https://flutter.dev/)
* **Linguagem:** [Dart](https://dart.dev/)
* **Gerenciamento de Estado:** [flutter_bloc (Cubit)](https://bloclibrary.dev/)
* **Banco de Dados:** [Hive](https://hivedb.dev/) (Banco de dados NoSQL rápido e nativo em Dart)
* **Comparação de Objetos:** [equatable](https://pub.dev/packages/equatable)
* **Dependências Auxiliares:**
    * `path_provider`: Para encontrar o caminho de armazenamento no dispositivo.
    * `build_runner` / `hive_generator`: Para geração de código automática.

---

## ⚡ Como Executar o Projeto

Siga os passos abaixo para rodar o projeto localmente.

### Pré-requisitos

* Você precisa ter o [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
* Um emulador Android/iOS ou um dispositivo físico.

### Passos

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/seu-repositorio.git](https://github.com/seu-usuario/seu-repositorio.git)
    cd seu-repositorio
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Gere os arquivos do Hive (passo crucial):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

---

## 📁 Estrutura do Projeto

O projeto segue uma estrutura de pastas limpa para promover a separação de responsabilidades:

```
lib/
|-- cubits/         # Lógica de negócio e gerenciamento de estado (TaskCubit)
|-- models/         # Classes de modelo de dados (Task)
|-- screens/        # Widgets que representam as telas do app
|-- theme/          # Configuração de tema (cores, fontes)
|-- widgets/        # Widgets reutilizáveis (ex: CountdownTimer)
|-- main.dart       # Ponto de entrada da aplicação
```

---

## 💡 Melhorias Futuras

Este projeto tem muito potencial para crescer! Algumas ideias para o futuro:

* [ ] **Notificações Push** para avisar sobre tarefas vencendo.
* [ ] **Categorias e Filtros** para organizar melhor as tarefas.
* [ ] **Tela de Estatísticas** para gamificar a limpeza.
* [ ] **Edição de Tarefas** já existentes.
* [ ] **Sincronização na Nuvem** (Firebase/Supabase) para backup e uso em múltiplos dispositivos.

---

Feito com Flutter.