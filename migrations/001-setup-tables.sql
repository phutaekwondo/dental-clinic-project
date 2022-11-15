/* 
    LIST 
        1. CREATE statment             ............................. 17
        2. DELETE and UPDATE statement ............................. 148
        3. INSERT statement            ............................. 161
        4. QUERY statement             ............................. 204
*/

/* 1. CREATE TABLE */
CREATE TABLE ACCOUNT(
    acc_un TEXT PRIMARY KEY, 
    acc_mk TEXT NOT NULL,
    acc_avatar TEXT,    --URL of image
    acc_role TEXT NOT NULL CHECK(acc_role IN ('admin', 'doctor', 'patient'))
);

CREATE TABLE DOCTOR(
    d_id INTEGER PRIMARY KEY AUTOINCREMENT,
    d_name TEXT NOT NULL, 
    d_dateOB INTEGER,
    d_sex TEXT CHECK(d_sex IN ('Nam','Nữ')),
    d_phnu TEXT, 
    d_email TEXT,
    d_position TEXT CHECK(d_position IN ('Nhân viên','Trưởng khoa')), 
    d_salr REAL,
    d_odate INTEGER,  --Ngày nhậm chức
    d_edate INTEGER,  --Ngày nghỉ việc
    acc_un INTEGER NOT NULL,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un)
);
CREATE TABLE ADMIN(
    a_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    a_name TEXT NOT NULL,
    a_dateOB INTEGER, 
    a_sex TEXT CHECK(a_sex IN ('Nam','Nữ')), 
    a_phnu TEXT, 
    a_email TEXT,
    a_salr REAL, 
    a_odate INTEGER, 
    a_edate INTEGER, 
    acc_un INTEGER NOT NULL,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNt(acc_un)
);
CREATE TABLE PATIENT(
    p_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    p_name TEXT NOT NULL,
    p_dateOB INTEGER, 
    p_sex TEXT CHECK(p_sex IN ('Nam','Nữ')), 
    p_ethnic TEXT,
    p_BHXH TEXT,
    p_phnu TEXT, 
    p_email TEXT,
    p_type TEXT NOT NULL CHECK(p_type IN ('Thường','Vip')), 
    acc_un INTEGER,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un)
);

CREATE TABLE BLOG(
    b_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    b_date INTEGER NOT NULL, 
    b_topic TEXT NOT NULL, 
    b_head TEXT,
    b_body TEXT
);
CREATE TABLE SERVICE(
    s_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    s_name TEXT NOT NULL, 
    s_type TEXT, 
    s_desc TEXT, 
    s_price REAL, 
    s_oday INTEGER, 
    s_eday INTEGER, 
    s_otime INTEGER, 
    s_etime INTEGER
);
CREATE TABLE MEDICINE(
    m_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    m_name TEXT NOT NULL, 
    m_price TEXT NOT NULL, 
    m_orig TEXT, 
    m_func TEXT, 
    m_amnt TEXT,
    m_unit TEXT CHECK(m_unit IN ('viên','vỉ','hộp'))
);

CREATE TABLE BLOG_AUTHOR(
    d_id INTEGER, 
    b_id INTEGER,
    FOREIGN KEY (d_id) REFERENCES DOCTOR(d_id),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id),
    PRIMARY KEY (d_id, b_id)
);
CREATE TABLE COMMENT(
    acc_un TEXT NOT NULL, 
    b_id INTEGER NOT NULL, 
    c_content TEXT, 
    c_time INTERGER,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id)
);
CREATE TABLE BUY_LIST(
    p_id INTEGER, 
    m_id INTEGER, 
    buy_day INTEGER, 
    amount INTEGER, 
    price REAL,
    PRIMARY KEY (p_id,m_id),
    FOREIGN KEY (p_id) REFERENCES PATIENT(p_id),
    FOREIGN KEY (m_id) REFERENCES MEDICINE(m_id)
);
CREATE TABLE APPOINTMENT(
    appoint_id INTEGER PRIMARY KEY AUTOINCREMENT,
    p_id INTEGER, 
    d_id INTEGER, 
    s_id INTEGER, 
    meet_day INTEGER,
    meet_otime INTEGER, 
    meet_etime INTEGER, 
    meet_place TEXT, 
    meet_room TEXT, 
    meet_desc TEXT,
    FOREIGN KEY (p_id) REFERENCES PATIENT(p_id),
    FOREIGN KEY (d_id) REFERENCES DOCTOR(d_id),
    FOREIGN KEY (s_id) REFERENCES SERVICE(s_id)
);

