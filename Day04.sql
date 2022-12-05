   --ALIASES--

CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO calisanlar3 VALUES(123456789,'Ali Can', 'Istanbul');
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar3

select calisan_id AS id from calisanlar3; 
-- AS ile gecici olarak ismi degistirir ana tabloda degisiklik olmaz 
select calisan_id AS id, calisan_isim ||' '|| calisan_dogdugu_sehir AS calisan_bilgisi from calisanlar3;
-- Eger iki sutunun verilerini birlestirmek istersek concat sembolu olan || kullaniriz.

--2.yol; direk concat method ismini yazariz
select calisan_id AS id, concat(calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi from calisanlar3;


-- IS NULL CONDITION --

CREATE TABLE insanlar1
(
ssn char(9),
isim varchar(50), 
adres varchar(50)
);
INSERT INTO insanlar1 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO insanlar1 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO insanlar1 VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar1 (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar1 (ssn, adres) VALUES(567890123,'Denizli');

select * from insanlar1

-- Name sutununda null olan degerleri listeleyelim
SELECT name FROM insanlar1 WHERE name IS null

--Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar WHERE name IS NOT NULL

-- Insanlar tablosunda null deger almis verileri no name olarak degistiriniz
update insanlar
set name='no_name' where name is null;


-- 								ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
	Default olarak kucukten buyuge siralama yapar
	Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/ 

drop table if exists insanlar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

-- Insanlar tablosundaki datalari adres'e gore siralayin
select * from insanlar ORDER BY adres;
select * from insanlar ORDER BY soyisim;

-- Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT * FROM insanlar WHERE isim='Mine' ORDER BY ssn -- ssn bizdeki tc kimlik gibi

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar where soyisim='Bulut' ORDER BY 2

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar ORDER BY isim ASC, soyisim DESC;
-- ASC -> natural siralar
-- DESC -> tersten siralar


-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH (soyisim);
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH (soyisim) DESC; 
/*
Eger sutun uzunluguna gore siralamak istersek LENGTH komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek  sonuna DESC komutunu ekleriz
*/

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT isim||' '|| soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim || soyisim);

SELECT isim||' '|| soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim) + LENGTH (soyisim);

SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim) + LENGTH (soyisim);
 
SELECT isim ||' '|| soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (concat(isim, soyisim));


  --GROUP BY CLAUSE--
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav

-- Isme gore alinan toplam urunleri bulun 
select sum(urun_miktar) from manav -- tek bir sonuc olarak butun urun miktarlarini toplayarak getirir

select isim,sum(urun_miktar) AS aldigi_toplam_urun from manav 
GROUP BY isim;

-- Isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge listeleyiniz
SELECT isim,sum(urun_miktar) AS aldigi_toplam_urun from manav 
GROUP BY isim
ORDER BY aldigi_toplam_urun DESC;


--Urun ismine gore urunu alan toplam kisi sayisi
select COUNT(isim) FROM manav -- toplam urun alan kisileri verir

SELECT urun_adi,COUNT(isim) FROM manav
GROUP BY urun_adi;   -- urun ismine gore verir toplam kisi sayisini

SELECT isim,COUNT(urun_adi) AS aldigi_toplam_urun FROM manav
GROUP BY isim; -- kisilere gore toplam urun cesidi

--Alinan kilo miktarina gore musterisayisi
SELECT urun_miktar AS kilo_miktari,COUNT(isim) AS musteri_sayisi FROM manav
GROUP BY urun_miktar;
