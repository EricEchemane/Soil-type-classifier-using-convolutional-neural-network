import { Container, Grid } from '@mantine/core';
import Result from 'components/Result';
import ImageDragDrop from 'components/ImageDragDrop';
import TitleHeader from 'components/TitleHeader';
import Head from 'next/head';
import React from 'react';
import FileInfo from 'components/FileInfo';
import { useMediaQuery } from '@mantine/hooks';

// uncomment these lines for debugging
// import { useLogger } from '@mantine/hooks';
// import useSoilContext, { SoilContextType } from 'contexts/SoilContext';

export default function Home() {

  // uncomment these lines for debugging
  // const soilContext: SoilContextType = useSoilContext();
  // useLogger('Soil Context', [soilContext]);

  const smallDevice = useMediaQuery('(max-width: 600px)', false);

  return (
    <>
      <Head> <title> LeafJem - Soil Classification App </title> </Head>

      <Container>

        <TitleHeader />

        <Grid align='stretch'>

          <Grid.Col span={smallDevice ? 12 : 6}>
            <ImageDragDrop />
          </Grid.Col>

          <Grid.Col span={smallDevice ? 12 : 6}>
            <FileInfo />
          </Grid.Col>

          <Grid.Col span={12}>
            <Result />
          </Grid.Col>

        </Grid>

      </Container>
    </>
  );
}
