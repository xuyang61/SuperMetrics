import type { NextApiRequest, NextApiResponse } from 'next';
import { validateToken } from '../../modules/persistence/auth';
import { deleteKitty } from '../../modules/persistence/kitties';

export default function handler(
    req: NextApiRequest,
    res: NextApiResponse<unknown>
) {
    const { method } = req;

    if (method !== 'DELETE') {
        res.status(405).end();
        return;
    }

    const { authorization } = req.headers;
    const token = authorization?.replace('Bearer', '').trim();

    if (!authorization || !token || !validateToken(token)) {
        res.status(401).end();
    } else {
        const { name } = req.query;

        if (!name) {
            res.status(400).json({
                error: "Required parameter 'name' missing",
            });
            return;
        }

        if (!deleteKitty(Array.isArray(name) ? name[name.length - 1] : name)) {
            res.status(400).json({
                error: 'Unknown kitty requested to be deleted',
            });
            return;
        }

        res.status(200).end();
    }
}
