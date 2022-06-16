import { Title, Stack, Text } from '@mantine/core';
import React from 'react';

export default function TitleHeader() {
    return (
        <Stack spacing={0} py={20}>
            <Title order={3}> LeafJem </Title>
            <Text> A Soil Classification Model Using CNN </Text>
        </Stack>
    );
}
