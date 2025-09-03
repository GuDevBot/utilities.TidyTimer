# ✨ TidyTimer - Items List Timer

A simple and elegant app built with Flutter to help you never again forget recurring household chores.

*Replace with a screenshot or GIF of your app.*

---

## 🧹 About the Project

Have you ever asked yourself, "When was the last time I cleaned the air conditioner?" or "Is it time to wash the curtains again?". **TidyTimer** was born to solve exactly this problem.

This app allows you to register household chores, set how often they need to be done, and from there, it manages a countdown timer for each one. With a clean and focused interface, you'll always know which task needs your attention next.

This project was built as a practical exercise, exploring modern Flutter development concepts, from state management with Cubit to data persistence with a local database.

---

## 🚀 Key Features

* **Add Tasks:** Create new tasks with a name, category, and repetition frequency.
* **Automatic Countdown:** Each task displays a "live" timer (e.g., `12d 8h 3min`) for the next due date.
* **Visual Feedback:** Tasks change color to indicate urgency (orange) or overdue status (red).
* **Mark as Done:** When you complete a task, the timer is automatically reset based on the defined frequency.
* **Swipe to Delete:** Manage your list quickly and intuitively.
* **Undo Delete:** Deleted a task by mistake? One click and it's back!
* **Local Persistence:** Your tasks are saved on your device. They'll be there when you close and reopen the app.
* **Dark Theme Support:** The interface is adapted for light and dark modes.

---

## 🔧 Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **State Management:** [flutter_bloc (Cubit)](https://bloclibrary.dev/)
* **Database:** [Hive](https://hivedb.dev/) (A fast, native NoSQL database in Dart)
* **Object Comparison:** [equatable](https://pub.dev/packages/equatable)
* **Helper Dependencies:**
    * `path_provider`: To find the storage path on the device.
    * `build_runner` / `hive_generator`: For automatic code generation.

---

## ⚡ How to Run the Project

Follow the steps below to run the project locally.

### Prerequisites

* You need to have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
* An Android/iOS emulator or a physical device.

### Steps

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/GuDevBot/utilities.TidyTimer.git
    cd TidyTimer
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Generate Hive files (crucial step):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 📁 Project Structure

The project follows a clean folder structure to promote separation of concerns:

```
lib/
|-- cubits/         # Business logic and state management (TaskCubit)
|-- models/         # Data model classes (Task)
|-- screens/        # Widgets representing the app screens
|-- theme/          # Theme configuration (colors, fonts)
|-- widgets/        # Reusable widgets (e.g., CountdownTimer)
|-- main.dart       # Application entry point
```

---

## 💡 Future Improvements

This project has a lot of potential to grow! Some ideas for the future:

* [ ] **Push Notifications** to warn about due tasks.
* [ ] **Categories and Filters** to better organize tasks.
* [ ] **Statistics Screen** to gamify cleaning.
* [ ] **Editing** existing tasks.
* [ ] **Cloud Sync** (Firebase/Supabase) for backup and multi-device use.

---

Made with Flutter.