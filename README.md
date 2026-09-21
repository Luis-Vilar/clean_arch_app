# Clean Arch App (Notitas)

Aplicación mobile en Flutter para gestión de tareas, basada en arquitectura limpia (Clean Architecture) con separación clara entre dominio, infraestructura y presentación.

## Descripción

Este proyecto mantiene la lógica de negocio desacoplada de la capa de UI y de las fuentes de datos, facilitando mantenimiento, pruebas y evolución del sistema. La app permite:

- Iniciar sesión con la API pública de DummyJSON
- Mantener la sesión del usuario con `SharedPreferences`
- Consultar y sincronizar tareas
- Crear, actualizar, eliminar y listar tareas
- Persistir datos localmente con SQLite
- Filtrar tareas por estado y texto
- Gestionar estados con `flutter_bloc`
- Inyectar dependencias con `GetIt`

## Stack tecnológico

- Flutter
- Dart
- BLoC / flutter_bloc
- Dio
- SQLite / sqflite
- SharedPreferences
- GetIt
- Clean Architecture
- Result pattern

## Arquitectura del proyecto

La estructura del proyecto sigue una organización basada en capas:

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
│   │   │   ├── auth.dart
│   │   │   ├── http_client.dart
│   │   │   ├── shared_preferences_interface.dart
│   │   │   ├── todo_repository_interface.dart
│   │   │   └── todo_source_interface.dart
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
│   │   │   │   ├── shared_preferences.dart
│   │   │   │   └── todo_database.dart
│   │   │   └── remote/
│   │   │       ├── auth_source.dart
│   │   │       ├── http_client_dio.dart
│   │   │       └── todo_source.dart
│   │   ├── models/
│   │   │   ├── todo_model.dart
│   │   │   └── user_model.dart
│   │   └── repositories/
│   │       └── todo_repository.dart
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
└── assets/
    └── images/
        └── logo.png
```

## Capas de la aplicación

### 1. Dominio

Contiene la lógica pura del negocio y las reglas principales del sistema:

- Entidades: `TodoEntity`, `UserEntity`
- Interfaces: contratos para repositorios, autenticación, fuente de datos y cliente HTTP
- Casos de uso: login, sesión, lectura, creación, actualización y sincronización de TODOs

### 2. Infraestructura

Encapsula la implementación de tecnologías externas y adaptadores:

- Fuentes remotas: `AuthSource`, `TodoSource`, `HttpClientDio`
- Fuentes locales: `TodoDatabase`, `SharedPreferences`
- Modelos de datos: conversiones entre JSON y entidades
- Repositorios: coordinación entre datos remotos y locales

### 3. Presentación

Se encarga de la UI y del manejo de estados del usuario:

- Vistas: `SplashView`, `LoginView`, `LoggedView`
- Componentes reutilizables de formulario, filtros y diálogos
- BLoCs: `LoginBloc` y `TodosBloc`

## Flujo de la aplicación

```text
Inicio
  ↓
SplashView
  ↓
Verifica sesión almacenada
  ├── Sí hay sesión → LoggedView
  └── No hay sesión → LoginView
             ↓
      Login con DummyJSON
             ↓
      Guardado de sesión
             ↓
      Carga de tareas
             ↓
      Sincronización local + UI
```

## Patrones implementados

- Clean Architecture
- Repository pattern
- Use cases
- Dependency injection con `GetIt`
- Result pattern para manejar errores de forma centralizada
- BLoC para gestión de estado
- SQLite para persistencia local
- SharedPreferences para sesión

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

- Autenticación con usuario y contraseña
- Validación de formulario
- Guardado de sesión persistente
- Listado de tareas con filtros
- Búsqueda por texto
- Creación de nuevas tareas
- Marcado de tareas como completadas
- Eliminación local de tareas ya concluidas
- Sincronización desde la API y persistencia local en SQLite
- Manejo de errores con mensajes en la UI
- Botón de reintento cuando falla la carga de tareas

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

Ejecuta la app:

- Inicializa el emulador de tu preferencia o conecta tu dispositivo físico en modo dev previamente, luego ejecuta en la terminal :

```bash
flutter run
```

## Observación sobre la arquitectura

Este proyecto nace del refactorizado de Notitas con enfoque en Clean Architecture para separar responsabilidades del negocio, las fuentes de datos y la presentación, manteniendo el uso de BLoC para la gestión de estado en la capa de UI. el proyecto anterior basado en MVVM puede consultarse en <https://github.com/Luis-Vilar/M2S07-Mini-Projeto-Avaliativo>.

## Autor

Proyecto desarrollado como parte de una práctica de desarrollo mobile con Flutter, aplicando arquitectura limpia y patrones modernos de diseño.

### Luis Vilar