CREATE TABLE RECORD(
    rec_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    rec_date INTEGER,
    rec_lastmodified INTEGER,
    rec_dease TEXT, 
    rec_desc TEXT, 
    appoint_id INTEGER NOT NULL,
    FOREIGN KEY (appoint_id) REFERENCES APPOINTMENT(appoint_id)
);

CREATE TABLE RECORD_DETAIL(
    recDet_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recDet_indiagnose TEXT,  --chẩn đoán lúc vào viện
    recDet_outdiagnose TEXT,  --chẩn đoán lúc ra viện
    recDet_description TEXT,
    recDet_conclusion TEXT,
    recDet_examineday INTEGER, --ngày khám
    recDet_reexamineday INTEGER, --ngày tái khám--
    rec_id INTEGER NOT NULL,
    FOREIGN KEY (rec_id) REFERENCES RECORD(rec_id)
);
/* 2.DELETE TABLE, ROW */
    -- a. DELETE TABLE
        /*
            PRAGMA foreign_keys = OFF;    --turn off all foreign key 
            DROP TABLE ...;               --delete table
            PRAGMA foreign_keys = ON;     --turn on all foreign key 
        /*
    -- b. DELETE ROW
        /*
            DELETE FROM ...;                --delete all rows
            DELETE FROM ... WHERE ...;      --delete chosen row  
        */
    -- c. UPDATE ROWS 
        /*
            UPDATE {table} SET {field = ?} WHERE {condition}; 
        */

/* 3. INSERT ROW */
-- a. ACCOUNT 
INSERT INTO ACCOUNT VALUES('xuan_truong','xuantruong123', '/assets/oggy.png', 'doctor');
INSERT INTO ACCOUNT VALUES('duy_manh','duymanh123', '/assets/jack.png', 'doctor');
INSERT INTO ACCOUNT VALUES('huyen_trang','huyentrang123', '/assets/olivia.png', 'doctor');
INSERT INTO ACCOUNT VALUES('xuan_nhat','xuannhat123', '/assets/bob.png', 'doctor');
INSERT INTO ACCOUNT VALUES('thu_thuy','thuthuy123', '/assets/dodo.png', 'doctor');

INSERT INTO ACCOUNT VALUES('quang_khai','quangkhai123', '/assets/joey.png', 'admin');
INSERT INTO ACCOUNT VALUES('the_duong','theduong123', '/assets/desert.png', 'admin');

INSERT INTO ACCOUNT VALUES('anh_tuyet','anhtuyet123', '/assets/jack.png', 'patient');
INSERT INTO ACCOUNT VALUES('gia_loc','gialoc123', '/assets/rainbow.png', 'patient');
INSERT INTO ACCOUNT VALUES('thu_phuong','thuphuong123', '/assets/cat.png', 'patient');
INSERT INTO ACCOUNT VALUES('gia_the','giathe123', '/assets/bird.png', 'patient');
INSERT INTO ACCOUNT VALUES('gia_linh','gialinh123', '/assets/jack.png', 'patient');

--SELECT * FROM ACCOUNT;

-- b. DOCTOR
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Xuân Trường', STRFTIME('%d/%m/%Y', '1983-07-25'), 'Nam', '0921954763', 'xuantruong@gmail.com', 'Nhân viên', 10500000, NULL, NULL, 'xuan_truong');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Duy Mạnh', STRFTIME('%d/%m/%Y', '1990-03-04'), 'Nam', '0919233458', 'duymanh@gmail.com', 'Nhân viên', 9500000, NULL, NULL, 'duy_manh');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Lê Thị Huyền Trang', STRFTIME('%d/%m/%Y', '1985-11-14'), 'Nữ', '0188654371', 'huyentrang@gmail.com', 'Nhân viên', 10000000, NULL, NULL, 'huyen_trang');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Phạm Xuân Nhất', STRFTIME('%d/%m/%Y', '1988-02-01'), 'Nam', '092012348', 'xuannhat@gmail.com', 'Trưởng khoa', 15000000, NULL, NULL, 'xuan_nhat');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Thu Thủy', STRFTIME('%d/%m/%Y', '1995-10-02'), 'Nữ', '0891071856', 'thuthuy@gmail.com', 'Nhân viên', 10500000, NULL, NULL, 'thu_thuy');

--SELECT * FROM DOCTOR;

-- c. ADMIN
INSERT INTO ADMIN(a_name, a_dateOB, a_sex, a_phnu, a_email,a_salr, a_odate, a_edate, acc_un) VALUES('Trần Quang Khải', STRFTIME('%d/%m/%Y', '1972-11-13'), 'Nam', '0819655472', 'quangkhai@gmail.com', 8000000, NULL, NULL, 'quang_khai');
INSERT INTO ADMIN(a_name, a_dateOB, a_sex, a_phnu, a_email,a_salr, a_odate, a_edate, acc_un) VALUES('Phạm Thế Dương', STRFTIME('%d/%m/%Y', '1981-04-29'), 'Nam', '0213890776', 'theduong@gmail.com', 9000000, NULL, NULL, 'the_duong');

