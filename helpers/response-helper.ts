import { NextApiResponse } from "next";

export function respondWithJson(res: NextApiResponse, code: number, data: any) {
    return res.status(200).json({code: code, data: data});
}