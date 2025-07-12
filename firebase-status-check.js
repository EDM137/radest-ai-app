const path = require('path');
const fs = require('fs');

const firebaseModulePath = path.join(__dirname, 'radest-firebase-server.js');

if (fs.existsSync(firebaseModulePath)) {
  try {
    require(firebaseModulePath);
    console.log('✅ Firebase Status Tool executed successfully.');
  } catch (error) {
    console.error('🔥 Error while executing Firebase tool:', error);
  }
} else {
  console.warn('⚠️ radest-firebase-server.js not found. Running fallback diagnostics...');

  const { exec } = require('child_process');
  exec('firebase projects:list', (err, stdout, stderr) => {
    if (err) {
      console.error('Fallback failed:', stderr);
    } else {
      console.log('Fallback output:\n', stdout);
    }
  });
}
