-- GROUP BY -- 

CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

delete from personel;
select * from personel;

--Isme gore toplam maaslari bulun
SELECT isim,sum(maas) AS toplam_maas FROM personel
GROUP BY isim;

-- personel tablosundaki isimleri griplayiniz
select isim from personel 
group by isim;

--sehre gore toplam personel sayisinibulun
select sehir,count(isim) AS personel_sayisi from personel
GROUP BY sehir;

--Sirketlere gore maasi 5000 liradan fazla olan personel sayisinibulun
select sirket,count(*) AS personel_sayisi from personel 
where maas>5000
GROUP BY sirket;


    --- HAVING CLAUSE --- 
--HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur
-- bir gruplama olacak sonrada egerli bir istek olacak buda having icine yazilacak
/*
	Having komutu yalnizca GROUP BY komutu ile kullanilir
	Eger gruplamadan once bir sart varsa 'where', gruplamadan sonra sart varsa 'having' kullaniyoruz.
*/

--Her sirketin MIN maaslarini eger 4000’den buyukse goster
select * from personel;

select sirket,min(maas) AS en_dusuk_maas from personel
group by sirket
having min(maas) > 4000;

--Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi 
--ve toplam maasi gosteren sorguyaziniz
select isim,sum(maas) AS toplam_maas from personel
group by isim
having sum(maas) > 10000;

--Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini 
--ve personel sayisini veren sorgu yaziniz
select sehir,count(isim) AS sum_personel_sayisi from personel
group by sehir
having count(isim) > 1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini 
--ve MAX maasi veren sorguyaziniz
select sehir, max(maas) AS max_maas from personel 
GROUP BY sehir
HAVING max(maas) < 5000;


  -- UNION OPERATOR --
/*
Iki farkli sorgulamanin sonucunu birlestiren islemdir. 
Secilen Field Sayisi ve DATA TYPE’i ayni olmalidir.
*/

--Maasi 4000’den cok olan isci isimlerini 
--ve 5000 liradan fazla maas alinan sehirlerigosteren sorguyuyaziniz

select sehir AS sehir_veya_personel_ismi, maas from personel
where maas>5000
UNION
select isim AS sehir_veya_personel_ismi, maas from personel
where maas>4000;

--Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelinmaaslarini
--bir tabloda gosteren sorguyaziniz

select isim AS isim_veya_sehir_ismi, maas from personel
where isim='Mehmet Ozturk'
UNION
select sehir AS isim_veya_sehir_ismi, maas from personel
where sehir='Istanbul';

--NOT:2.sorgunun sonuna ORDER BY komutunu kullanirsaniz tum tabloyu istediginiz siralamaya gore siralar
ORDER BY maas;


--Sehirlerden odenen ucret 3000’den fazla olanlari 
--ve personelden ucreti 5000’den azolanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyuyaziniz
select sehir AS personel_veya_sehir_ismi ,maas from personel
where maas>3000
UNION
select isim AS personel_veya_sehir_ismi ,maas from personel
where maas<5000
ORDER BY maas;


/*
Personel isminde bir tablo olusturun.Icinde id,isim,sehir,maas ve sirket field’lari olsun. 
Id’yi 2.yontemle PK yapin
*/

DROP TABLE IF EXISTS personel

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel
select * from personel_bilgi

--id’si 12345678 olan personelin Personel tablosundan sehir ve maasini,
--personel_bilgi tablosundan da tel ve cocuk sayisiniyazdirin

select sehir as sehir_veya_tel, maas as maas_veya_cocuk_sayisi from personel
where id=123456789
UNION
select tel,cocuk_sayisi from personel_bilgi
where id=123456789

/*
NOT : Union islemi yaparken;
1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali
2)Alt alta gelecek sutunlarin data type’lari ayni olmali
*/


  --- UNION ALL OPERATOR ---
/*
--> UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesinialir.
--> UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.
NOT : UNION ALL ile birlestirmelerde de
1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali
2)Alt alta gelecek sutunlarin data type’lari ayni olmali
*/



--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslaribulunuz
select isim,maas from personel where maas<5000
UNION  -- tekrar eden verileri teke dusurur 
select isim,maas from personel where maas<5000

select isim,maas from personel where maas<5000
UNION ALL -- iki sorguyu da alt alta yazar ayni sorgu olsa bile 
select isim,maas from personel where maas<5000


/*
1) Tabloda personel maasi 4000’den cok olan tum sehirleri ve maaslariyazdirin
2) Tabloda personel maasi 5000’den az olan tum isimleri ve maaslariyazdirin
--> Yukaridaki sorgulari UNION ALL ile birlestirin
*/
select sehir,maas from personel where maas>4000 
UNION ALL
select isim,maas from personel where maas<5000


    -- INTERSECT(Kesisim) OPERATOR -- 
/*
SQL INTERSECT operatörü, 2 veya daha fazla SELECT ifadesinin sonuçlarını döndürmek için kullanılır. 
Ancak, yalnızca tüm sorgular veya veri kümeleri tarafından seçilen satırları döndürür. 
Bir sorguda bir kayıt varsa ve diğerinde yoksa, INTERSECT sonuçlarından çıkarılacaktır.
*/

--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id leriniyazdirin
--Iki sorguyu INTERSECT ilebirlestirin
select id from personel where sehir in('Istanbul','Ankara')
INTERSECT -- iki kumenin kesisimini alir
select id from personel_bilgi where cocuk_sayisi in(2,3);






