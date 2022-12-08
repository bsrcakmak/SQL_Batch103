CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun;

   --- DISTINCT ---
--> DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz
   -- GROUP BY cozumu
select urun_isim from musteri_urun group by urun_isim;
  -- DISTINCT cozumu
select DISTINCT urun_isim from musteri_urun;  --> urunleri takrarsiz tablo yapar
--> aralarindaki fark count yaptigimizda belli olur
--> tek bir sutun gruplandirilmak isteniyorsa genellikle DISTINCT kullanilmali

--Tabloda kac farkli meyve vardir?
select count(distinct urun_isim) AS urun_cesit_sayisi from musteri_urun; 

select urun_isim, count(urun_isim) from musteri_urun 
group by urun_isim;
--> group by da gruplamak istedigimiz sutun ismini de yazmamiz gerekiyor (urun_isim gibi)
-- ve her urunden kac tane varsa hepsini gosterir

select count(distinct urun_isim) AS urun_cesit_sayisi from musteri_urun
group by urun_isim;
--> group by ile birlikte distinct kullanirsak hepsinden 1'er tane oldugunu gosterir


   --- FETCH NEXT (SAYI) ROW ONLY - OFFSET / LIMIT ---

--Sirali tablodan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;
--LIMIT ile cozum
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 3


-- Musteri urun tablosundan son 3 kaydi listeleyin
select * from musteri_urun order by urun_id desc
limit 3


--Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlarilisteleyin
select * from musteri_urun order by urun_id
offset 3 row 
fetch next 4 row only;
-- LIMIT ile cozum
select * from musteri_urun order by urun_id
offset 3 limit 4


CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);

INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);

-- en yuksek maasi alAn musteriyi listeleyin
select * from maas ORDER BY maas DESC 
LIMIT 1;

select * from maas ORDER BY maas DESC 
OFFSET 1 LIMIT 1; -- satir atlamak istedigimizde OFFSET kullaniriz

select * from maas ORDER BY maas DESC 
OFFSET 1
FETCH NEXT 1 ROW ONLY

--Mass tablosundan en dusuk dorduncu maasi listeleyiniz
select * from maas ORDER BY maas
offset 3 limit 1


   --- DDL - ALTER TABLE STATEMENT ---
/*
ALTER TABLE statement tabloda add, Type(modify)/Set, Rename 
veya drop columns islemleri icin kullanilir.
ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
*/

CREATE TABLE personel (
id int,
isim varchar(50), 
sehir varchar(50), 
maas int,
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY(id)
);

DROP TABLE personel cascade 
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500,'Honda');

SELECT * FROM personel;

-- 1-) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel
ADD zipcode varchar(30); --sadece sutunu ekler 

--> DEFAULT yazarsak olusturdugumuz sutuna belirttigimiz veriyi tum satirlara girer
ALTER TABLE personel
ADD ulke_isim varchar(30) DEFAULT 'Turkiye';
 

--3)DROP tablodan sutunsilme
ALTER TABLE personel 
DROP COLUMN zipcode;

ALTER TABLE personel 
DROP sehir, DROP sirket;  --> iki sutunu birden siler


-- 4-) RENAME COLUMN sutun adidegistirme
ALTER TABLE personel
RENAME COLUMN sehir TO il 


-- 5-) RENAME tablonun ismini degistirme
ALTER TABLE personel
RENAME TO isciler;  --> column yazmazsak tablonun adi degisir

select * from isciler 


-- 6-) TYPE/SET(modify) sutunlarin ozelliklerinidegistirme
ALTER TABLE isciler
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;

--Not: String data türünü numerik bir data türüne dönüştürmek istersek;
/*
ALTER COLUMN fieldname
TYPE int USING(fieldname::int)  şeklinde yaparız.
*/


--Not: Numerik data türünü String bir data türüne dönüştürmek istersek;
ALTER TABLE isciler
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30));



		-- TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
/*
	 Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
	Trancei baslatnak icin BEGIN 
 */
 
 DROP TABLE ogrenciler2 CASCADE 
 CREATE TABLE ogrenciler2
(
id serial, -- serial data turu otomatik olarak 1 den baslayarak sirali olarak sayi atamasi yapar
	       -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);

BEGIN;  --> transaction blogunu baslatir
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x; --> ROLLBACK to x yapilirsa buraya kadar olan kismi siler buraya doner 
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x; --> tablonun beginden hemn sonraki haline dondurur savepoint e kadar olan yer
COMMIT;
 
select * from ogrenciler2;
delete from ogrenciler2  --> herseyi sildik ama transaction sonlanmadi cunku commit yapilmadi
drop table ogrenciler2

--> beginden sonra savepoint x e kadar olan kisim commit yapmadan hicbir yere kaybolmaz
--> delete yapsak bile sonrasinda roolback x dedigimizde oraya doner
--> commit yapinca transaction blogundan cikar, delete yaptiktan sonra roolback yapsa da eski hale donmez tablo bos kalir 
