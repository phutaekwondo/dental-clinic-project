import { NextApiRequest, NextApiResponse } from "next";
import { GetDatabase } from "../../../helpers/database/database-helper.mjs";
export default async function handleUpdateRecord(
    req: NextApiRequest,
    res: NextApiResponse
) {
    //check fields
    const db = await GetDatabase();
    let {
        patient_id,
        rec_dease,
        rec_desc,
        rec_indiagnose,
        rec_outdiagnose,
        rec_conclusion,
    } = req.body;
    if (
        !patient_id ||
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
    } else {
        let appointment = await db.get(
            `SELECT * FROM APPOINTMENT WHERE p_id=${patient_id}`
        );
        if (appointment) {
            let record = {};
            record = await db.get(
                `SELECT * FROM RECORD WHERE appoint_id=${appointment.appoint_id}`
            );
            if (record) {
                await db.run(`
                UPDATE RECORD 
                SET rec_dease=${rec_dease},
                rec_desc=${rec_desc},
                rec_indiagnose=${rec_indiagnose},
                rec_outdiagnose=${rec_outdiagnose},
                rec_conclusion=${rec_conclusion} 
                WHERE appoint_id = ${appointment.appoint_id}`);
            }
            record = await db.get(
                `SELECT * FROM RECORD WHERE appoint_id=${appointment.appoint_id}`
            );
            return res.status(200).json({
                errCode: 0,
                errMessage: "OK",
                record,
            });
        } else {
            return res.status(200).json({
                errCode: 2,
                errMessage: "Not found this patient!",
            });
        }
    }
}
