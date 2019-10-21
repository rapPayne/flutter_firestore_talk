
# flutter_firestore_talk

Resources to support Rap's talk "Building a CRUD app for iOS and Android with Flutter and Firestore"

  

# Connect with Rap

- Twitter: [@Rap_Payne](https://twitter.com/Rap_Payne)
- LinkedIn: [RapPayne](https://www.linkedin.com/in/rappayne/)
- Github: [RapPayne](https://github.com/rapPayne)
- Web: AgileGadgets.com

# Instructions
How to get Flutter and Firestore talking

1. [Create the Firebase project](#Creating-the-Firebase-project)
1. [Create the Firestore database](#Creating-the-Firestore-database)
1. [Loading the database with seed data](#loading-the-database-with-seed-data)
1. [Create the Flutter project](#creating-the-flutter-project)
1. [Write the structure of the app](#writing-the-structure-of-the-flutter-app)
1. [Install libraries in the Flutter app](#installing-libraries-in-the-flutter-app)
1. [Write the Read query](#writing-the-read-query)
1. [Connect the Android app to the Firestore database](#connecting-the-android-app-to-the-firestore-database)
1. [Write the database delete](#writing-the-database-delete)
1. [Write the Upsert](#writing-the-upsert) (Create plus Update)
1. [Connect the iOS app to the Firestore database](#connecting-the-ios-app-to-firestore)

## Creating the Firebase project
Coming soon!

## Creating the Firestore database
Coming soon!

## Loading the database with seed data
There is a fantastic and free API service that will provide realistic-looking but fake randomized JSON data that looks like users -- [RandomUser.me](https://randomuser.me/documentation). We're using their API to load the database.

The Node script to load this data can be found in the [load_people folder](./load_people) in this repository. By default it loads 10 people.

1. Go to your Firebase Console.
2. Go Project overview - project settings
3. Choose the Service Accounts tab
4. Node.js should be chosen already. If not, select it. 
5. Click "Generate new private key" button (lower right).
6. It'll offer to save a file. Save it in your load_people folder. Name it `serviceAccountKey.json`
7. Open a command window.
8. `cd load_people`
9. `node load_people.js`
10. Check back in your Firestore DB browser and you should see 10 new people. 

Run it multiple times to add more people.

## Creating the Flutter project
Coming soon!

## Writing the structure of the app
Coming soon!

## Install libraries in the Flutter app
Coming soon!

## Write the Read query
Coming soon!

## Connect the Android app to the Firestore database
Coming soon!

## Write the database delete
Coming soon!

## Write the Upsert
(Create plus Update)

Coming soon!

## Connecting the iOS app to Firestore
Coming soon!

> Written with [StackEdit](https://stackedit.io/).
