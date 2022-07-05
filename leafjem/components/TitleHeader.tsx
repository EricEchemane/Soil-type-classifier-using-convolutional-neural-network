import { Title, Stack, Text, Container } from '@mantine/core';
import React from 'react';

export default function TitleHeader() {
    return (
        <div style={{
            backgroundColor: "#6c4936",
            padding: '1rem',
            marginBottom: '1.5rem',
        }}>
            <Container>
                <Title order={3} style={{ color: 'white' }}> Pixsoil </Title>
                <Text style={{ color: '#ebebeb' }}>
                    A Soil Classification Model Using CNN
                </Text>
            </Container>
        </div>
    );
}
