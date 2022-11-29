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
    d_name TEXT, 
    d_dateOB INTEGER,
    d_sex TEXT CHECK(d_sex IN ('Nam','Nữ')),
    d_address TEXT,
    d_ethnic TEXT,
    d_phnu TEXT, 
    d_email TEXT,
    d_position TEXT CHECK(d_position IN ('Nhân viên','Trưởng khoa')), 
    d_salr REAL,
    d_odate INTEGER,  --Ngày nhậm chức
    d_edate INTEGER,  --Ngày nghỉ việc
    acc_un INTEGER,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un)
);
CREATE TABLE ADMIN(
    a_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    a_name TEXT,
    a_dateOB INTEGER, 
    a_sex TEXT CHECK(a_sex IN ('Nam','Nữ')), 
    a_address TEXT,
    a_ethnic TEXT,
    a_phnu TEXT, 
    a_email TEXT,
    a_salr REAL, 
    a_odate INTEGER,  --ngày nhậm chức
    a_edate INTEGER,  --ngày nghỉ việc
    acc_un INTEGER,
    FOREIGN KEY (acc_un) REFERENCES ACCOUNt(acc_un)
);
CREATE TABLE PATIENT(
    p_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    p_name TEXT,
    p_dateOB INTEGER, 
    p_sex TEXT CHECK(p_sex IN ('Nam','Nữ')), 
    p_address TEXT,
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
    b_date INTEGER,  --ngày đăng
    b_topic TEXT, 
    b_head TEXT,
    b_body TEXT
);
CREATE TABLE SERVICE(
    s_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    s_name TEXT, 
    s_type TEXT, 
    s_desc TEXT, 
    s_price REAL, 
    s_oday INTEGER,  --ngày bắt đầu hoạt động trong tuần
    s_eday INTEGER,  --ngày cuối cùng hoạt động trong tuần
    s_otime INTEGER, --giờ mở cửa trong ngày
    s_etime INTEGER  --giờ đóng cửa
);
CREATE TABLE MEDICINE(
    m_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    m_name TEXT, 
    m_price TEXT,  
    m_orig TEXT,    -- xuất xứ
    m_func TEXT,    -- công dụng
    m_amnt TEXT,    -- số lượng
    m_unit TEXT CHECK(m_unit IN ('viên','vỉ','hộp'))
);

CREATE TABLE BLOG_AUTHOR(
    d_id INTEGER, 
    b_id INTEGER,
    FOREIGN KEY (d_id) REFERENCES DOCTOR(d_id),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id),
    PRIMARY KEY (d_id, b_id)
);

CREATE TABLE BLOG_UPDATE(
    b_id INTEGER,
    b_lastmodified INTEGER,  --ngày cập nhật
    b_description TEXT,  --thông tin thay đổi
    PRIMARY KEY (b_id, b_lastmodified, b_description),
    FOREIGN KEY(b_id) REFERENCES BLOG(b_id)
);

CREATE TABLE COMMENT(
    acc_un TEXT NOT NULL, 
    b_id INTEGER NOT NULL, 
    c_content TEXT, 
    c_time INTEGER,
    PRIMARY KEY (acc_un, b_id, c_time),
    FOREIGN KEY (acc_un) REFERENCES ACCOUNT(acc_un),
    FOREIGN KEY (b_id) REFERENCES BLOG(b_id)
);
CREATE TABLE BUY_LIST(
    p_id INTEGER, 
    m_id INTEGER, 
    buy_day INTEGER, 
    amount INTEGER, 
    sum_price REAL,
    PRIMARY KEY (p_id,m_id, buy_day),
    FOREIGN KEY (p_id) REFERENCES PATIENT(p_id),
    FOREIGN KEY (m_id) REFERENCES MEDICINE(m_id)
);
CREATE TABLE APPOINTMENT(
    appoint_id INTEGER PRIMARY KEY AUTOINCREMENT,
    appoint_status TEXT CHECK(appoint_status IN ('waiting','approved','canceled')),
    p_id INTEGER, 
    d_id INTEGER, 
    s_id INTEGER, 
    meet_day INTEGER,    --ngày gặp mặt
    meet_otime INTEGER,  --thời gian gặp
    meet_etime INTEGER,  --thời gian kết thúc 
    meet_place TEXT,     --nơi gặp
    meet_room TEXT,      --phòng gặp
    meet_desc TEXT,      --miêu tả nội dung cuộc hẹn
    FOREIGN KEY (p_id) REFERENCES PATIENT(p_id),
    FOREIGN KEY (d_id) REFERENCES DOCTOR(d_id),
    FOREIGN KEY (s_id) REFERENCES SERVICE(s_id)
);

