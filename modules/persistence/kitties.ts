import { readFile, writeFile, copyFile } from 'fs/promises';
import { existsSync } from 'fs';
import path from 'path';
import { Kitty } from '../../types/Kitty';

// Bleeding-edge persistence layer

// TODO: better image storage

const defaultDataPath = path.resolve('./public/initial_data.json');

const dataPath = path.resolve('./public/data.json');

export const readKitties = async (): Promise<Kitty[]> =>
    await ensureKitties()
        .then(() => readFile(dataPath))
        .then((content) => JSON.parse(content.toString()));

export const writeKitties = async (kitties: Kitty[]) =>
    await writeFile(dataPath, JSON.stringify(kitties));

export const ensureKitties = async () => {
    if (!existsSync(dataPath)) {
        await resetKitties();
    }

    return Promise.resolve();
};

export const resetKitties = async () => copyFile(defaultDataPath, dataPath);

export const deleteKitty = async (name: string): Promise<boolean> => {
    const initialData = await readKitties();

    const filtered = initialData.filter((kitty) => kitty.name !== name);

    if (filtered.length === initialData.length) {
        return false;
    }

    await writeKitties(filtered);

    return true;
};