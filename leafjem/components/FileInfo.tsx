import { Table, Text } from '@mantine/core';
import useSoilContext, { SoilContextType } from 'contexts/SoilContext';
import React from 'react';

export default function FileInfo() {
    const { file }: SoilContextType = useSoilContext();

    if (!file) return <Text> File Info: no file is selected </Text>;
    return (
        <>
            <Text weight={700} mb={10}> File Info: </Text>
            <Table>
                <tbody>
                    <tr>
                        <td>Path</td>
                        <td> {file.path} </td>
                    </tr>
                    <tr>
                        <td>File size</td>
                        <td> {file.size} bytes </td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td> {file.type} </td>
                    </tr>
                </tbody>
            </Table>
        </>
    );
}

// ath: "images (5).jpg";
// lastModified: 1654682057902;
// lastModifiedDate: Wed Jun 08 2022 17: 54: 17 GMT + 0800(China Standard Time) { }
// name: "images (5).jpg";
// size: 50552;
// type: "image/jpeg";
// webkitRelativePath: "";