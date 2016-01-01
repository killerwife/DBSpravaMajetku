CREATE TABLE pracovnik
(
meno Varchar2(30),
priezvisko Varchar2(30),
rodneCislo Number,
datumPrijatia Date,
datumOdstupu Date,
IDpracovnika Integer,
PRIMARY KEY(IDpracovnika)
);
/
CREATE TABLE typMajetku
(
typMajetku Char(1),
popis Varchar2(50),
PRIMARY KEY(typMajetku)
);
/
CREATE TABLE budovy
(
id Integer,
nazov Varchar2(30),
PRIMARY KEY(id)
);
/
CREATE TABLE dodavatel
(
meno Varchar2(30),
ICO Number(8,0),
adresa Varchar(100),
PRIMARY KEY(ICO)
);
/
CREATE TABLE typAktivity
(
typAktivity Char(1),
popis Varchar2(50),
PRIMARY KEY(typAktivity)
);
/
CREATE TABLE typMaterialu
(
typMaterialu Char(1),
popis Varchar2(50),
PRIMARY KEY(typMaterialu)
);
/
CREATE TABLE oddelenie
(
oddelenie Integer,
nadOddelenie Integer,
IDbudovy Integer,
PRIMARY KEY(oddelenie)
);
/
ALTER TABLE oddelenie ADD FOREIGN KEY (IDbudovy) REFERENCES budovy(ID);
ALTER TABLE oddelenie ADD FOREIGN KEY (nadOddelenie) REFERENCES oddelenie(oddelenie);
CREATE TABLE majetok
(
nazov Varchar2(30),
IDmajetku Integer,
nakupnaCena Integer,
typMajetku Char(1) NOT NULL,
datumNakupu Date,
ICO Number(8,0),
stavMajetku Char(1),
PRIMARY KEY(IDmajetku)
);
/
ALTER TABLE majetok ADD FOREIGN KEY (ICO) REFERENCES dodavatel(ICO);
ALTER TABLE majetok ADD FOREIGN KEY (typMajetku) REFERENCES typMajetku(typMajetku);
CREATE TABLE umiestnenieMajetku
(
datumPriradenia Date,
datumOdobratia Date,
IDmajetku Integer,
IDpracovnika Integer,
oddelenie Integer,
PRIMARY KEY(datumPriradenia,IDmajetku,IDpracovnika,oddelenie)
);
/
ALTER TABLE umiestnenieMajetku ADD FOREIGN KEY (IDmajetku) REFERENCES majetok(IDmajetku);
ALTER TABLE umiestnenieMajetku ADD FOREIGN KEY (IDpracovnika) REFERENCES pracovnik(IDpracovnika);
ALTER TABLE umiestnenieMajetku ADD FOREIGN KEY (oddelenie) REFERENCES oddelenie(oddelenie);
CREATE TABLE aktivita
(
cena Number,
popis Varchar2(50),
typAktivity Char(1),
IDmajetku Integer,
datumVykonania Date,
ICO Number(8,0),
IDpracovnika Integer,
CONSTRAINT aktivita_pk PRIMARY KEY(typAktivity,IDmajetku,datumVykonania)
);
/
ALTER TABLE aktivita ADD FOREIGN KEY (typAktivity) REFERENCES typAktivity(typAktivity);
ALTER TABLE aktivita ADD FOREIGN KEY (IDmajetku) REFERENCES majetok(IDmajetku);
ALTER TABLE aktivita ADD FOREIGN KEY (ICO) REFERENCES dodavatel(ICO);
ALTER TABLE aktivita ADD FOREIGN KEY (IDpracovnika) REFERENCES pracovnik(IDpracovnika);
CREATE TABLE spotrebnyMaterial
(
typMaterialu Char(1),
typAktivity Char(1),
IDmajetku Integer,
datumVykonania Date,
oddelenie Integer NOT NULL,
mnozstvo Number,
cena Number,
PRIMARY KEY(typMaterialu,typAktivity,IDmajetku,datumVykonania)
);
/
ALTER TABLE spotrebnyMaterial ADD FOREIGN KEY (typMaterialu) REFERENCES typMaterialu(typMaterialu);
ALTER TABLE spotrebnyMaterial ADD CONSTRAINT spotrebnyMaterial_fk FOREIGN KEY (typAktivity,IDmajetku,datumVykonania) REFERENCES aktivita(typAktivity,IDmajetku,datumVykonania);
ALTER TABLE spotrebnyMaterial ADD FOREIGN KEY (oddelenie) REFERENCES oddelenie(oddelenie);
CREATE TABLE rozmnozovaciaTech
(
pocetVytlacenychStranok Number,
zaciatokPouzivania Date,
IDmajetku Integer,
typMaterialu Char(1),
koniecPouzivania Date,
PRIMARY KEY(zaciatokPouzivania,IDmajetku,typMaterialu)
);
/
ALTER TABLE rozmnozovaciaTech ADD FOREIGN KEY (IDmajetku) REFERENCES majetok(IDmajetku);
ALTER TABLE rozmnozovaciaTech ADD FOREIGN KEY (typMaterialu) REFERENCES typMaterialu(typMaterialu);