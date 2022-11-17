import sqlite3 from "sqlite3";

export default async function handler(req, res) {
    // Kiểm tra method của req
    // Chỉ chấp nhận method GET
    if (req.method !== "GET") {
        return res.status(405).json({message: "FAIL"});
    }
    // Kiểm tra request đã có id chưa
    if(!req.hasOwnProperty("rec_id"))
    {
        return res.status(403).json({message: "FAIL"});
    }
    // Kết nối sqlite3
    const db = new sqlite3.Database("./database.sqlite", sqlite3.OPEN_READONLY, (err) => {
        if (err) {
            return res.status(403).json({message: "FAIL"});
        }
    });

    let queryResult = await retrieveData(db, req.rec_id);
    // Ngắt kết nối với database
    db.close((err) => {if(err) throw err;});
    return res.status(200).json(queryResult);
}
function retrieveData(db, id)
{
    return new Promise((resolve)=>{
        let queryResult = [];
        // Query với cú pháp của sqlite3 (MySQL)
        // ID, tên bệnh nhân, giới tính, ngày sinh, email
        let sql = "SELECT * FROM RECORD WHERE rec_id = " + id;
        db.all(sql, (err, rows) => {
            if (err) {
                throw err;
            }
            // Mỗi element trong array queryResult sẽ chứa 1 JSON về 1 bệnh nhân
            rows.forEach((row) => {
                queryResult.push(row);
            });
            resolve(queryResult);
        });
    });
}