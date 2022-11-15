import { NextApiRequest, NextApiResponse } from "next";

export function CheckFields (req: NextApiRequest, fields: string[], res: NextApiResponse ) {
    for (const field of fields) {
	if (!req.body[field]) {
	    return res.status(400).json({message: `${field} is missing in request body, suppose to has [${fields}]`});
	}
    }
    return true;
}