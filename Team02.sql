-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
​
select * from calisanlar2;
select * from markalar;
​
select marka_id,marka_isim, (select count(sehir) from calisanlar2 where isyeri=marka_isim)
from markalar
​
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
​
SELECT marka_isim,calisan_sayisi, (SELECT sum(maas) from calisanlar2 where isyeri=marka_isim) as maaslartoplami
FROM markalar
​
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
​
SELECT marka_isim,calisan_sayisi,
(SELECT min(maas) from calisanlar2 where isyeri=marka_isim)as minimummaas,
(SELECT max(maas) from calisanlar2 where isyeri=marka_isim)as maximummaas
from markalar;
​
​
CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
​
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
​
CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);
​
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
​
/*
MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
*/
select * from mart
select * from nisan
​
select musteri_isim,urun_isim from mart where urun_isim IN (select urun_isim from nisan)
​
SELECT musteri_isim,urun_isim from mart where exists (select urun_isim from nisan where mart.urun_isim=nisan.urun_isim)
​
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
​
Select urun_isim,musteri_isim from nisan where exists (SELECT urun_isim from mart where nisan.urun_isim=mart.urun_isim)
​
--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
​
select urun_isim,musteri_isim from nisan where not exists (select urun_isim from mart where nisan.urun_isim=mart.urun_isim)
​
--UPDATE SET
​
CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
​
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
​
CREATE TABLE urunler -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino)
REFERENCES tedarikciler(vergi_no)
on delete cascade
);
​
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
​
-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
select * from tedarikciler
select * from urunler
​
UPDATE tedarikciler
SET firma_ismi='Vestel' where vergi_no=102
​
-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
​
UPDATE tedarikciler
SET firma_ismi='Casper', irtibat_ismi='Ali Veli' where vergi_no=101
​
-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
Update urunler
SET urun_isim='Telefon' where urun_isim='Phone'
​
-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
​
UPDATE urunler
SET urun_id=urun_id+1 where urun_id>1004
​
-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler
SET urun_id=urun_id+ted_vergino 
​
-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
​
UPDATE urunler
SET urun_isim = (SELECT firma_ismi from tedarikciler where irtibat_ismi='Adam Eve') WHERE musteri_isim='Ali Bak';
​
--* Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
UPDATE urunler
SET musteri_isim = (SELECT irtibat_ismi from tedarikciler where firma_ismi='Apple') WHERE urun_isim='Laptop'