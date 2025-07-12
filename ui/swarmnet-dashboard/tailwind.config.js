echo '/** @type {import('"'tailwindcss'"').Config} */ export default { content: ["./index.html","./src/**/*.{js,ts,jsx,tsx}"], theme: { extend: {} }, plugins: [] }' > tailwind.config.js

echo 'export default { plugins: { tailwindcss: {}, autoprefixer: {} } }' > postcss.config.js

mkdir -p src

echo '@tailwind base; @tailwind components; @tailwind utilities;' > src/index.css
