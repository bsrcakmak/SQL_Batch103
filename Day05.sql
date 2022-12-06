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
--ve personel sayisini veren sorguyaziniz
select sehir,count(isim) AS sum_personel_sayisi from personel
group by sehir
having count(isim) > 1;












