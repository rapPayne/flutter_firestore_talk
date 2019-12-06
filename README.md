# flutter_firestore_talk
Resources to support Rap's talk "Building a CRUD app for iOS and Android with Flutter and Firestore"

# Connect with Rap
I'd love to connect with you to provide any help I can with learning Flutter. Please reach out.
- Twitter: [@Rap_Payne](https://twitter.com/Rap_Payne)
- LinkedIn: [RapPayne](https://www.linkedin.com/in/rappayne/)
- Github: [RapPayne](https://github.com/rapPayne)
- Web: AgileGadgets.com

# Instructions
How to get Flutter and Firestore talking. These step-by-step instructions are specifically for the project in this repository, but are generally true for any Flutter project that uses Firestore. Before you begin, you might want to make sure you have the [prerequisites](#Prerequisites).

1.  [Create the Firebase project](#Creating-the-Firebase-project)
1.  [Create the Firestore database](#Creating-the-Firestore-database)
1.  [Loading the database with seed data](#loading-the-database-with-seed-data)
1.  [Create the Flutter project](#creating-the-flutter-project)
1.  [Write the structure of the app](#writing-the-structure-of-the-flutter-app)
1.  [Install libraries in the Flutter app](#installing-libraries-in-the-flutter-app)
1.  [Write the Read query](#writing-the-read-query)
1.  [Connect the Android app to the Firestore database](#connecting-the-android-app-to-the-firestore-database)
1.  [Write the database delete](#writing-the-database-delete)
1.  [Write the Upsert](#writing-the-upsert) (Create plus Update)
1.  [Connect the iOS app to the Firestore database](#connecting-the-ios-app-to-firestore)

## Creating the Firebase project
1. Log in to Google and point your browser at https://console.firebase.google.com
2. Click "Add project". Give it a name.
3. Say "No" to analytics for now. This'll keep it simple and we can add analytics later if you like.

## Creating the Firestore database
1. Still in the Firebase console in your new project, on the left panel you should see "Database". Click it.
2. Click "Create database"
3. Choose to "Start in test mode" and click "Enable"

At this point, you have a database with no collections (tables) or records (documents). Let's add them.

## Loading the database with seed data
There is a fantastic and free API service that will provide realistic-looking but fake randomized JSON data that looks like users -- [RandomUser.me](https://randomuser.me/documentation). We're using their API to load the database.

  The Node script to load this data can be found in the [load_people folder](./load_people) in this repository. By default it loads 10 people.
  
1. Go to your Firebase Console.
2. Go Project overview - Project settings
3. Choose the Service Accounts tab
4. Node.js should be chosen already. If not, select it.
5. Click "Generate new private key" button (lower right).
6. It'll offer to save a file. Save it in your load_people folder. Name it `serviceAccountKey.json`
7. Open a command window.
8.  `cd load_people`
9.  `node load_people.js`
10. Check back in your Firestore DB browser and you should see ten new people.
11. Run it with a command line arg to specify the number of people. eg. `node load_people.js 17` will load 17 more people.

## Creating the Flutter project
1. Open a command window
2.  `flutter create --androidx my_app`

## Writing the structure of the app
We'll have two views (aka widgets); one to list all the people and one to add/update a person. These are already pre-written for you.

1. Open the project in an IDE.
2. Look in the lib folder. You'll see main.dart.
3. Delete the pre-created MyApp component.
4. Add a new stateless component called PeopleMaintenance. It should look like [this](./solution/lib/main.dart).
5. Copy [PeopleList.dart](./starters/PeopleList.dart) and [PeopleUpsert.dart](./starters/PeopleUpser.dart) from the starters folder to your lib folder alongside main.dart.
  
If you run at this point, it should work, just not show any people yet.

## Install libraries in the Flutter app
We can connect to Firestore manually by brute force, but Google has published a couple of libraries to make it easier. Let's go get them.
1. Edit pubspec.yaml in the root of your Flutter project
2. Add these lines under the dependencies section
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^0.4.2+1
  cloud_firestore: ^0.12.11
```
3. Save it.
4. If your IDE doesn't automatically do it, run `flutter pub get` in a command window.

Find the latest version numbers of these libraries at [https://pub.dev/packages/firebase_core](https://pub.dev/packages/firebase_core) and [https://pub.dev/packages/cloud_firestore](https://pub.dev/packages/cloud_firestore).

## Write the Read query
1. Edit PeopleList.dart. Add this to the top:
```dart
import  'package:cloud_firestore/cloud_firestore.dart'; 
```
3. Make getPeople() look like this:
```dart
Stream<QuerySnapshot> getPeople() {
  return  Firestore
    .instance
    .collection('people')
    .limit(100)
    .snapshots();
}
```
Running it now will still not work because our app doesn't know where the database exists.

## Connect the Android app to the Firestore database
We need to let our Flutter app know where the Firestore database is before it can connect.
1. Open your Firebase console, making sure you're still in your project.
2. Click the "Add App" button.
3. Choose to add an Android app.
4. Set the Android app name to something like 'com.yourcompany.projectname'. This can be anything but remember what you wrote! You'll need to be consistent later on.
5. Set the nickname to whatever you like.
6. Click "Register app"
7. Download the google-services.json file. Save it in the android/app folder under your project's home.

Note that there are two files called `build.gradle`. Your project-level build.gradle file is under android. Your app-level build.gradle file is under android/app.

8. Edit your project-level build.gradle file
9. Add this line to buildscript/dependencies:
```gradle
classpath 'com.google.gms:google-services:4.3.2' // Google Services plugin
```
10. Edit your app-level build.gradle file
11. Find the applicationId key under defaultConfig. Set it to your Android app name from above (eg. com.yourcompany.projectname).
12. Set the minSdkVersion to 21. This fixes [the multidex problem](https://developer.android.com/studio/build/multidex)). Don't ask. Just trust me.
13. Add this line to the bottom:
```gradle
apply plugin: 'com.google.gms.google-services' // Google Play services Gradle plugin
```
14. After saving, run `flutter pub get` from a command window.

At this point, you should be able to run and see all the people you added above in your PeopleList.

## Write the database delete

1. Edit PeopleList.dart
2. Change deletePerson() method to look like this:
```dart
void deletePerson(String documentID) {
  Firestore
    .instance
    .collection('people')
    .document(documentID)
    .delete();
}
```
Now if you click the trashcan icon in the upper-right of each card, it will delete the person.

## Write the Upsert
Firestore considers setting data to be the same whether you're creating a new record or updating an existing one. If you provide a documentID (aka primary key) that points to an existing document (aka record), it updates that record. Otherwise it assumes you want to create/insert a new record.
1. Edit PeopleUpsert.dart.
2. Make the upsertPerson() method look like this:
```dart
savePerson(personMap) {
  Firestore
    .instance
    .collection('people')
    .document(_person?.documentID)
    .setData(personMap)
    .then((foo) =>  print('changed'))
    .catchError((err) =>  print('Error: $err'));
}
```

## Connecting the iOS app to Firestore

This is easier than Android except that you must use Xcode. So if you don't have a Mac, you won't be able to do it. (Thanks, Apple).
1. Open your Firebase console and go to your project's main page.
2. Click "Add app" but this time choose iOS.
3. Add the iOS bundle name which should be the same as the app ID (like com.yourcompany.yourproject).
4. Download GoogleService-Info.plist. Save it anywhere in your project. Just remember where it is.
5. Open Xcode on your Mac.
6. Open the iOS project folder as an Xcode project.
7. Drag GoogleService-Info.plist to Runner/Runner folder in Xcode.
8. Hit the Finish button.
9. Click the top-level Runner folder in Xcode. Properties will appear.
10. Change the Bundle ID to match the app ID from above.
11. Close Xcode

Your app should run just great in an iOS simulator and on iOS devices.

# Other cool sources
- Chapter 12 of my book: [https://www.amazon.com/dp/1484251806/](https://www.amazon.com/dp/1484251806/)
- Google's instructions for adding anything Firebase to your Flutter app: [https://firebase.google.com/docs/flutter/setup](https://firebase.google.com/docs/flutter/setup)

# Prerequisites
To run these labs you'll need ...
1.  [Flutter dev tools](https://flutter.io/get-started/install/) installed
2. An IDE like [VS Code]([https://code.visualstudio.com/](https://code.visualstudio.com/)) or [Android Studio]([https://developer.android.com/studio/](https://developer.android.com/studio/))


> This README written with [StackEdit](https://stackedit.io/).
