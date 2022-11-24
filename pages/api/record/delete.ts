import { NextApiRequest, NextApiResponse } from "next";
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
        if (record) {
            try {
                await db.run(
                    `DELETE FROM RECORD WHERE rec_id=${record.rec_id}`
                );
                return res.status(200).json({
                    errCode: 0,
                    errMessage: "Delete succeed!",
                });
            } catch (e) {
                console.log(">>ERROR: ", e);
            }
        } else {
            return res.status(200).json({
                errCode: 2,
                errMessage: "This record don't exist!",
            });
        }
    } else {
        return res.status(200).json({
            errCode: 1,
            errMessage: "You missing request id Record",
        });
    }
}
