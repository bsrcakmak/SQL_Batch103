/* PRACTICE-1
“ ogretmenler” isminde tablo olusturun. Icinde “kimlik_no”, “isim”, “brans” ve“cinsiyet”
field’lariolsun.
---“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisiekleyin.
Kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet:kadin.
---“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisiekleyin.
Kimlik_no: 567597624, isim: Ali Veli
*/






/* Practice-2:
“sehirler” isimli bir Table olusturun. Tabloda “alan_kodu”, “isim”, “nufus” field’lari olsun. Isim field’ibos
birakilamasin.
1.Yontemi kullanarak“alan_kodu”
field’ini“Primary Key”yapin
*/



/* Practice-3:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Keyyapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsunve
“tedarikci_id” yi Foreign Keyyapin.
*/
CREATE TABLEtedarikciler3(
tedarikci_idchar(10),
tedarikci_ismi varchar(50), iletisim_isimvarchar(50),
CONSTRAINT tedarikci_pk PRIMARY KEY(tedarikci_id)
);


CREATE TABLE urunler (
tedarikci_id char(10), product_idchar(10),
CONSTRAINT urunler_fk FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);


/* Practice-4:
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”field’lari olsun.“id” yi Primary Keyyapin, “isim” i Unique, “maas” i Not Nullyapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”,“sokak”, “cadde” ve “sehir”fieldlari olsun. “adres_id” field‘iileForeign Key oluşturun.
*/




/* Practice-5:
-id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
-D ile Y arasındaki personel bilgilerini listeleyiniz
-D ile Y arasında olmayan personel bilgilerini listeleyiniz
-Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
*/

CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);




