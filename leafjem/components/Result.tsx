import { Group, Table, Text } from '@mantine/core';
import useSoilContext, { SoilContextType } from 'contexts/SoilContext';
import React from 'react';

export default function Result() {
    const { result, classifying }: SoilContextType = useSoilContext();

    if (classifying) return (<Text weight={500}> Processing... </Text>);
    if (!result) return (<Text weight={500}> No results yet. Select an image first </Text>);

    const tableElements = [
        { name: 'Soil Type', value: result.soil_type },
        { name: 'Rounded accuracy (%)', value: result.accuracy_score_rounded + " %" },
        { name: 'Accuracy', value: result.accuracy_score },
    ];

    const rows = tableElements.map(({ name, value }) => (
        <tr key={name}>
            <td>{name}</td>
            <td>{value}</td>
        </tr>
    ));

    return (
        <>
            <Text weight={700} mb={10}> Model Results: </Text>
            <Table>
                <thead>
                    <tr>
                        <th>Label</th>
                        <th>Values</th>
                    </tr>
                </thead>
                <tbody>
                    {rows}
                    <tr>
                        <td> Other classes </td>
                        <td>
                            {result.otherClasses.map(({ name, value }, index: number) => (
                                <Group key={index}>
                                    <Text
                                        weight={500}
                                        style={{ width: '6ch' }}>
                                        {name}
                                    </Text>
                                    <Text>{value}</Text>
                                </Group>
                            ))}
                        </td>
                    </tr>
                </tbody>
            </Table>
        </>
    );
}
