import { NextApiRequest, NextApiResponse } from "next";
import { CheckFields } from "../../../helpers/request-helper";
import { respondWithJson } from "../../../helpers/response-helper";
import Person from "../../../classes/person.mjs";

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    //check fields
    const checkFieldsResult = CheckFields(req, ["acc_un", "acc_mk"]);
    if (checkFieldsResult !== true) {
        return respondWithJson(res, 0, checkFieldsResult);
    }

    const username = req.body.acc_un;
    const password = req.body.acc_mk;

    const account = await Person.GetAccountByUsername(username);
    if (!account) {
        return respondWithJson(res, 0, "We do not have this account");
    } else {
        if (account.acc_mk === password) {
            return respondWithJson(res, 1, {
                message: "Logged in successfully.",
                role: account.acc_role,
            });
        } else {
            return respondWithJson(res, 0, "Incorrect password");
        }
    }
}
