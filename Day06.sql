  -- JOINS --
 /*
  2 Tablodaki datalari Birlestirmek icinkullanilir.
  Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir Tablolar icin ise JOINkullanilir
  5 Cesit Join vardir
    1)INNER JOIN iki Tablodaki ortak datalarigosterir
    2)LEFT JOIN Ilk datada olan tum recordlarigosterir
    3)RIGHT JOIN Ikinci tabloda olan tum recordlarigosterir
    4)FULL JOIN Iki tablodaki tum recordlarigosterir
    5)SELF JOIN Bir tablonun kendi icinde Join edilmesi ileolusur.
 */

  -- INNER JOINS -- iki tabloda ortak olanlari getiriyor
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55,  105, '2020-04-21');

select * from sirketler
select * from siparisler

--SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim, siparisler. siparis_id, siparisler. siparis_tarihi 
FROM sirketler INNER JOIN siparisler --(sirketlr ve siparislerin kesisimi)
ON sirketler.sirket_id =siparisler.sirket_id;

/*
NOT:
1)Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklindeyazin
2)From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismiyazmaliyiz
3)Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimizyazilmali
*/

--- LEFT JOINS ---
/*
NOT:
1)Left Join’de ilk tablodaki tum record’largosterilir.
2)Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilirancak
ortak olmayan datalar icin o kisimlar boskalir
3)Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onuyazmaliyiz
*/

--SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler LEFT JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id


--- RIGHT JOINS ---
/*
NOT:
1)Right Join’de ikinci tablodaki tum record’largosterilir.
2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilirancak 
ortak olmayan datalar icin o kisimlar boskalir
*/
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler RIGHT JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id
-- Bunu yapmak yerine left joinin iki yanindaki tablo isimlerinin yeri de degistirilebilir


--- FULL JOINS ---
/*
NOT:
1)FULL Join’de iki tabloda var olan tum record’largosterilir.
2)Bir tabloda olup otekinde olmayan data’lar boskalir
*/
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler FULL JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id

--- SELF JOINS ---
CREATE TABLE personel 
(
id int,
isim varchar(20), 
title varchar(60), 
yonetici_id int
);

INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

drop table personel cascade 
select * from personel
-- Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
select p1.isim AS personel_isim,p2.isim AS yonetici_isim 
from personel p1 INNER JOIN personel p2
ON p1.yonetici_id=p2.id


--- LIKE CONDITION ---
/*
LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veyaDELETE
statementile calisan wildcards’a(özel sembol)izin verir..
Ve bize pattern matchingyapma imkaniverir.
*/

drop table musteriler
CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);

INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1007, 'Erhan', 92000);  

   -- 1-) % => 0 veya birden fazla karakter belirtir

--SORU: Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
--> LIKE sadece buyuk A ile baslayanlari getirir
SELECT * FROM musteriler WHERE isim LIKE'A%'; 
--> LIKE yerine ~~ sembollerini de kullanabiliriz 
SELECT * FROM musteriler WHERE isim ~~'A%'; 

--> ILIKE buyuk kucuk harf ayrimina dikkat etmez
SELECT * FROM musteriler WHERE isim ILIKE'A%'; 
--> ILIKE yerine ~~* sembollerini de kullanabiliriz 
SELECT * FROM musteriler WHERE isim ~~*'A%'; 

--SORU:Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim LIKE '%e';
select isim,gelir from musteriler where isim ~~ '%e';

--SORU :Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim LIKE '%er%';
select isim,gelir from musteriler where isim ~~ '%er%';


  -- 2-)  _ => sadece bir karakteri gosterir
 
--SORU: Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERYyazin
select * from musteriler where isim ~~ '_atma';

--SORU: Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERYyazin
select * from musteriler where isim LIKE '_a%';

--SORU: Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERYyazin
select * from musteriler where isim LIKE '__s%';

--SORU: Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERYyazin
select * from musteriler where isim LIKE '__s_'

--SORU: Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim LIKE 'F___%'

--SORU: Ikinci harfia,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERYyazin
select * from musteriler where isim LIKE '_a_m%'


   --- 3-) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
--veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
--(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
  
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);  
INSERT INTO kelimeler VALUES (1009, 'hAt',5);  

select * from kelimeler
  
----SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin 
--tum bilgilerini yazdiran QUERY yazin 

SELECT * FROM kelimeler WHERE kelime ~ 'h[ai]t';
SELECT * FROM kelimeler WHERE kelime ~* 'h[ai]t'; --(~*) yerine similar to da yazilabilir
-->  ~ ile birlikte * kullanirsak buyuk kucuk harf farketmez anlamina gelir

--SORU: Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin 
--tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[a-k]t';

--SORU: Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '[mi]';

--SORU: a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '^[as]';
-- regexP de baslayan derse ^ ile baslatiyoruz 
 
--SORU: m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '[mf]$';
-- regexP de biten derse $ ile bitiriyoruz
  
   
   --- NOT LIKE Condition ---  (!~) sembolleri de kullanilabilir
   
--SORU1: ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin   
SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%' 
   
--SORU2: a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin   
SELECT * FROM kelimeler WHERE kelime NOT LIKE '%a%' 
   
--SORU3: ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin   
SELECT * FROM kelimeler WHERE kelime NOT LIKE '_de%' 
   
--SORU4: 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin   
SELECT * FROM kelimeler WHERE kelime !~ '[_eio]' 
   
/*
            LIKE Condition
-> LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmemizi sağlar
-> ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
-> LIKE = ~~
-> ILIKE = ~~*
-> NOT LIKE = !~~
-> NOT ILIKE = !~~*
-> NOT REGEXP_ILIKE = !~*
-> NOT REGEXP_LIKE = !~
*/
   
   
  --- UPPER –LOWER -INITCAP --- 
--Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
--kucuk harf yazdirmak icin kullaniriz     

SELECT UPPER (kelime) as kelime FROM kelimeler;  -- kelimelerin hepsi buyuk harf olur
SELECT LOWER( kelime) as kelime FROM kelimeler;  -- kelimelerin hepsi kucuk harf olur
SELECT INITCAP (kelime) as kelime FROM kelimeler; -- kelimelerin ilk harfi buyuk sonrakiler kucuk harf olur  
   
-- Musteriler tablosundan butun isimleri buyuk harf yapiniz
select UPPER(isim) as kelime from musteriler 
   
