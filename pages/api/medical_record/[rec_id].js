import sqlite3 from "sqlite3";


export default async function handler(req, res) {
    // Kiểm tra method của req
    // Chỉ chấp nhận method GET
    if (req.method !== "GET") {
        return res.status(405).json({message: "FAIL"});
    }

    const rec_id = req.query.rec_id;
    
    // Kết nối sqlite3
    const db = new sqlite3.Database("./database.sqlite", sqlite3.OPEN_READONLY, (err) => {
        if (err) {
            return res.status(403).json({message: "FAIL"});
        }
    });
    // Bắt lỗi khi query
    try {
        let queryResult = await retrieveData(db, rec_id);
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


function retrieveData(db, id) {
    return new Promise((resolve, reject) => {
        let queryResult = [];
        // Query với cú pháp của sqlite3 (MySQL)
        let sql = "SELECT R.*, P.p_name, P.p_dateOB, P.p_sex, P.p_ethnic, P.p_address, P.p_BHXH " +
            "FROM RECORD R INNER JOIN APPOINTMENT A ON R.appoint_id = A.appoint_id " +
            " INNER JOIN PATIENT P ON A.p_id = P.p_id WHERE R.rec_id = " + id;
        db.all(sql, (err, rows) => {
            if (err) {
                reject(err);
            }
            // Mỗi element trong array queryResult sẽ chứa 1 JSON về 1 medical record cùng rec_id (mặc dù rec_id là unique)
            rows.forEach((row) => {
                queryResult.push(row);
            });
            resolve(queryResult);
        });
    });
}