--SELECT * FROM ADMIN;


-- d. PATIENT
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Lê Anh Tuyết', STRFTIME('%d/%m/%Y', '1982-04-06'), 'Nữ', 'Kinh', NULL, '0927883174', 'anhtuyet@gmail.com', 'Thường', 'anh_tuyet');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Ngô Gia Lộc', STRFTIME('%d/%m/%Y', '2000-12-20'), 'Nam', 'Kinh', NULL, '0924883175', 'gialoc@gmail.com', 'Vip', 'gia_loc');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Trịnh Thu Phương', STRFTIME('%d/%m/%Y', '1983-04-12'), 'Nữ', 'Kinh', NULL, '0927483173', 'thuphuong@gmail.com', 'Thường', 'thu_phuong');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Hồ Gia Thế', STRFTIME('%d/%m/%Y', '1982-06-30'), 'Nam', 'Kinh', NULL, '0927283171', 'giathe@gmail.com', 'Thường', 'gia_the');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Nguyễn Gia Linh', STRFTIME('%d/%m/%Y', '1992-07-31'), 'Nữ', 'Kinh', NULL, '0921233174', 'gialinh@gmail.com', 'Vip', 'gia_linh');

--SELECT * FROM PATIENT;

-- e. BLOG
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2022-10-28'), 'Nhổ răng', 'Nên nhổ răng khi nào', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2020-01-23'), 'Sâu răng', 'Nguyên nhân chủ yếu gây sâu răng', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2012-01-11'), 'Đau miêng', 'Đau miệng có thể là dấu hiệu của bệnh gì', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2010-03-04'), 'Trồng răng', 'Quy trình trồng răng', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2008-12-31'), 'Răng khôn', 'Răng khôn có thực sự khôn ?', NULL);

--SELECT * FROM BLOG;

-- f. SERVICE
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Chăm sóc răng miệng', 'Chữa', 'Làm sạch vi khuẩn khoang miệng, làm trắng răng, giúp răng mạnh khỏe', 3000000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Trồng răng giả', 'Chữa', 'Trồng răng giả, thay răng', 5500000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Tư vấn răng hàm miệng', 'Khám', 'Tư vấn về các vấn đề liên quan đến răng hàm miệng và cách giúp răng luôn khỏe đẹp', 100000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));

--SELECT * FROM SERVICE;

-- g. MEDICINE
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Paracetamon', 50000, 'Đức', 'Giảm đau đầu, chóng mặt, buồn nôn', 30, 'hộp');
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Sensa cool', 30000, 'Chữ viêm lợi, mát gan', 23, 'hộp');
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Yuraf', 30000, 'Nhật', 'Giảm sốt', 10, 'hộp');
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Tramadon', 20000, 'Ý', 'Giảm đau', 53, 'hộp');
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Tiffy', 40000,'Canada', 'Hạ sốt', 8, 'hộp');

--SELECT * FROM MEDICINE;

--SELECT * FROM RECORD;

-- h. BLOG_AUTHOR
--INSERT INTO BLOG_AUTHOR VALUES();

-- i. COMMENT
--INSERT INTO COMMENT VALUES();

-- k. BUY_LIST
--INSERT INTO BUY_LIST VALUES();

-- l. APPOINTMENT
INSERT INTO APPOINTMENT VALUES(1,1,1,1,STRFTIME('%Y-%m-%d', '2020-01-13'),STRFTIME('%H:%M', '17:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(2,2,1,1,STRFTIME('%Y-%m-%d', '2012-12-22'),STRFTIME('%H:%M', '08:00'),STRFTIME('%H:%M', '10:00'), 'BienHoa','501','Khám lợi');
INSERT INTO APPOINTMENT VALUES(3,5,2,1,STRFTIME('%Y-%m-%d', '2010-01-04'),STRFTIME('%H:%M', '09:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','123','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(4,1,3,1,STRFTIME('%Y-%m-%d', '2008-11-13'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(5,5,4,1,STRFTIME('%Y-%m-%d', '2002-02-24'),STRFTIME('%H:%M', '08:30'),STRFTIME('%H:%M', '10:00'), 'BienHoa','111','Nhổ răng');

--SELECT * FROM APPOINTMENT;

-- m. RECORD
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), 'Sâu răng', 'Bệnh nhân 8 tuổi có 1 răng sâu ở miệng bên phải', 1);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2020-12-22 08:30'), STRFTIME('%Y-%m-%d %H:%M','2020-12-22 08:30'), 'Viêm lợi', 'Bệnh nhân 20 tuổi nổi mụn nhọt ở lợi', 2);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2010-01-04 10:00'), STRFTIME('%Y-%m-%d %H:%M','2010-01-04 10:00'), 'Răng lung lay', NULL, 3);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2018-11-13 13:15'), STRFTIME('%Y-%m-%d %H:%M','2018-11-13 13:15'), 'Thay răng', 'Bệnh nhân 50 tuổi trồng răng giả', 4);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2002-02-23 09:05'), STRFTIME('%Y-%m-%d %H:%M','2002-02-23 09:05'), 'Sâu răng', 'Bệnh nhân 12 tuổi có 1 răng sâu ở miệng bên trái', 5);

