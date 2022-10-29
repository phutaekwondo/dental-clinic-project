
--INSERT INTO DOCTOR VALUES('BS01', 'Nguyen Van A',STRFTIME('%d/%m/%Y', '2001-01-18'), 'Nam', NULL, 'Truong phong', 10000000 );
--INSERT INTO DOCTOR(d_date) VALUES (STRFTIME('%d/%m/%Y, %H:%M', time)); add date
--INSERT INTO DOCTOR(d_date) VALUES ()
--DELETE FROM DOCTOR; delete all rows from {table}
--DROP TABLE DOCTOR; delete table

--SELECT * FROM DOCTOR WHERE; query data
--UPDATE DOCTOR SET d_date = STRFTIME('%H:%M', '06:00') WHERE d_id = 'BS01'

--DROP TABLE 
--PRAGMA foreign_keys = OFF;

/* CREATE TABLE */
CREATE TABLE ROLE(
    r_id TEXT PRIMARY KEY, 
    r_name TEXT NOT NULL 
);
CREATE TABLE ACCOUNT(
    acc_id TEXT PRIMARY KEY, 
    acc_tk TEXT, 
    acc_mk TEXT NOT NULL,
    acc_avatar BLOB,
    acc_username TEXT NOT NULL
);
CREATE TABLE USER(
    u_id TEXT PRIMARY KEY, 
    u_fname TEXT,
    u_lname TEXT,
    u_date INTEGER, 
    u_sex TEXT CHECK(u_sex IN ('Nam','Nu')), 
    u_phnu TEXT, 
    u_email TEXT,
    acc_id TEXT NOT NULL, 
    r_id TEXT NOT NULL,
    FOREIGN KEY (acc_id) REFERENCES ACCOUNT(acc_id),
    FOREIGN KEY (r_id) REFERENCES ROLE(r_id)
);
CREATE TABLE DOCTOR(
    d_id TEXT PRIMARY KEY,
    d_pos TEXT CHECK(d_pos IN ('Nhan vien','Trương khoa')), 
    d_salr REAL,
    d_odate INTEGER, 
    d_edate INTEGER, 
    u_id TEXT NOT NULL,
    FOREIGN KEY (u_id) REFERENCES USER(u_id)
);
CREATE TABLE ADMIN(
    a_id TEXT PRIMARY KEY, 
    a_salr REAL, 
    a_odate INTEGER, 
    a_edate INTEGER, 
    u_id TEXT NOT NULL,
    FOREIGN KEY (u_id) REFERENCES USER(u_id)
);
CREATE TABLE PATIENT(
    p_id TEXT PRIMARY KEY, 
    p_type TEXT NOT NULL CHECK(p_type IN ('Thuong','Vip')), 
    u_id TEXT NOT NULL, 
    FOREIGN KEY (u_id) REFERENCES USER(u_id)
);

CREATE TABLE BLOG(
    b_id TEXT PRIMARY KEY, 
    b_date INTEGER NOT NULL, 
    b_topic TEXT NOT NULL, 
    b_head TEXT,
    b_body TEXT
);
CREATE TABLE SERVICE(
    s_id TEXT PRIMARY KEY, 
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
    m_id TEXT PRIMARY KEY, 
    m_name TEXT NOT NULL, 
    m_price TEXT NOT NULL, 
    m_orig TEXT, 
    m_func TEXT, 
    m_amnt TEXT
);
CREATE TABLE RECORD(
    rec_id TEXT PRIMARY KEY, 
    rec_day TEXT NOT NULL, 
    rec_dease TEXT, 
    rec_desc TEXT, 
    appoint_id TEXT NOT NULL,
    FOREIGN KEY (appoint_id) REFERENCES APPOINTMENT(appoint_id)
);

CREATE TABLE BLOG_AUTHOR(
    d_id TEXT, 
    b_id TEXT,
    FOREIGN KEY (d_id) REFERENCES DOCTOR(d_id),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id),
    PRIMARY KEY (d_id, b_id)
);
CREATE TABLE COMMENT(
    acc_id TEXT NOT NULL, 
    b_id TEXT NOT NULL, 
    c_content TEXT, 
    c_time INTERGER,
    FOREIGN KEY (acc_id) REFERENCES ACCOUNT(acc_id),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id)
);
CREATE TABLE BUYING_LIST(
    u_id TEXT NOT NULL, 
    m_id TEXT NOT NULL, 
    buy_day INTEGER, 
    amount INTEGER, 
    price REAL,
    FOREIGN KEY (u_id) REFERENCES USER(u_id),
    FOREIGN KEY (m_id) REFERENCES MEDICINE(m_id)
);
CREATE TABLE APPOINTMENT(
    appoint_id TEXT PRIMARY KEY,
    p_id TEXT, 
    d_id TEXT, 
    s_id TEXT, 
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
INSERT INTO ROLE VALUES('r01', 'Doctor'), ('r02', 'Patient'), ('r03','Admin');

-- Account 
INSERT INTO ACCOUNT VALUES ('acc001',NULL, 'stillcakcak', NULL, 'cakcak');
INSERT INTO USER VALUES ('u001', 'Nguyen', 'Phu', NULL, NULL, '0987654321', 'phu@gmail.com')