CREATE TABLE RECORD(
    rec_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    rec_date INTEGER,        --ngày tạo hồ sơ bệnh án
    rec_lastmodified INTEGER,
    rec_dease TEXT, --bệnh
    rec_desc TEXT,  --tóm tắt bệnh án
    rec_indiagnose TEXT,  --chẩn đoán lúc vào viện
    rec_outdiagnose TEXT,  --chẩn đoán lúc ra viện
    rec_conclusion TEXT,    --kết luận
    rec_examineday INTEGER, --ngày bắt đầu khám
    rec_reexamineday INTEGER, --ngày tái khám--
    appoint_id INTEGER,
    FOREIGN KEY (appoint_id) REFERENCES APPOINTMENT(appoint_id)
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
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_address, d_ethnic, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Xuân Trường', STRFTIME('%d/%m/%Y', '1983-07-25'), 'Nam', '23/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0921954763', 'xuantruong@gmail.com', 'Nhân viên', 10500000, NULL,NULL, 'xuan_truong');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_address, d_ethnic, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Duy Mạnh', STRFTIME('%d/%m/%Y', '1990-03-04'), 'Nam', '24/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0919233458', 'duymanh@gmail.com', 'Nhân viên', 9500000, NULL,NULL,'duy_manh');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_address, d_ethnic, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Lê Thị Huyền Trang', STRFTIME('%d/%m/%Y', '1985-11-14'), 'Nữ', '25/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0188654371', 'huyentrang@gmail.com', 'Nhân viên', 10000000, NULL,NULL, 'huyen_trang');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_address, d_ethnic, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Phạm Xuân Nhất', STRFTIME('%d/%m/%Y', '1988-02-01'), 'Nam', '26/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '092012348', 'xuannhat@gmail.com', 'Trưởng khoa', 15000000, NULL,NULL, 'xuan_nhat');
INSERT INTO DOCTOR(d_name, d_dateOB, d_sex, d_address, d_ethnic, d_phnu, d_email, d_position, d_salr, d_odate, d_edate, acc_un) VALUES('Nguyễn Thu Thủy', STRFTIME('%d/%m/%Y', '1995-10-02'), 'Nữ', '27/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0891071856', 'thuthuy@gmail.com', 'Nhân viên', 10500000, NULL,NULL, 'thu_thuy');

--SELECT * FROM DOCTOR;

-- c. ADMIN
INSERT INTO ADMIN(a_name, a_dateOB, a_sex, a_address, a_ethnic, a_phnu, a_email,a_salr, a_odate, a_edate, acc_un) VALUES('Trần Quang Khải', STRFTIME('%d/%m/%Y', '1972-11-13'), 'Nam', '28/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0819655472', 'quangkhai@gmail.com', 8000000, NULL,NULL, 'quang_khai');
INSERT INTO ADMIN(a_name, a_dateOB, a_sex, a_address, a_ethnic, a_phnu, a_email,a_salr, a_odate, a_edate, acc_un) VALUES('Phạm Thế Dương', STRFTIME('%d/%m/%Y', '1981-04-29'), 'Nam', '29/5 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', '0213890776', 'theduong@gmail.com', 9000000, NULL,NULL, 'the_duong');

--SELECT * FROM ADMIN;


