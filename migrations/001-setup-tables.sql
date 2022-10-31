
--INSERT INTO DOCTOR VALUES('BS01', 'Nguyen Van A',STRFTIME('%d/%m/%Y', '2001-01-18'), 'Nam', NULL, 'Truong phong', 10000000 );
--INSERT INTO DOCTOR(d_date) VALUES (STRFTIME('%d/%m/%Y, %H:%M', time)); add date
--INSERT INTO DOCTOR(d_date) VALUES ()
--DELETE FROM DOCTOR; delete all rows from {table}
--DROP TABLE DOCTOR; delete table

--SELECT * FROM DOCTOR WHERE; query data
--UPDATE DOCTOR SET d_date = STRFTIME('%H:%M', '06:00') WHERE d_id = 'BS01'

--DROP TABLE PATIENT
--PRAGMA foreign_keys = OFF;

/* CREATE TABLE */
-- CREATE TABLE ROLE(
--     r_id INTEGER PRIMARY KEY AUTOINCREMENT, 
--     r_name TEXT NOT NULL 
-- );

CREATE TABLE ACCOUNT(
    acc_un TEXT PRIMARY KEY, 
    acc_mk TEXT NOT NULL,
    acc_avatar BLOB,
    acc_role TEXT NOT NULL CHECK(acc_role IN ('admin', 'doctor', 'patient'))
);
CREATE TABLE DOCTOR(
    d_id INTEGER PRIMARY KEY AUTOINCREMENT,
    d_fname TEXT NOT NULL,
    d_lname TEXT NOT NULL,
    d_sex TEXT CHECK(d_sex IN ('Nam','Nu')), 
    d_dateOB INTEGER,
    d_phnu TEXT, 
    d_email TEXT,
    d_position TEXT CHECK(d_position IN ('Nhan vien','Trương khoa')), 
    d_salr REAL,
    d_odate INTEGER,  --Ngày nhậm chức
    d_edate INTEGER,  --Ngày nghỉ việc
    acc_un INTEGER NOT NULL,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un)
);
CREATE TABLE ADMIN(
    a_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    a_fname TEXT NOT NULL,
    a_lname TEXT NOT NULL,
    a_dateOB INTEGER, 
    a_sex TEXT CHECK(a_sex IN ('Nam','Nu')), 
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
    p_fname TEXT NOT NULL,
    p_lname TEXT NOT NULL,
    p_dateOB INTEGER, 
    p_sex TEXT CHECK(p_sex IN ('Nam','Nu')), 
    p_ethnic TEXT,
    p_BHXH TEXT,
    p_phnu TEXT, 
    p_email TEXT,
    p_type TEXT CHECK(p_type IN ('Thuong','Vip')), 
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
    m_amnt TEXT
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
    c_time INTERGER,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id)
);
CREATE TABLE BUYING_LIST(
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

/* INSERT DATA */
--Role 
-- INSERT INTO ROLE VALUES('r01', 'Doctor'), ('r02', 'Patient'), ('r03','Admin');

-- Account 
-- INSERT INTO ACCOUNT VALUES ('acc001',NULL, 'stillcakcak', NULL, 'cakcak');
-- INSERT INTO USER VALUES ('u001', 'Nguyen', 'Phu', NULL, NULL, '0987654321', 'phu@gmail.com');


-- TESTING @VinhPhu
CREATE TABLE TRASH(
    t_id INTEGER PRIMARY KEY AUTOINCREMENT,
    t_name TEXT NOT NULL
);
INSERT INTO TRASH (t_name) VALUES('name2');
INSERT INTO TRASH (t_name) VALUES('name3');



