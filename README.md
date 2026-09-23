# Clean Arch App

Aplicación mobile en Flutter para gestionar tareas con una arquitectura basada en Clean Architecture, separando dominio, infraestructura, presentación y utilidades compartidas.

## Descripción

Esta app permite:

- Iniciar sesión con la API pública de DummyJSON
- Mantener la sesión activa del usuario con preferencias locales
- Listar, crear, actualizar, eliminar y sincronizar tareas
- Persistir los datos localmente con SQLite
- Gestionar la UI con BLoC
- Inyectar dependencias con `GetIt`
- Manejar resultados y errores de forma centralizada con un `Result` pattern

## Stack tecnológico

- Flutter
- Dart
- BLoC / `flutter_bloc`
- Dio
- SQLite / `sqflite`
- SharedPreferences
- `GetIt`
- Clean Architecture
- Result pattern

## Estructura del proyecto

```text
lib/
├── main.dart
├── core/
│   ├── bootstrap.dart
│   ├── dark_theme.dart
│   ├── injection.dart
│   ├── light_theme.dart
│   ├── main_app.dart
│   └── routes.dart
│
├── app/
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── todo_entity.dart
│   │   │   └── user_entity.dart
│   │   ├── interfaces/
│   │   │   ├── todo_repository_interface.dart
│   │   │   └── user_repository_interface.dart
│   │   └── use_cases/
│   │       ├── todo/
│   │       │   ├── create_todo_case.dart
│   │       │   ├── delete_todo_case.dart
│   │       │   ├── read_todos_case.dart
│   │       │   ├── sync_todo_case.dart
│   │       │   └── update_todo_case.dart
│   │       └── user/
│   │           ├── check_session_case.dart
│   │           ├── login_user_case.dart
│   │           └── logout_user_case.dart
│   │
│   ├── infra/
│   │   ├── data_sources/
│   │   │   ├── local/
│   │   │   │   ├── preferences.dart
│   │   │   │   └── todo_database.dart
│   │   │   └── remote/
│   │   │       ├── auth_source.dart
│   │   │       ├── http_client_dio.dart
│   │   │       └── todo_source.dart
│   │   ├── drivers/
│   │   │   ├── auth.dart
│   │   │   ├── http_client.dart
│   │   │   ├── preferences_interface.dart
│   │   │   ├── todo_database_interface.dart
│   │   │   └── todo_source_interface.dart
│   │   ├── models/
│   │   │   ├── todo_model.dart
│   │   │   └── user_model.dart
│   │   └── repositories/
│   │       ├── todo_repository.dart
│   │       └── user_repository.dart
│   │
│   ├── presenter/
│   │   ├── components/
│   │   │   ├── add_todo_dialog_component.dart
│   │   │   ├── confirm_dialog.dart
│   │   │   ├── input_password_component.dart
│   │   │   ├── input_user_component.dart
│   │   │   ├── list_card_component.dart
│   │   │   ├── login_button_component.dart
│   │   │   ├── login_form_component.dart
│   │   │   └── todo_filter_toolbar_component.dart
│   │   ├── view_models/
│   │   │   └── bloc/
│   │   │       ├── login_bloc.dart
│   │   │       ├── login_event.dart
│   │   │       ├── login_state.dart
│   │   │       ├── todos_bloc.dart
│   │   │       ├── todos_event.dart
│   │   │       └── todos_state.dart
│   │   └── views/
│   │       ├── about/
│   │       │   └── about_page.dart
│   │       ├── logged/
│   │       │   └── logged_view.dart
│   │       ├── login/
│   │       │   └── login_view.dart
│   │       └── splash/
│   │           └── splash_view.dart
│   │
│   └── shared/
│       ├── db_helper.dart
│       ├── enums.dart
│       ├── failures.dart
│       ├── result.dart
│       └── use_case.dart
│
├── assets/
│   └── images/
│       └── logo.png
│
└── flutter_launcher_icons.yaml
```

## Arquitectura general

### 1. Dominio

Contiene las entidades y contratos del negocio:

- `TodoEntity` y `UserEntity`
- `TodoRepositoryInterface`
- `UserRepositoryInterface`
- Casos de uso de tareas y sesión

### 2. Infraestructura

Implementa adaptadores y dependencias externas:

- `AuthSource`, `TodoSource`, `HttpClientDio`
- `TodoDatabaseSqfliteImplementation`
- `SharedPref`
- `TodoRepository` y `UserRepository`
- `drivers` como interfaces de compatibilidad para cada dependencia

### 3. Presentación

Encapsula la capa visual y la lógica de estado:

- Vistas: splash, login y logged
- Componentes reutilizables
- `LoginBloc` y `TodosBloc`

## Flujo principal

```text
SplashView
  ↓
Verifica sesión almacenada
  ├── Sí existe sesión → LoggedView
  └── No existe sesión → LoginView
             ↓
      Login con DummyJSON
             ↓
      Guardado de sesión local
             ↓
      Carga/consulta de todos
             ↓
      Sincronización con API + SQLite
```

## Patrón de inyección de dependencias

La configuración de servicios centraliza las implementaciones en `core/injection.dart` usando `GetIt`:

- `HttpClientInterface`
- `TodoRepositoryInterface`
- `TodoDatabaseInterface`
- `AuthInterface`
- `UserRepositoryInterface`
- `TodoSourceInterface`
- `PreferencesInterface`

## API utilizada

El proyecto consume la API pública de DummyJSON:

- Login: `https://dummyjson.com/auth/login`
- Todos del usuario: `https://dummyjson.com/todos/user/{userId}`

Usuarios de prueba:

```text
Usuario: emilys
Contraseña: emilyspass

Usuario: michaelw
Contraseña: michaelwpass
```

## Funcionalidades principales

- Login con credenciales del usuario
- Guardado persistente de sesión
- Verificación de sesión activa al iniciar la app
- Listado, creación, actualización y eliminación de tareas
- Sincronización de todos desde la API
- Persistencia local con SQLite
- Manejo centralizado de errores con `Result`
- Filtrado y validación de tareas en la UI

## Requisitos previos

- Flutter SDK instalado
- Dart instalado
- Android Studio o Xcode configurado
- Emulador o dispositivo físico
- Conexión a internet

## Instalación

Clona el repositorio:

```bash
git clone git@github.com:Luis-Vilar/clean_arch_app.git
cd clean_arch_app
```

Instala las dependencias:

```bash
flutter pub get
```

Ejecuta la aplicación:

```bash
flutter run
```

## Observación sobre la arquitectura

Este proyecto está orientado a una estructura clara de Clean Architecture, separando la lógica de negocio, la infraestructura y la capa de presentación. La intención es mantener la lógica de dominio independiente de la UI y de las implementaciones externas, facilitando mantenimiento, pruebas y evolución del proyecto.

## Autor

Proyecto desarrollado con Flutter y arquitectura limpia para practicar la separación de responsabilidades y el desarrollo de apps con capas bien definidas.
Este proyecto nace del refactorizado de *Notitas*, baseado en  *MVVM* y puede consultarse en <https://github.com/Luis-Vilar/M2S07-Mini-Projeto-Avaliativo>

### Luis Vilar
