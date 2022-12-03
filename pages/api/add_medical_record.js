import sqlite3 from "sqlite3";

export default function wrapper(req, res){
    if(req.method === "OPTIONS"){
        return res.status(200).send("ok");
    }
    return handler(req, res);
}

async function handler(req, res) {
    // Kiểm tra method của req
    // Chỉ chấp nhận method POST
    if (req.method !== "POST") {
        return res.status(200).json({message: `FAIL: The request method must be POST, got ${req.method} instead`});
    }
    // Kiểm tra req có những field hợp lệ hay không
    //  Không thể được thiếu dù chỉ 1 field
    const requiredFields = ["d_id"];
    for (let field of requiredFields) {
        if (!req.body.hasOwnProperty(field)) {
            return res.status(200).json({message: `FAIL: The request body does not have ${field} field`});
        }
    }
    // Mở kết nối với database
    const db = new sqlite3.Database("./database.sqlite", sqlite3.OPEN_READWRITE, (err) => {
        if (err) {
            return res.status(200).json({message: "FAIL: Cannot connect to database"});
        }
    });
    // Kiểm tra p_id có tồn tại trong request lẫn database không
    let checkPid;
    let p_id;
    try {
        if (req.body["p_id"] === undefined) {
            checkPid = 0;
            p_id = await countPatientID(db);
            p_id++;
        } else {
            checkPid = await checkPatientRecord(db, req.body["p_id"]);
            p_id = req.body["p_id"];
        }
    } catch (err) {
        db.close();
        return res.status(200).json({message: "FAIL"});
    }
    // Nếu p_id không tồn tại -> insert record mới
    // Ngược lại update trong database theo p_id hiện tại
    if (checkPid === 0) {
        let data = [p_id, req.body["p_dateOB"] || "0",
            req.body["p_sex"] || "Nam", req.body["p_ethnic"] || "", req.body["p_BHXH"] || "", req.body["p_address"] || ""];
        try {
            await insertPatient(db, data);
        } catch (err) {
            db.close();
            return res.status(200).json({message: "FAIL: Cannot connect to database"});
        }
    } else {
        let data = [req.body["p_dateOB"] || "0",
            req.body["p_sex"] || "Nam", req.body["p_ethnic"] || "", req.body["p_BHXH"] || "", req.body["p_address"] || ""];
        try {
            await updatePatient(db, data, p_id);

        } catch (err) {
            db.close();
            return res.status(200).json({message: "FAIL: Cannot connect to database"});
        }

    }
    // Tạo appointment id mới
    let appoint_id;
    try {
        appoint_id = await countAppointID(db);
        appoint_id++;
    } catch (err) {
        db.close();
        return res.status(200).json({message: "FAIL: Cannot connect to database"});
    }
    // Insert new record
    try {
        let data = [appoint_id, "waiting", p_id, req.body["d_id"]];
        await insertAppointment(db, data);
    } catch (err) {
        db.close();
        return res.status(200).json({message: "FAIL: Cannot connect to database"});
    }


    // Thuật toán gán rec_id của API: tính số record có trong table RECORD
    // Sau đó lấy COUNT(*) + 1 = id cho record mới này
    let new_rec_id;
    try {
        new_rec_id = await countRecID(db);
        new_rec_id++;
    } catch (err) {
        db.close();
        return res.status(200).json({message: "FAIL: Cannot connect to database"});
    }
    // Insert vào RECORD table
    try {
        let data = [new_rec_id, req.body["rec_dease"] || ""
            , req.body["rec_indiagnose"] || "", req.body["rec_outdiagnose"] || "",
            req.body["rec_desc"] || "", req.body["rec_conclusion"] || "", req.body["rec_examineday"] || "0",
            req.body["rec_reexamineday"] || "0", appoint_id];
        await insertRecord(db, data);
        return res.status(200).json({message: "SUCCESS"});
    } catch (err) {
        return res.status(200).json({message: "FAIL: Cannot connect to database"});
    } finally {
        db.close();
    }
    // Nếu thành công thì chương trình sẽ không thể thực thi tới đây do đã return trong khối try catch
    // Nếu tới đây thì nghĩa đoạn code bị lỗi -> return res status 500 internal error
    return res.status(500).json({message: "FAIL"}).end();
}

function checkPatientRecord(db, p_id) {
    return new Promise((resolve, reject) => {
        db.all("SELECT COUNT(*) FROM patient WHERE p_id = " + p_id, (err, row) => {
            if (err) {
                reject(err);
            }
            resolve(row[0]["COUNT(*)"]);
        })
    });
}

function insertPatient(db, data) {
    return new Promise((resolve, reject) => {
        db.run("INSERT INTO PATIENT(p_id, p_dateOB, p_sex, p_ethnic, p_BHXH, p_address) VALUES(?, ?, ?, ?, ?, ?)", data, (err) => {
            if (err) {
                reject(err);
            }
            resolve();
        });
    });
}

function updatePatient(db, data, p_id) {
    return new Promise((resolve, reject) => {
        db.run("UPDATE PATIENT SET p_dateOB = ? , p_sex = ? ,p_ethnic = ?, p_BHXH = ?" +
            ", p_address = ? WHERE p_id = " + p_id, (err) => {
            if (err) {
                reject(err);
            }
            resolve();
        });
    });
}

function insertAppointment(db, data) {
    return new Promise((resolve, reject) => {
        db.run("INSERT INTO APPOINTMENT(appoint_id, appoint_status, p_id, d_id) VALUES(?, ?, ?, ?)", data, (err) => {
            if (err) {
                reject(err);
            }
            resolve();
        });
    });
}


function countAppointID(db) {
    return new Promise((resolve, reject) => {
        db.all("SELECT COUNT(*) FROM APPOINTMENT", (err, row) => {
            if (err) {
                reject(err);
            }
            resolve(row[0]["COUNT(*)"]);
        })
    });
}

function countPatientID(db) {
    return new Promise((resolve, reject) => {
        db.all("SELECT COUNT(*) FROM PATIENT", (err, row) => {
            if (err) {
                reject(err);
            }
            resolve(row[0]["COUNT(*)"]);
        })
    });
}

function countRecID(db) {
    return new Promise((resolve, reject) => {
        db.all("SELECT COUNT(*) FROM RECORD", (err, row) => {
            if (err) {
                reject(err);
            }
            resolve(row[0]["COUNT(*)"]);
        })
    });
}

function insertRecord(db, data) {
    return new Promise((resolve, reject) => {
        db.run("INSERT INTO RECORD VALUES(?, strftime('%Y-%m-%d', 'now'), strftime('%Y-%m-%d', 'now'), ?, ?, ?, ?, ?, ?, ?, ?)", data, (err) => {
            if (err) {
                reject(err);
            }
            resolve();
        });
    });
}
