import { Group, Text, useMantineTheme, MantineTheme } from '@mantine/core';
import { Upload, Photo, X, Icon as TablerIcon } from 'tabler-icons-react';
import { Dropzone, DropzoneStatus, IMAGE_MIME_TYPE } from '@mantine/dropzone';
import { useCallback } from 'react';
import useSoilContext, { SoilContextType } from 'contexts/SoilContext';
import PreviewImage from 'components/PreviewImage';

function getIconColor(status: DropzoneStatus, theme: MantineTheme) {
    return status.accepted
        ? theme.colors[theme.primaryColor][theme.colorScheme === 'dark' ? 4 : 6]
        : status.rejected
            ? theme.colors.red[theme.colorScheme === 'dark' ? 4 : 6]
            : theme.colorScheme === 'dark'
                ? theme.colors.dark[0]
                : theme.colors.gray[7];
}

function ImageUploadIcon({
    status,
    ...props
}: React.ComponentProps<TablerIcon> & { status: DropzoneStatus; }) {
    if (status.accepted) {
        return <Upload {...props} />;
    }

    if (status.rejected) {
        return <X {...props} />;
    }

    return <Photo {...props} />;
}

export const DropzoneChildren = (status: DropzoneStatus, theme: MantineTheme) => {
    const { file }: SoilContextType = useSoilContext();

    if (file) return <PreviewImage />;
    else return (
        <Group position="center" spacing="xl" style={{ minHeight: 220, pointerEvents: 'none' }}>
            <ImageUploadIcon status={status} style={{ color: getIconColor(status, theme) }} size={80} />

            <div>
                <Text size="xl" inline align='center'>
                    Drag image here or click to select file
                </Text>
                <Text size="sm" color="dimmed" inline mt={7} align='center'>
                    Attach a clean and clear photo of your soil about 12 inches from the ground
                </Text>
            </div>
        </Group>
    );
};

export default function ImageDragDrop() {
    const theme = useMantineTheme();
    const { setFile, classifying, file }: SoilContextType = useSoilContext();

    const handleDragDrop = useCallback((files: File[]) => {
        setFile(files[0]);
    }, [setFile]);

    return (
        <>
            <Dropzone
                loading={classifying}
                multiple={false}
                onDrop={handleDragDrop}
                onReject={(files) => console.log('rejected files', files)}
                maxSize={3 * 1024 ** 2}
                accept={IMAGE_MIME_TYPE}
            >
                {(status) => DropzoneChildren(status, theme)}
            </Dropzone>
            {file && <Text style={{ fontStyle: 'italic' }}> Tip: tap the image to select another or drag and drop on the area </Text>}
        </>
    );
}