--n. RECORD_DETAIL
INSERT INTO RECORD_DETAIL(recDet_indiagnose, recDet_outdiagnose, recDet_description,recDet_conclusion ,recDet_examineday , recDet_reexamineday , rec_id) VALUES('Sâu 2 răng hàm','Đã nhổ răng sâu',NULL,'Khỏi bệnh',STRFTIME('%Y-%m-%d','2020-01-13'),NULL,1);
INSERT INTO RECORD_DETAIL(recDet_indiagnose, recDet_outdiagnose, recDet_description,recDet_conclusion ,recDet_examineday , recDet_reexamineday , rec_id) VALUES('Viêm lợi do nóng trong người','Đã cấp thuốc',NULL,'Khỏi bệnh',STRFTIME('%Y-%m-%d','2020-12-22'),NULL,2);
INSERT INTO RECORD_DETAIL(recDet_indiagnose, recDet_outdiagnose, recDet_description,recDet_conclusion ,recDet_examineday , recDet_reexamineday , rec_id) VALUES('Răng cửa bị lung lay','Đã nhổ răng sâu',NULL,'Khỏi bệnh',STRFTIME('%Y-%m-%d','2010-01-04'),NULL,3);
INSERT INTO RECORD_DETAIL(recDet_indiagnose, recDet_outdiagnose, recDet_description,recDet_conclusion ,recDet_examineday , recDet_reexamineday , rec_id) VALUES('Trồng răng giả','Đã trồng 1 răng giả',NULL,'Khỏi bệnh',STRFTIME('%Y-%m-%d','2018-11-13'),NULL,4);
INSERT INTO RECORD_DETAIL(recDet_indiagnose, recDet_outdiagnose, recDet_description,recDet_conclusion ,recDet_examineday , recDet_reexamineday , rec_id) VALUES('Sâu 2 răng hàm','Đã nhổ răng sâu',NULL,'Khỏi bệnh',STRFTIME('%Y-%m-%d','2020-01-13'),NULL,5);

/* 4.QUERY ROWS */
-- a. Query ALL 
    --
    --  SELECT * FROM ...;
    --
    
-- b. ACCOUNT 
-- c. DOCTOR
-- d. ADMIN
-- e. PATIENT
-- f. BLOG
-- g. SERVICE
-- h. MEDICINE
-- i. RECORD
    -- 1. Get records of patient
        SELECT rec_id, rec_dease, d_id, rec_date, rec_lastmodified
        FROM RECORD rec INNER JOIN APPOINTMENT app ON rec.appoint_id = app.appoint_id
        WHERE app.p_id = 1;
        
-- k. BLOG_AUTHOR
-- l. COMMENT
-- m. BUY_LIST
-- n. APPOINTMENT
    -- 1. Get day and time of appointment 
        SELECT STRFTIME('%d', meet_day) AS MONTH FROM APPOINTMENT; --GET DAY
        SELECT STRFTIME('%H', meet_otime) AS HOUR FROM APPOINTMENT; --GET HOUR
    -- 2. Get all appointment of patient
        SELECT *
        FROM APPOINTMENT
        WHERE p_id = 1;

-- s. RECORD_DETAIL
    -- 1. Get record detail of a record
        SELECT p_name,rec_dease, p_dateOB, p_sex, p_ethnic, p_BHXH, p_type, recDet_indiagnose, recDet_outdiagnose, recDet_description, recDet_conclusion, recDet_examineday, recDet_reexamineday
        FROM PATIENT p INNER JOIN APPOINTMENT app ON p.p_id = app.p_id INNER JOIN RECORD rec ON app.appoint_id = rec.appoint_id INNER JOIN RECORD_DETAIL recDet ON rec.rec_id = recDet.rec_id
        WHERE rec.rec_id = 1; 




