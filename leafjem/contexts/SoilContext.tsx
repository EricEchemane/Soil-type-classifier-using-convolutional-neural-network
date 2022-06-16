import { useCallback } from "react";
import { createContext, useContext, useState } from "react";

type ResultType = {
    otherClasses: { name: string, value: string; }[];
    Result: string;
    accuracy_score: string;
    accuracy_score_rounded: string;
    soil_type: string;
};

const SoilContext = createContext<any>({});

export default function useSoilContext() {
    return useContext(SoilContext);
}

const backendUrl = 'http://localhost:5000';

export function SoilContextProvider({ children }: any) {
    const [file, setFile] = useState<any>();
    const [result, setResult] = useState<ResultType>();
    const [classifying, setClassifying] = useState<boolean>(false);
    const [hasError, setHasError] = useState<any>(false);

    const classify = useCallback(() => {
        if (!file) return;
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onloadend = async () => {
            const base64Image = reader.result;
            setClassifying(true);
            try {
                const res = await fetch(backendUrl, {
                    method: 'POST',
                    body: JSON.stringify({ base64Image }),
                    headers: { 'Content-Type': 'application/json' },
                });

                if (res.ok) {
                    const data = await res.json();
                    setResult(data);
                } else setHasError(res);
            } catch (error) {
                setHasError(error);
            } finally {
                setClassifying(false);
            }
        };
    }, [file]);

    return (
        <SoilContext.Provider value={{
            file, setFile,
            result, setResult,
            classifying, classify, hasError
        }}>
            {children}
        </SoilContext.Provider>
    );
}

export type SoilContextType = {
    file: any,
    setFile: any,
    result: ResultType,
    classifying: boolean,
    setResult: any,
    classify: any,
    hasError: any;
};