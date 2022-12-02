CREATE TABLE ogrenciler5
(
ogrenci_no char(7), --Uzunlugunu bildigimiz Stringler icin CHAR kullanilir
isim varchar(20), -- Uzunlugunu bilmedigimiz Stringler icin VARCHAR kullanilir
soyisim varchar(25),	
not_ort real, --Ondalikli sayilar icin kullanilir(Double gibi)
kayit_tarih date	
);
-- VAROLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler5;

select * from notlar

-- INSERT -- TABLO ICINE VERI EKLEME

INSERT INTO notlar VALUES ('Orhan',95.5)
INSERT INTO notlar VALUES ('Hakan',85.5)
INSERT INTO notlar VALUES ('Sule',92.5)

select * from notlar;

Create table talebeler
(isim varchar (10),
	notlar real);
Insert Into notlar values ('Orhan', 80.5);
Insert Into notlar values ('Ali', 83.5);
Insert Into notlar values ('Musa', 92.5);
Insert Into notlar values ('Hakan', 90.5);
Insert Into notlar values ('Adem', 70.5);
Insert Into notlar values ('Sumeyye', 75.5);

SELECT isim from notlar; -- istedigimiz field/sutunu da getirebiliyoruz


-- CONSTRAINT
-- UNIQUE
-- NOT NULL

CREATE TABLE ogrenciler6
(
ogrenci_no char(7) unique, -- tekrarli veri giremeyiz
isim varchar(20) not null,
soyisim varchar(25),	
not_ort real, 
kayit_tarih date	
);

select * from ogrenciler6;

Insert Into ogrenciler6 values ('1234567','Elif','Han', 80.5,now());
Insert Into ogrenciler6 values ('1234568','Eda','Kan', 80.5,now());
INSERT INTO ogrenciler6 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5) -- NOT NULL kisitlamasi oldugu icin bu veri eklenemez

-- PRIMARY KEY atamasi

CREATE TABLE ogrenciler7
(
ogrenci_no char(7) PRIMARY KEY, 
isim varchar(20),
soyisim varchar(25),	
not_ort real, 
kayit_tarih date	
);

-- PRIMARY KEY atamasi 2. yol

CREATE TABLE ogrenciler8
(
ogrenci_no char(7), 
isim varchar(20),
soyisim varchar(25),	
not_ort real, 
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no) -- constraint primary key'e bizim isim vermemizi saglar
);

CREATE TABLE ogrenciler9
(
ogrenci_no char(7), 
isim varchar(20),
soyisim varchar(25),	
not_ort real, 
kayit_tarih date,
PRIMARY KEY(ogrenci_no)	
);

--“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
--“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
--“tedarikci_id” yi Foreign Key yapin.

CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),	
iletisim_isim varchar(20)	
);

CREATE TABLE urunler(
tedarikci_id char(5),
urun_id char(5),
 FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) 	
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) 	
);


--“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. 
--“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
--“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun.
--“adres_id” field‘i ile Foreign Key oluşturun.

CREATE TABLE calisanlar
(
id char(5) PRIMARY KEY, 
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama	date
);

CREATE TABLE adresler
(
adres_id char(5),
sokak varchar(15),
cadde varchar(15),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');-- UNIQE constraint old. kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL constraint
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE constraint
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- SYNTAKS hatasi, int veriyi String girmeye calisti
--INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14'); -- PRIMARY KEY hiclik kabul eder
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY UNIQUE oldugu icin ikinci hicligi kabul eTMEZ
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- AYNI PRIMARY KEY KABUL ETMEZ
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY NULL kabul etmez

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;
SELECT * FROM adresler;

-- CHECK CONSTRAINT
CREATE TABLE calisanlar2
(
id char(5) PRIMARY KEY, 
isim varchar(20) UNIQUE,
maas int CHECK (maas>10000) NOT NULL,
ise_baslama	date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');

SELECT * FROM calisanlar1;

-- DQL -- WHERE KULLANIMI 

SELECT * FROM calisanlar;
SELECT isim FROM calisanlar; 

-- Calisanlar tablosundan maasi 5000 den buyuk olan isimlei listeleyin
SELECT isim,maas FROM calisanlar WHERE maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan veriyi listeleyin
SELECT * FROM calisanlar WHERE isim='Veli Han';

-- Calisanlar tablosundan maasi 5000 olan tum verileri listeleyin
SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar; -- Eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmeli
DELETE FROM adresler;

--adresler tablosundan sehri antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';


-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

DELETE FROM ogrenciler3 WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';

SELECT * FROM ogrenciler3;