-- d. PATIENT
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_address, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Lê Anh Tuyết', STRFTIME('%d/%m/%Y', '1982-04-06'), 'Nữ', '22/4 khu phố 2, huyện Đồng Khởi, tỉnh Đồng Nai', 'Kinh', NULL, '0927883174', 'anhtuyet@gmail.com', 'Thường', 'anh_tuyet');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_address, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Ngô Gia Lộc', STRFTIME('%d/%m/%Y', '2000-12-20'), 'Nam', '137/10 khu phố 1, huyện Tân Bình, tỉnh Bến Tre', 'Kinh', NULL, '0924883175', 'gialoc@gmail.com', 'Vip', 'gia_loc');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_address, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Trịnh Thu Phương', STRFTIME('%d/%m/%Y', '1983-04-12'), 'Nữ', '71/4A khu phố 10, huyện Bến Nghé, tỉnh Kiên Giang', 'Kinh', NULL, '0927483173', 'thuphuong@gmail.com', 'Thường', 'thu_phuong');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_address, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Hồ Gia Thế', STRFTIME('%d/%m/%Y', '1982-06-30'), 'Nam', '99/123 khu phố 4, huyện Long Thành, tỉnh Đồng Nai', 'Kinh', NULL, '0927283171', 'giathe@gmail.com', 'Thường', 'gia_the');
INSERT INTO PATIENT(p_name,p_dateOB, p_sex, p_address, p_ethnic,p_BHXH,p_phnu, p_email,p_type, acc_un) VALUES('Nguyễn Gia Linh', STRFTIME('%d/%m/%Y', '1992-07-31'), 'Nữ', '11/3B khu phố 7, quận 5, thành phố Hồ Chí Minh ', 'Kinh', NULL, '0921233174', 'gialinh@gmail.com', 'Vip', 'gia_linh');

--SELECT * FROM PATIENT;

-- e. BLOG
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2022-10-28'), 'Nhổ răng', 'Nên nhổ răng khi nào', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2020-01-23'), 'Sâu răng', 'Nguyên nhân chủ yếu gây sâu răng', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2012-01-11'), 'Đau miêng', 'Đau miệng có thể là dấu hiệu của bệnh gì', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2010-03-04'), 'Trồng răng', 'Quy trình trồng răng', NULL);
INSERT INTO BLOG(b_date, b_topic, b_head,b_body) VALUES(STRFTIME('%d/%m/%Y', '2008-12-31'), 'Răng khôn', 'Răng khôn có thực sự khôn ?', NULL);

--SELECT * FROM BLOG;

--v. BLOG_UPDATE
INSERT INTO BLOG_UPDATE(b_id, b_lastmodified, b_description) VALUES(1, STRFTIME('%d/%m/%Y', '2022-10-28'), NULL);
INSERT INTO BLOG_UPDATE(b_id, b_lastmodified, b_description) VALUES(2, STRFTIME('%d/%m/%Y', '2020-01-23'), NULL);
INSERT INTO BLOG_UPDATE(b_id, b_lastmodified, b_description) VALUES(3, STRFTIME('%d/%m/%Y', '2012-02-11'), 'Thêm cách chữa trị đau miệng');
INSERT INTO BLOG_UPDATE(b_id, b_lastmodified, b_description) VALUES(4, STRFTIME('%d/%m/%Y', '2010-04-04'), 'Thêm video quy trình trồng răng');
INSERT INTO BLOG_UPDATE(b_id, b_lastmodified, b_description) VALUES(5, STRFTIME('%d/%m/%Y', '2008-12-31'), NULL);

--SELECT * FROM BLOG_UPDATE;

-- f. SERVICE
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Chăm sóc răng miệng', 'Chữa', 'Làm sạch vi khuẩn khoang miệng, làm trắng răng, giúp răng mạnh khỏe', 3000000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Trồng răng giả', 'Chữa', 'Trồng răng giả, thay răng', 5500000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));
INSERT INTO SERVICE(s_name, s_type, s_desc, s_price, s_oday, s_eday, s_otime, s_etime) VALUES('Tư vấn răng hàm miệng', 'Khám', 'Tư vấn về các vấn đề liên quan đến răng hàm miệng và cách giúp răng luôn khỏe đẹp', 100000, 2, 6, STRFTIME('%H:%M', '8:00'), STRFTIME('%H:%M', '17:00'));

--SELECT * FROM SERVICE;

