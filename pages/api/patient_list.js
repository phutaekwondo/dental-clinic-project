import sqlite3 from "sqlite3";

export default async function handler(req, res) {
    // Kiểm tra method của req
    // Chỉ chấp nhận method GET
    if (req.method !== "GET") {
        return res.status(405).json({message: "FAIL"});
    }
    // Kết nối sqlite3
    const db = new sqlite3.Database("./database.sqlite", sqlite3.OPEN_READONLY, (err) => {
        if (err) {
            return res.status(403).json({message: "FAIL"});
        }
    });
    // Bắt lỗi khi query
    try {
        let queryResult = await retrieveData(db);
        return res.status(200).json(queryResult);
    } catch {
        return res.status(403).json({message: "FAIL"});
    } finally {
        // Ngắt kết nối với database
        db.close((err) => {
            if (err) throw err;
        });
    }
    // Nếu thành công thì chương trình sẽ không thể thực thi tới đây do đã return trong khối try catch
    // Nếu tới đây thì nghĩa đoạn code bị lỗi -> return res status 500 internal error
    return res.status(500).json({message: "FAIL"}).end();
}

function retrieveData(db) {
    return new Promise((resolve, reject) => {
        let data = [];
        // Query với cú pháp của sqlite3 (MySQL)
        // ID, tên bệnh nhân, giới tính, ngày sinh, email
        let sql = "SELECT p_id, p_name, p_sex, p_dateOB, p_email FROM PATIENT";
        db.all(sql, (err, rows) => {
            if (err) {
                reject(err);
            }
            // Mỗi element trong array queryResult sẽ chứa 1 JSON về 1 bệnh nhân
            rows.forEach((row) => {
                data.push(row);
            });
            resolve(data);
        });
    });
}