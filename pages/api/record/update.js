import { GetDatabase } from "../../../helpers/database/database-helper.mjs";

const updateRecordController = async (req, res) => {
    try {
        let data = await updateRecordService(JSON.parse(req.body));
        return res.status(200).json(data);
    } catch (e) {
        console.log(">>>ERROR controller: ", e);
        return res.status(200).json("error");
    }
};

const updateRecordService = (inputData) => {
    return new Promise(async (resolve, reject) => {
        try {
            const db = await GetDatabase();
            console.log(">>check req.body: ", inputData);
            let {
                rec_id,
                rec_dease,
                rec_desc,
                rec_indiagnose,
                rec_outdiagnose,
                rec_conclusion,
            } = inputData;
            if (!rec_id) {
                resolve({
                    errCode: 1,
                    errMessage: "You missing a required parameter record id",
                });
            } else {
                let record = {};
                record = await db.get(
                    `SELECT * FROM RECORD WHERE rec_id=${rec_id}`
                );
                if (record) {
                    console.log({ record });
                    let old_rec_dease = record.rec_dease;
                    let old_rec_desc = record.rec_desc;
                    let old_rec_indiagnose = record.rec_indiagnose;
                    let old_rec_outdiagnose = record.rec_outdiagnose;
                    let old_rec_conclusion = record.rec_conclusion;
                    let sql = `UPDATE RECORD SET rec_dease = ?,
                    rec_desc = ?,
                    rec_indiagnose = ?,
                    rec_outdiagnose = ?,
                    rec_conclusion = ?
                    WHERE rec_id = ?`;
                    let data = [
                        `${rec_dease ? rec_dease : old_rec_dease}`,
                        `${rec_desc ? rec_desc : old_rec_desc}`,
                        `${
                            rec_indiagnose ? rec_indiagnose : old_rec_indiagnose
                        }`,
                        `${
                            rec_outdiagnose
                                ? rec_outdiagnose
                                : old_rec_outdiagnose
                        }`,
                        `${
                            rec_conclusion ? rec_conclusion : old_rec_conclusion
                        }`,
                        `${rec_id}`,
                    ];
                    await db.run(sql, data);
                    let result = await db.get(
                        `SELECT * FROM RECORD WHERE rec_id=${rec_id}`
                    );

                    resolve({
                        errCode: 0,
                        errMessage: "OK",
                        record: result,
                    });
                } else {
                    resolve({
                        errCode: 2,
                        errMessage: "This record not found!",
                    });
                }
            }
        } catch (e) {
            reject(e);
        }
    });
};

export default updateRecordController;
