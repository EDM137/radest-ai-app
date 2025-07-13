import { initializeApp } from 'firebase/app'
import { getAuth } from 'firebase/auth'
import { getFirestore } from 'firebase/firestore'

const firebaseConfig = {
  apiKey: 'YOUR_API_KEY',
  authDomain: 'dev-exchanger-459910-i8.firebaseapp.com',
  projectId: 'dev-exchanger-459910-i8',
  storageBucket: 'dev-exchanger-459910-i8.appspot.com',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  appId: 'YOUR_APP_ID'
}

const app = initializeApp(firebaseConfig)
export const auth = getAuth(app)
export const db = getFirestore(app)
export default app