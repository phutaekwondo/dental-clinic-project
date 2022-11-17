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
    p_type TEXT CHECK(p_type IN ('Thường','Vip')), 
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
CREATE TABLE RECORD(
    rec_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    rec_day TEXT NOT NULL, 
    rec_dease TEXT, 
    rec_desc TEXT, 
    appoint_id INTEGER NOT NULL,
    FOREIGN KEY (appoint_id) REFERENCES APPOINTMENT(appoint_id)
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
    c_time INTEGER,
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
    appoint_status TEXT CHECK(appoint_status IN ('waiting','approved','canceled')),
    p_id INTEGER NOT NULL, 
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
INSERT INTO ACCOUNT(acc_un, acc_mk, acc_role) VALUES('xuan_truong','xuantruong123','doctor');
INSERT INTO ACCOUNT(acc_un, acc_mk, acc_role) VALUES('quang_khai','quangkhai123'  ,'admin');
INSERT INTO ACCOUNT(acc_un, acc_mk, acc_role) VALUES('anh_tuyet','anhtuyet123'    ,'patient');

-- -- b. DOCTOR
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Xuân Trường', STRFTIME('%d/%m/%Y', '1983-07-25'), 'Nam', '0921954763', 'xuantruong@gmail.com', 'Nhân viên', 10500000, NULL, NULL, 'xuan_truong');

-- -- c. ADMIN
INSERT INTO ADMIN(a_name, a_dateOB, a_sex, a_phnu, a_email,a_salr, a_odate, a_edate, acc_un) VALUES('Trần Quang Khải', STRFTIME('%d/%m/%Y', '1972-11-13'), 'Nam', '0819655472', 'quangkhai@gmail.com', 8000000, NULL, NULL, 'quang_khai');

-- -- d. PATIENT
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Lê Anh Tuyết', STRFTIME('%d/%m/%Y', '1982-04-06'), 'Nữ', 'Kinh', NULL, '0927883174', 'anhtuyet@gmail.com', 'Thường', 'anh_tuyet');

-- -- e. BLOG
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2022-10-28'), 'Covid-19', 'Covid-19 lây qua những đường nào', NULL);

-- -- f. SERVICE
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Chăm sóc răng miệng', 'Khám', 'Làm sạch vi khuẩn khoang miệng, làm trắng răng, giúp răng mạnh khỏe', 3000000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));

-- -- g. MEDICINE
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Paracetamon', 50000, 'Đức', 'Giảm đau đầu, chóng mặt, buồn nôn', 30, 'hộp');

-- -- h. RECORD
INSERT INTO RECORD(rec_id,
rec_day,
rec_dease,
rec_desc,
appoint_id) VALUES(1,'123','123','123',1);

INSERT INTO RECORD(rec_id,
rec_day,
rec_dease,
rec_desc,
appoint_id) VALUES(2,'123','123','123',2);

-- -- i. BLOG_AUTHOR
-- --INSERT INTO BLOG_AUTHOR VALUES();

-- -- k. COMMENT
-- --INSERT INTO COMMENT VALUES();

-- -- l. BUY_LIST
-- --INSERT INTO BUY_LIST VALUES();

-- -- m. APPOINTMENT
INSERT INTO APPOINTMENT(
    appoint_status,
    p_id          , 
    d_id          , 
    s_id          , 
    meet_day      ,
    meet_otime    , 
    meet_etime    , 
    meet_place    , 
    meet_room     , 
    meet_desc  
    ) 
    VALUES('waiting',1,1,1,STRFTIME('%Y-%m-%d', '2000-01-13'),STRFTIME('%H:%M', '08:00'),STRFTIME('%H:%M', '10:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT(
    appoint_status,
    p_id          , 
    d_id          , 
    s_id          , 
    meet_day      ,
    meet_otime    , 
    meet_etime    , 
    meet_place    , 
    meet_room     , 
    meet_desc  
    ) 
    VALUES('waiting',2,2,2,STRFTIME('%Y-%m-%d', '2001-01-13'),STRFTIME('%H:%M', '08:00'),STRFTIME('%H:%M', '10:00'), 'KhanhHoa','405','dau bung');
-- SELECT * FROM APPOINTMENT;
-- DELETE FROM APPOINTMENT;
-- /* 4.QUERY ROWS */
-- -- a. Query ALL 
--     --
--     --  SELECT * FROM ...;
--     --
    
-- -- b. ACCOUNT 
-- -- c. DOCTOR
-- -- d. ADMIN
-- -- e. PATIENT
-- -- f. BLOG
-- -- g. SERVICE
-- -- h. MEDICINE
-- -- i. RECORD
--     -- a. Get records of patient
--         SELECT *
--         FROM RECORD
--         WHERE appoint_id = (
--             SELECT appoint_id 
--             FROM APPOINTMENT
--             WHERE p_id = 1
--         );
-- -- k. BLOG_AUTHOR
-- -- l. COMMENT
-- -- m. BUY_LIST
-- -- n. APPOINTMENT
--     -- a. Get day and time of appointment 
--         SELECT STRFTIME('%d', meet_day) AS MONTH FROM APPOINTMENT; --GET DAY
--         SELECT STRFTIME('%H', meet_otime) AS HOUR FROM APPOINTMENT; --GET HOUR
--     -- b. Get all appointment of patient
--         SELECT *
--         FROM APPOINTMENT
--         WHERE p_id = 1;

        




