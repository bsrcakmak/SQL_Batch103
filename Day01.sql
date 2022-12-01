-- DATABASE(VeriTabani) Olusturma
 Create dataBase busra;

create dataBase cakmak;

-- DDL - DATA DEFINITION LANG.
-- CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),	
not_ort real, --Ondalikli sayilar icin kullanilir(Double gibi)
kayit_tarih date	
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
AS -- Benzer tablodaki basliklar ve data tipleriyle yeni bir tablo olusturmak icin normal tablo olustururken ki 
-- parantezler yerine AS kullanıp Select komutuyla almak istediğimiz verileri alırız
SELECT isim,soyisim,not_ort FROM ogrenciler2;

--DML - DATA MANIPULATION LANG.
-- INSERT (Databas,e veri ekleme)

INSERT INTO ogrenciler2 VALUES ('1234567','Busra','CAKMAK',85.5,now());
INSERT INTO ogrenciler2 VALUES ('1234567','Busra','CAKMAK',85.5,'2020-12-11');

-- bir tabloya parcali veri eklemek istersek

INSERT INTO ogrenciler2 (isim,soyisim) VALUES ('Azra','CAKMAK');


-- DQL - DATA QUERY LANG.
--SELECT

select * FROM ogrenciler2;  -- Burdaki * sembolu herseyi al anlamindadir

