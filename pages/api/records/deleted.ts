import { NextApiRequest, NextApiResponse } from "next";
import { ppid } from "process";
import { GetDatabase } from "../../../helpers/database/database-helper.mjs";

export default async function DeleteRecord(
    req: NextApiRequest,
    res: NextApiResponse
) {
    const db = await GetDatabase();
    if (req.body.rec_id) {
        let record = await db.get(
            `SELECT * FROM RECORD WHERE rec_id=${req.body.rec_id}`
        );
        console.log("arrReCORDS: ", record);
        if (record) {
            try {
                await db.run(
                    `DELETE FROM RECORD WHERE rec_id=${record.rec_id}`
                );
                return res.status(200).json({
                    code: 0,
                    message: "Delete succeed!",
                });
            } catch (e) {
                console.log(">>ERROR: ", e);
            }
        } else {
            return res.status(200).json({
                code: 1,
                message: "This record don't exist!",
            });
        }
    } else {
        return res.status(200).json({
            code: 2,
            message: "You missing request id Record",
        });
    }
}
