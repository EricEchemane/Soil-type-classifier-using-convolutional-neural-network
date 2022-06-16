import '../styles/globals.css';
import type { AppProps } from 'next/app';
import { SoilContextProvider } from 'contexts/SoilContext';

function MyApp({ Component, pageProps }: AppProps) {
  return <>
    <SoilContextProvider>
      <Component {...pageProps} />
    </SoilContextProvider>
  </>;
}

export default MyApp;
