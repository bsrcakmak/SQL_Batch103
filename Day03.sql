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

-- Veli ismi Hasan datayi silelim

DELETE FROM ogrenciler3 WHERE veli_isim='Hasan';

-- TRUNCATE --
-- Bir tablodaki tüm verileri geri alamayacağımız şekilde siler. Şartlı silme yapmaz

TRUNCATE TABLE ogrenciler3


-- DAHA ONCE AYNI ISIMDE TABLO VARSA ONU SILMEK ICIN KULLANABILIRIZ 
DROP TABLE if exists adresler -- Eğer tablo varsa tabloyu siler

-- ON DELETE CASCADE

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade  -- bunu yazmasaydik talebeler tablosundan veri silmemize izin vermezdi once child olan notlar1 tablosunu da sil derdi
);

INSERT INTO talebeler VALUES('123', 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES('124', 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES('125', 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES('126', 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES('127', 'Mustafa Bak', 'Can',99);


INSERT INTO notlar1 VALUES ('123','kimya',75);
INSERT INTO notlar1 VALUES ('124', 'fizik',65);
INSERT INTO notlar1 VALUES ('125', 'tarih',90);
INSERT INTO notlar1 VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar1;

-- Notlar tablosundan talebe_id'si 123 olan datayi silelim

DELETE FROM notlar1 WHERE talebe_id='123';

-- Talebeler tablosundan id'si 126 olan datayi silelim

DELETE FROM talebeler WHERE id='126';


CREATE TABLE talebe
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE not1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebe(id)
);

INSERT INTO talebe VALUES('123', 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES('124', 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES('125', 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES('126', 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES('127', 'Mustafa Bak', 'Can',99);


INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90);

select * from talebe;
select * from not1;

DELETE FROM talebe WHERE id='126';


/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/


-- IN CONDITION -- 

CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

-- Musteriler tablosundan urun ismi orange,apple veya apricot olan verileri listeleyiniz.
SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--IN CONDITION-- 
SELECT * FROM musteriler WHERE urun_isim IN('Orange','Apple','Apricot');

--NOT IN CONDITION --> Yazdigimiz verilerin disindakileri getirir
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange','Apple','Apricot');


-- BETWEEN CONDITION
-- Musteriler tablosundan urun_id'si 20 ile 40 arasinda olan tum verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;



-- SUBQUERIES -- 
-- SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU dur.
DROP TABLE if exists calisanlar2
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM calisanlar2;
SELECT * FROM markalar;
SELECT * FROM calisanlar2,markalar;

--Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas,isyeri FROM calisanlar2 
       WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

--SELECT listelenmesi istenen veriler FROM bu verilerin bulundugu tablo ismi 
--WHERE diger tablo ile iliskilendirilecek veri ismi 
--IN (SELECT onceki tablo ile iliskili olan veri ismi FROM iliskili ikinci tablo ismi WHERE bu tablo ile ilgili istenen sorgu)  


--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim, maas, sehir FROM calisanlar2 
      WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id > 101);


--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id,calisan_sayisi FROM markalar
     WHERE marka_isim IN(SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara');
	 
	 
-- AGGREGATE METHOD -- 	

--Calisanlar tablosundan maksimum maasi listeleyelim
SELECT max(maas) AS maksimum_maas FROM calisanlar2;	 
--Eger bir sutuna gecici olarak bir isim vermek istersek AS komutunu yazdiktan sonra vermek istedigimiz ismi yazariz.

-- Calisanlkar tablosundan en dusuk maasi listeleyelim
SELECT min(maas) AS en_dusuk_maas FROM calisanlar2;
	
-- Calisanlar tablosundaki maas'larin toplamini listeleyiniz. 
SELECT sum(maas) AS maas_toplami FROM calisanlar2;
	
-- Calisanlar tablosundaki maas'larin ortalamasini listeleyiniz. 
SELECT avg(maas) AS maas_ort FROM calisanlar2;
SELECT round(avg(maas)) AS maas_ort FROM calisanlar2; -- Virgulden sonrasini istemiyorsak
SELECT round(avg(maas),2) AS maas_ort FROM calisanlar2; -- Virgulden sonra 2 basamak istiyorsak
	
-- Calisanlar tablosundaki maas'larin sayisini listeleyiniz. 
SELECT count(maas) FROM calisanlar2; -- count satirlari sayar	
SELECT count(*) FROM calisanlar2; -- count(*) butun satirlari sayar
	
	
	
	
	
	
	
	
