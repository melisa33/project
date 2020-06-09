DROP DATABASE IF EXISTS diyetisyen;
CREATE DATABASE IF NOT EXISTS diyetisyen;
ALTER DATABASE diyetisyen CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE diyetisyen;

create table dosya(
    id int primary key auto_increment,
    adi varchar(100),
    dosya_yolu varchar(200)
    );

create table yetki(
    id int unsigned primary key auto_increment,
    adi varchar(20) unique,
    admin tinyint,
    doktor tinyint,
    hasta tinyint
    );

create table rapor(
    id int primary key auto_increment,
    adi varchar(20),
    dosya_id int,
    aciklama varchar(500),
    FOREIGN KEY (dosya_id) REFERENCES dosya(id) ON DELETE SET NULL
    );

create table kisi(
    id int primary key auto_increment,
    adi varchar(20),
    soyadi varchar(20),
    yas int,
    tel_no varchar(11),
    sifre varchar(20),
    kullanici_adi varchar(20) unique,
    email varchar(30) unique,
    biyografi varchar(20),
    fotograf_id int,
    yetki_id int UNSIGNED DEFAULT NULL,
    FOREIGN KEY (yetki_id) REFERENCES yetki(id) ON DELETE SET NULL,
    FOREIGN KEY (fotograf_id) REFERENCES dosya(id) ON DELETE SET NULL
    );

create table yorum(
    id int primary key auto_increment,
    aciklama varchar(200),
    doktor_id int  DEFAULT NULL,
    FOREIGN KEY (doktor_id) REFERENCES kisi(id) ON DELETE SET NULL

    );

create table kisi_yorum(
    kisi_id int  DEFAULT NULL,
    yorum_id int  DEFAULT NULL,

    FOREIGN KEY (kisi_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (yorum_id) REFERENCES yorum(id) ON DELETE SET NULL
    );

create table recete(
    id int primary key auto_increment,
    aciklama varchar(200)
    
    );
create table tip(
    id int primary key auto_increment,
    aciklama varchar(200),
    adi varchar (20)
);

create table randevu(
    id int primary key auto_increment,
    baslik varchar(20),
    aciklama varchar(200),
    recete_id int,
    tarih TIMESTAMP,
    doktor_id int,
    hasta_id int,
    tip_id int,
    FOREIGN KEY (tip_id) REFERENCES tip(id) ON DELETE SET NULL,
    FOREIGN KEY (hasta_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (doktor_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (recete_id) REFERENCES recete(id) ON DELETE SET NULL

    );
create table randevu_tip(
    tip_id int,
    randevu_id int,
    FOREIGN KEY (randevu_id) REFERENCES randevu(id) ON DELETE SET NULL,
    FOREIGN KEY (tip_id) REFERENCES tip(id) ON DELETE SET NULL
);

create table doktor_hasta(    
    id int primary key auto_increment,
    randevu_id int  DEFAULT NULL,
    hasta_id int  DEFAULT NULL,
    doktor_id int  DEFAULT NULL,

    FOREIGN KEY (hasta_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (doktor_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (randevu_id) REFERENCES randevu(id) ON DELETE SET NULL
    );

create table adres(
    id int primary key auto_increment,
    adi varchar(50),
    adres varchar(200)
    );

create table klinik(
    id int primary key auto_increment,
    adi varchar(50),
    adres_id int,
    tel_no varchar(11),

    FOREIGN KEY (adres_id) REFERENCES adres(id) ON DELETE SET NULL

);

create table klinik_doktor(
    klinik_id int,
    doktor_id int,

    FOREIGN KEY (doktor_id) REFERENCES kisi(id) ON DELETE SET NULL,
    FOREIGN KEY (klinik_id) REFERENCES klinik(id) ON DELETE SET NULL
);
    

