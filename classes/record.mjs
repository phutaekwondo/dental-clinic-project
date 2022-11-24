import { GetDatabase } from "../helpers/database/database-helper.mjs";

// a class Record has all properties in Record table
export default class Record {
    //constructor
    constructor(
        rec_id,
        rec_date,
        rec_lastmodified,
        rec_dease,
        rec_desc,
        rec_indiagnose,
        rec_outdiagnose,
        rec_description,
        rec_conclusion,
        rec_examineday,
        rec_reexamineday,
        appoint_id
    ) {
        this.rec_id = rec_id;
        this.rec_date = rec_date;
        this.rec_lastmodified = rec_lastmodified;
        this.rec_dease = rec_dease;
        this.rec_desc = rec_desc;
        this.rec_indiagnose = rec_indiagnose;
        this.rec_outdiagnose = rec_outdiagnose;
        this.rec_description = rec_description;
        this.rec_conclusion = rec_conclusion;
        this.rec_examineday = rec_examineday;
        this.rec_reexamineday = rec_reexamineday;
        this.appoint_id = appoint_id;
    }

    // Database method
    async InsertRecordToDatabase() {
        var db = await GetDatabase();
        //check if username already exists
        var record = await db.get("SELECT * FROM RECORD WHERE rec_id = ?", [
            this.rec_id,
        ]);
        if (record) {
            return "rec_id already exists";
        }

        //insert RECORD to RECORD table
        try {
            var result = await db.run(
                "INSERT INTO RECORD (rec_id, rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_description, rec_conclusion, rec_examineday, rec_reexamineday, appoint_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                [
                    this.rec_id,
                    this.rec_date,
                    this.rec_lastmodified,
                    this.rec_dease,
                    this.rec_desc,
                    this.rec_indiagnose,
                    this.rec_outdiagnose,
                    this.rec_description,
                    this.rec_conclusion,
                    this.rec_examineday,
                    this.rec_reexamineday,
                    this.appoint_id,
                ]
            );
        } catch {
            return "somthing wrong";
        }

        return true;
    }

    async GetRecordFromDatabase(rec_id) {
        var db = await GetDatabase();

        var rec = await db.get(`select * from RECORD where rec_id = ?`, rec_id);
        if (rec) {
            this.rec_id = rec[rec_id];
            this.rec_date = rec[rec_date];
            this.rec_lastmodified = rec[rec_lastmodified];
            this.rec_dease = rec[rec_dease];
            this.rec_desc = rec[rec_desc];
            this.rec_indiagnose = rec[rec_indiagnose];
            this.rec_outdiagnose = rec[rec_outdiagnose];
            this.rec_description = rec[rec_description];
            this.rec_conclusion = rec[rec_conclusion];
            this.rec_examineday = rec[rec_examineday];
            this.rec_reexamineday = rec[rec_reexamineday];
            this.appoint_id = rec[appoint_id];
            return true;
        } else {
            return "record not found";
        }
    }

    static async GetDataFor_RecordsOfPatientAPI(p_id) {
        var db = await GetDatabase();

        var data = await db.all(
            "select * from PATIENT as p join APPOINTMENT as ap on p.p_id = ap.p_id join Record as rec on rec.appoint_id = ap.appoint_id join DOCTOR as d on d.d_id = ap.d_id where p.p_id = ?",
            p_id
        );

        if (!data[0]) {
            return "p_id not found";
        } else if (!data[0].rec_id) {
            return "rec_id not found";
        } else if (!data[0].d_id) {
            return "d_id not found";
        } else {
            var rs = [];
            for (let i = 0; i < data.length; i++) {
                rs.push({
                    rec_id: data[i].rec_id,
                    rec_dease: data[i].rec_dease,
                    d_name: data[i].d_name,
                    rec_date: data[i].rec_date,
                    rec_lastmodified: data[i].rec_lastmodified,
                });
            }
            return rs;
        }
    }
}
