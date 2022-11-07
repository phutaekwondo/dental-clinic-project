import sqlite3 from "sqlite3";

export default function handler(req, res) {
    // Kiểm tra method của req
    // Chỉ chấp nhận method GET
    if (req.method !== "GET") {
        res.status(200).json({message: "FAIL"}).end();
        throw new Error("Invalid request method!")
    }
    // Kết nối sqlite3
    const db = new sqlite3.Database("./database.sqlite", sqlite3.Database, (err) => {
        if (err) {
            res.status(200).json({message: "FAIL"}).end();
            throw err;
        }
    });
    // Query với cú pháp của sqlite3 (MySQL)
    // ID, tên bệnh nhân, giới tính, ngày sinh, email
    let sql = "SELECT p_id, p_name, p_sex, p_dateOB, p_email FROM PATIENT";
    let queryResult = [];
    db.all(sql, (err, rows) => {
        if (err) {
            res.status(200).json({message: "FAIL"}).end();
            throw err;
        }
        // Mỗi element trong array queryResult sẽ chứa 1 JSON về 1 bệnh nhân
        rows.forEach((row) => {
            queryResult.push(row);
        });
    });
    // Ngắt kết nối với database
    db.close((err) => {if(err) throw err;});
    res.status(200).json(JSON.stringify(queryResult)).end();
}