-- g. MEDICINE
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Paracetamon', 50000, 'Đức', 'Giảm đau đầu, chóng mặt, buồn nôn', 30, 'hộp');
INSERT INTO MEDICINE(m_name, m_price, m_orig, m_func, m_amnt,m_unit) VALUES('Sensa cool', 30000, 'Anh','Chữ viêm lợi, mát gan', 23, 'hộp');
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
INSERT INTO APPOINTMENT VALUES(1,'approved',1,1,3,STRFTIME('%Y-%m-%d', '2020-01-13'),STRFTIME('%H:%M', '17:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(2,'approved',2,1,2,STRFTIME('%Y-%m-%d', '2012-12-22'),STRFTIME('%H:%M', '08:00'),STRFTIME('%H:%M', '10:00'), 'BienHoa','501','Khám lợi');
INSERT INTO APPOINTMENT VALUES(3,'approved',5,2,2,STRFTIME('%Y-%m-%d', '2010-01-04'),STRFTIME('%H:%M', '09:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','123','Nhám lợi');
INSERT INTO APPOINTMENT VALUES(4,'approved',1,3,1,STRFTIME('%Y-%m-%d', '2008-11-13'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(5,'approved',5,4,3,STRFTIME('%Y-%m-%d', '2002-02-24'),STRFTIME('%H:%M', '08:30'),STRFTIME('%H:%M', '10:00'), 'BienHoa','111','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(6,'approved',3,3,2,STRFTIME('%Y-%m-%d', '2011-01-04'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(7,'canceled',4,5,1,STRFTIME('%Y-%m-%d', '2011-06-03'),STRFTIME('%H:%M', '17:30'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(8,'approved',2,1,2,STRFTIME('%Y-%m-%d', '2012-12-02'),STRFTIME('%H:%M', '08:30'),STRFTIME('%H:%M', '10:00'), 'BienHoa','501','Khám lợi');
INSERT INTO APPOINTMENT VALUES(9,'approved',5,2,1,STRFTIME('%Y-%m-%d', '2015-07-23'),STRFTIME('%H:%M', '09:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','123','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(10,'approved',1,3,2,STRFTIME('%Y-%m-%d', '2008-10-09'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(11,'approved',4,1,3,STRFTIME('%Y-%m-%d', '2002-02-24'),STRFTIME('%H:%M', '07:30'),STRFTIME('%H:%M', '10:00'), 'BienHoa','223','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(12,'approved',2,5,1,STRFTIME('%Y-%m-%d', '2017-01-01'),STRFTIME('%H:%M', '14:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','119','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(13,'waiting',3,2,1,STRFTIME('%Y-%m-%d', '2009-04-30'),STRFTIME('%H:%M', '15:30'),STRFTIME('%H:%M', '18:00'), 'BienHoa','802','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(14,'approved',1,4,2,STRFTIME('%Y-%m-%d', '2006-12-22'),STRFTIME('%H:%M', '10:00'),STRFTIME('%H:%M', '10:30'), 'BienHoa','432','Khám lợi');
INSERT INTO APPOINTMENT VALUES(15,'approved',2,1,1,STRFTIME('%Y-%m-%d', '2007-12-04'),STRFTIME('%H:%M', '09:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','111','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(16,'canceled',5,4,3,STRFTIME('%Y-%m-%d', '2009-06-12'),STRFTIME('%H:%M', '10:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','271','Trồng răng');
INSERT INTO APPOINTMENT VALUES(17,'approved',3,2,2,STRFTIME('%Y-%m-%d', '2002-02-24'),STRFTIME('%H:%M', '08:30'),STRFTIME('%H:%M', '10:00'), 'BienHoa','111','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(18,'approved',1,5,1,STRFTIME('%Y-%m-%d', '2020-01-13'),STRFTIME('%H:%M', '17:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(19,'approved',2,3,2,STRFTIME('%Y-%m-%d', '2021-12-14'),STRFTIME('%H:%M', '17:00'),STRFTIME('%H:%M', '18:00'), 'BienHoa','408','Trồng răng');
INSERT INTO APPOINTMENT VALUES(20,'waiting',2,1,3,STRFTIME('%Y-%m-%d', '2019-08-02'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','412','Khám răng sâu');
INSERT INTO APPOINTMENT VALUES(21,'approved',4,2,2,STRFTIME('%Y-%m-%d', '2015-07-07'),STRFTIME('%H:%M', '10:30'),STRFTIME('%H:%M', '11:00'), 'BienHoa','725','Nhổ răng');
INSERT INTO APPOINTMENT VALUES(22,'approved',3,4,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(23,'waiting',5,2,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(24,'canceled',4,4,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(25,'waiting',3,4,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(26,'canceled',4,4,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');
INSERT INTO APPOINTMENT VALUES(27,'waiting',3,4,1,STRFTIME('%Y-%m-%d', '2006-04-10'),STRFTIME('%H:%M', '13:00'),STRFTIME('%H:%M', '14:00'), 'BienHoa','289','Trồng răng');

--SELECT * FROM APPOINTMENT;

-- m. RECORD
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose,rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), 'Sâu răng',
'Bệnh nhân 8 tuổi có 1 răng sâu ở miệng bên phải','Sâu răng hàm','Đã nhổ răng sâu','Khỏi bệnh',STRFTIME('%Y-%m-%d','2020-01-13'),NULL, 1);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2008-11-13 14:30'), STRFTIME('%Y-%m-%d %H:%M','2008-11-13 14:30'), 'Trồng răng',
'Bệnh nhân nam 45 tuổi trồng 1 răng hàm giả ',NULL,'Đã trồng răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2008-11-13'),NULL, 4);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2008-10-09 13:20'), STRFTIME('%Y-%m-%d %H:%M','2008-10-09 13:20'), 'Trồng răng',
'Bệnh nhân nam 45 tuổi trồng răng cửa','Trồng răng cửa','Đã trồng răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2008-10-09'),NULL, 10);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2006-12-22 10:30'), STRFTIME('%Y-%m-%d %H:%M','2006-12-22 10:30'), 'Khám lợi',
'Bệnh nhân nữ 28 tuổi bị viêm lợi','Viêm lợi bên má trái','Đã kê thuốc',NULL,STRFTIME('%Y-%m-%d','2006-12-22'),NULL, 14);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), STRFTIME('%Y-%m-%d %H:%M','2020-01-13 17:30'), 'Sâu răng',
'Bệnh nhân nữ có 1 răng sâu ở miệng bên phải','Sâu răng hàm','Đã nhổ răng sâu','Khỏi bệnh',STRFTIME('%Y-%m-%d','2021-12-14'),NULL, 18);

INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2020-12-22 08:30'), STRFTIME('%Y-%m-%d %H:%M','2020-12-22 08:30'), 'Viêm lợi',
'Bệnh nhân 20 tuổi nổi mụn nhọt ở lợi', 'Viêm lợi do nóng trong người','Đã cấp thuốc',NULL,STRFTIME('%Y-%m-%d','2020-12-22'),NULL, 2);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2012-12-02 09:30'), STRFTIME('%Y-%m-%d %H:%M','2012-12-02 09:30'), 'Viêm lợi',
'Bệnh nhân 20 tuổi nổi mụn nhọt ở lợi', 'Viêm lợi do nóng trong người','Đã cấp thuốc',NULL,STRFTIME('%Y-%m-%d','2012-12-02'),NULL, 8);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease,rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2017-01-01 18:00'), STRFTIME('%Y-%m-%d %H:%M','2017-01-01 18:00'), 'Sâu răng',
'Bệnh nhân 15 tuổi bị sâu 1 răng hàm bên trái', 'Sâu răng do lười đánh răng','Đã nhổ răng sâu','Khỏi bệnh',STRFTIME('%Y-%m-%d','2017-01-01'),NULL, 12);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2007-12-04 10:30'), STRFTIME('%Y-%m-%d %H:%M','2007-12-04 10:30'), 'Thay răng',
'Bệnh nhân 8 tuổi bắt đầu thay răng', 'Thay răng do đến tuổi','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2007-12-04'),NULL, 15);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2021-12-14 18:00'), STRFTIME('%Y-%m-%d %H:%M','2021-12-14 18:00'), 'Trồng răng',
'Bệnh nhân 52 tuổi trồng răng', 'Trồng răng','Đã trồng răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2021-12-14'),NULL, 19);

INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2011-01-04 15:30'), STRFTIME('%Y-%m-%d %H:%M','2011-01-04 15:30'), 'Khám răng sâu',
'Bệnh nhân 20 tuổi bị sâu răng', 'Sâu răng hàm','Đã nhổ răng sâu','Khỏi bệnh',STRFTIME('%Y-%m-%d','2011-01-04'),NULL, 6);
/*INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2009-04-30 18:00'), STRFTIME('%Y-%m-%d %H:%M','2009-04-30 18:00'), 'Khám răng sâu',
'Bệnh nhân 18 tuổi có dấu hiệu sâu răng', 'Sâu răng hàm','Đã tư vấn',NULL,STRFTIME('%Y-%m-%d','2009-04-30'),NULL, 13);*/
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), 'Nhổ răng',
'Bệnh nhân 10 tuổi nhổ răng do gãy răng', 'Nhổ răng cửa','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2002-02-24'),NULL, 17);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2006-04-10 14:00'), STRFTIME('%Y-%m-%d %H:%M','2006-04-10 10:00'), 'Trồng răng',
'Bệnh nhân trồng răng', NULL,'Đã trồng răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2006-04-10'),NULL, 22);

