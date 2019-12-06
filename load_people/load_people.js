const fetch = require('node-fetch');
const admin = require('firebase-admin');

let serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

let db = admin.firestore();
const firebaseProjectId = db.projectId;
const { argv } = process;
loadRandomPeople(argv[2]);

async function loadRandomPeople(numberOfPeople=10) {
 const url = `http://randomuser.me/api?results=${numberOfPeople}`;
 fetch(url)
  .then(res => res.json())
  .then(res => res.results)
  .then(people => {
   for (let person of people) {
    addPersonToFirestore(person);
   }
  })
  .catch(console.error);
}

function addPersonToFirestore(person) {
 const insertUrl = `https://firestore.googleapis.com/v1/projects/${firebaseProjectId}/databases/(default)/documents/people`;
 db.collection('people')
 .add(person)
 .then(ref => console.log(`Added person ${ref.id} - ${person.name.first} ${person.name.last} `));
}