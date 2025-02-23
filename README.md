# Voyage Visage - Travel Blogging App

## 📌 Overview
Voyage Visage is a **Flutter-based travel blogging app** that allows users to **document, share, and explore** travel experiences. With Firebase integration, users can post blogs, upload images.

## 🚀 Features
- 🔐 **User Authentication** (Sign-up, Login via Firebase Auth)
- 📝 **Blog Creation** (Text & Image-based blogging)
- 📸 **Image Uploads** (Stored on Firebase Storage)
- 🔄 **Real-time Updates** (Firestore syncs instantly)
- 🌍 **Explore Blogs** (View posts from other travelers)
- 🏕 **Profile Management** (Edit user details & blogs)

## 🖥 Tech Stack
- **Frontend:** Flutter, Dart
- **Backend:** Firebase (Auth, Firestore, Storage, Cloud Functions)
- **State Management:** Provider
- **Other Tools:** Git, Firebase Cloud Messaging (FCM)

## 📸 Screenshots
![Home Screen](Screenshot_20250223_201424.png)
![Blog Post](Screenshot_20250223_201432.png)
![Profile Page](Screenshot_20250223_201439.png)

## 🛠 Setup & Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/sbfrusho/Voyage-Visage.git
   cd Voyage-Visage
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
   - Create a Firebase project.
   - Enable Authentication, Firestore, and Storage.
   - Download and place `google-services.json` (Android) & `GoogleService-Info.plist` (iOS) in respective directories.
4. Run the app:
   ```sh
   flutter run
   ```

## 💡 Challenges & Solutions
### 📸 Efficient Image Uploads
- **Issue:** Large image files slowed down uploads.
- **Solution:** Implemented Firebase Storage with compression for faster uploads.

### 🔄 Real-time Blog Updates
- **Issue:** Posts were not updating instantly.
- **Solution:** Used Firestore snapshots for real-time data synchronization.

### 💬 Managing User Engagement
- **Issue:** Users wanted **comments and likes**.
- **Solution:** Built an interactive **comment system** with Firestore updates.

## 👨‍💻 Author
Developed by **Sakib Bin Faruque Rusho**

📧 Contact: [rushocseru28@gmail.com](mailto:rushocseru28@gmail.com)

🔗 GitHub: [sbfrusho](https://github.com/sbfrusho)

Feel free to contribute and report any issues! 🚀