/*INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2011-06-03 18:00'), STRFTIME('%Y-%m-%d %H:%M','2011-06-03 18:00'), 'Nhổ răng sâu',
'Bệnh nhân nam nhổ răng sâu', 'Nhổ 1 răng sâu','Đã nhổ răng sâu','Khỏi bệnh',STRFTIME('%Y-%m-%d','2011-06-03'),NULL, 7);*/
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), 'Nhổ răng',
'Bệnh nhân nhổ răng do lung lay', 'Nhổ răng','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2002-02-24'),NULL, 11);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2015-07-07 10:30'), STRFTIME('%Y-%m-%d %H:%M','2015-07-07 10:30'), 'Nhổ răng',
'Bệnh nhân nhổ răng do thay răng', 'Nhổ răng hàm','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2015-07-07'),NULL, 21);

INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), STRFTIME('%Y-%m-%d %H:%M','2002-02-24 10:00'), 'Nhổ răng', 
'Bệnh nhân nhổ răng do lung lay', 'Nhổ răng cửa','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2002-02-24'),NULL, 5);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2010-01-04 11:00'), STRFTIME('%Y-%m-%d %H:%M','2010-01-04 11:00'), 'Viêm lợi',
'Bệnh nhân nổi mụn nhọt ở lợi', 'Viêm lợi do nóng trong người','Đã cấp thuốc','Khỏi bệnh',STRFTIME('%Y-%m-%d','2010-01-04'),NULL, 3);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2015-07-23 11:00'), STRFTIME('%Y-%m-%d %H:%M','2015-07-23 11:00'), 'Nhổ răng',
'Bệnh nhân nhổ răng do gãy răng', 'Nhổ răng bên hàm trái','Đã nhổ răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2015-07-23'),NULL, 9);
INSERT INTO RECORD(rec_date, rec_lastmodified, rec_dease, rec_desc, rec_indiagnose, rec_outdiagnose, rec_conclusion ,rec_examineday , rec_reexamineday, appoint_id) VALUES(STRFTIME('%Y-%m-%d %H:%M','2009-06-12 11:00'), STRFTIME('%Y-%m-%d %H:%M','2009-06-12 11:00'), 'Trồng răng',
'Bệnh nhân trồng răng giả', 'Trồng 1 răng hàm giả','Đã trồng răng','Khỏi bệnh',STRFTIME('%Y-%m-%d','2009-06-12'),NULL, 16);

--SELECT * FROM RECORD;

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
    --1. Get blog list
        SELECT b.b_id, b_topic, b_date, b_lastmodified
        FROM BLOG b LEFT JOIN BLOG_UPDATE bgup ON b.b_id = bgup.b_id;
    
-- g. SERVICE
-- h. MEDICINE
-- i. RECORD
    -- 1. Get records of patient
        SELECT rec_id, rec_dease, d_id, rec_date, rec_lastmodified
        FROM RECORD rec INNER JOIN APPOINTMENT app ON rec.appoint_id = app.appoint_id
        WHERE app.p_id = 1;
    --2. Get record detail of a record
        SELECT p_name,rec_dease, p_dateOB, p_sex, p_ethnic, p_BHXH, p_type, p_address, rec_indiagnose, rec_outdiagnose, rec_desc, rec_conclusion, rec_examineday, rec_reexamineday
        FROM PATIENT p INNER JOIN APPOINTMENT app ON p.p_id = app.p_id INNER JOIN RECORD rec ON app.appoint_id = rec.appoint_id
        WHERE rec.rec_id = 1; 
        
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

        




