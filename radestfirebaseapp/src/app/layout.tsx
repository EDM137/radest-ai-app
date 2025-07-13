import localFont from 'next/font/local';

const geist = localFont({
  src: [
    {
      path: '/fonts/Geist.woff2',
      weight: '400',
      style: 'normal'
    }
  ],
  variable: '--font-geist'
});

const geistMono = localFont({
  src: [
    {
      path: '/fonts/GeistMono.woff2',
      weight: '400',
      style: 'normal'
    }
  ],
  variable: '--font-geist-mono'
});

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={`${geist.variable} ${geistMono.variable}`}>
      <body>{children}</body>
    </html>
  );
}

