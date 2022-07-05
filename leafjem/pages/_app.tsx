import '../styles/globals.css';
import type { AppProps } from 'next/app';
import { SoilContextProvider } from 'contexts/SoilContext';

function MyApp({ Component, pageProps }: AppProps) {
  return <>
    <SoilContextProvider>
      <div style={{ backgroundColor: '#f7e7da', minHeight: '100vh' }}>
        <Component {...pageProps} />
      </div>
    </SoilContextProvider>
  </>;
}

export default MyApp;
