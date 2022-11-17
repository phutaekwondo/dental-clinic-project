import { NextApiRequest, NextApiResponse } from "next";
import Appointment from "../../../classes/appointment.mjs";
import { respondWithJson } from "../../../helpers/response-helper";
import { GetDatabase } from "../../../helpers/database/database-helper.mjs";

export default async function DeleteRecord(
    req: NextApiRequest,
    res: NextApiResponse
) {
    //METHOD POST
    //Check id appointment id by patient id
    const appointment = await Appointment.GetAllAppointmentsByPatientId(
        req.body.patient_id
    );
    if (appointment) {
        const db = await GetDatabase();
        //delete record by appointment id if it's found
        try {
            await db.run(
                `DELETE FROM  RECORD WHERE appoint_id =${appointment[0].id}`
            );
            return res.status(200).json({
                code: 0,
                message: "Delete success!",
            });
        } catch (e) {
            console.log("Error: ", e);
        }
    } else {
        return res.status(200).json({
            code: 1,
            message: "This appointment not found!",
        });
    }
}
