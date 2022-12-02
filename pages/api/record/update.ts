import { NextApiRequest, NextApiResponse } from "next";
import { GetDatabase } from "../../../helpers/database/database-helper.mjs";
export default async function handleUpdateRecord(
    req: NextApiRequest,
    res: NextApiResponse
) {
    //check fields
    let {
        rec_id,
        rec_dease,
        rec_desc,
        rec_indiagnose,
        rec_outdiagnose,
        rec_conclusion,
    } = req.body;
    const db = await GetDatabase();
    try {
        //Kiem tra req.body
        if (
            !rec_id ||
            !rec_dease ||
            !rec_desc ||
            !rec_indiagnose ||
            !rec_outdiagnose ||
            !rec_conclusion
        ) {
            return res.status(200).json({
                errCode: 1,
                errMessage: "Missing parameter!",
            });
        }
        // Tim benh an
        else {
            let record = {};
            record = await db.get(
                `SELECT * FROM RECORD WHERE rec_id=${rec_id}`
            );
            //Neu co thi sua
            if (record) {
                await db.run(`
                    UPDATE RECORD 
                    SET rec_dease=${rec_dease},
                    rec_desc=${rec_desc},
                    rec_indiagnose=${rec_indiagnose},
                    rec_outdiagnose=${rec_outdiagnose},
                    rec_conclusion=${rec_conclusion} 
                    WHERE rec_id = ${rec_id}`);
                let result = await db.get(
                    `SELECT * FROM RECORD WHERE rec_id=${rec_id}`
                );
                return res.status(200).json({
                    errCode: 0,
                    errMessage: "OK",
                    update: result,
                });
            } else {
                //Neu khong co
                return res.status(200).json({
                    errCode: 2,
                    errMessage: "This record doesn't exist!",
                });
            }
        }
    } catch (e) {
        console.log(">>ERROR: ", e);
    }
}
