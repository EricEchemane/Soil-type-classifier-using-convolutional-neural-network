import { Group, Table, Text } from '@mantine/core';
import useSoilContext, { SoilContextType } from 'contexts/SoilContext';
import soil_props from 'lib/soil_props';
import React from 'react';

export default function Result() {
    const { result, classifying }: SoilContextType = useSoilContext();

    if (classifying) return (<Text weight={500}> Processing... </Text>);
    if (!result) return (<Text weight={500}> No results yet. Select an image first </Text>);

    const tableElements = [
        { name: 'Soil Type', value: result.soil_type },
        { name: 'Accuracy', value: result.accuracy_score_rounded + " %" },
        { name: 'Raw Accuracy', value: result.accuracy_score },
    ];

    const rows = tableElements.map(({ name, value }) => (
        <tr key={name}>
            <td>{name}</td>
            <td>{value}</td>
        </tr>
    ));

    const props = soil_props.find((prop) => prop.name === result.soil_type);

    return (
        <>
            <Text weight={700} mb={10}> Model Results: </Text>
            <Table striped>
                <thead>
                    <tr>
                        <th>Label</th>
                        <th>Values</th>
                    </tr>
                </thead>
                <tbody>
                    {rows}
                    {
                        Object.entries(props || []).map((prop, index) => {
                            if (prop[0] === "name") return null;
                            return <tr key={index}>
                                <td>{prop[0]}</td>
                                <td>{prop[1]}</td>
                            </tr>;
                        })
                    }
                </tbody>
            </Table>
        </>
    );
}
