import { Center, Image } from '@mantine/core';
import useSoilContext, { SoilContextType } from 'contexts/SoilContext';
import React, { useState } from 'react';
import { useEffect } from 'react';

export default function PreviewImage() {
    const { file, classify }: SoilContextType = useSoilContext();
    const [imgSrc, setImgSrc] = useState<any>("");

    useEffect(() => {
        if (!file) return;
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onloadend = () => {
            if (!reader.result) return;
            const base64Image = reader.result;
            setImgSrc(base64Image);
            classify();
        };
    }, [file, classify]);

    return (
        <Center style={{ height: '250px', overflow: 'hidden' }}>
            <Image src={imgSrc} alt='soil image' withPlaceholder />
        </Center>
    );
}
