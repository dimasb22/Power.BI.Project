-- database portfolio_project
select * from garis_kemiskinan;
select * from avr_upah;
select * from pengeluaran_perkapita;
select * from ump;

-- setting table
select * from namaprovinsi;
ALTER TABLE garis_kemiskinan ADD FOREIGN KEY (tahun) REFERENCES ump_pertahun (tahun);
ALTER TABLE ump MODIFY COLUMN provinsi VARCHAR(50);
describe ump_pertahun;
-- langsung create table dari filter
drop table ump_pertahun;
create table ump_pertahun as select ump, tahun from ump group by tahun;
select * from ump_pertahun;
ALTER TABLE ump_pertahun ADD PRIMARY KEY (tahun);
ALTER TABLE avr_upah DROP FOREIGN KEY avr_upah_ibfk_2;
ALTER TABLE ump_pertahun MODIFY COLUMN tahun DATE; 

-- data pengeluaran perkapita dan ump
select pp.daerah, pp.jenis, pp.peng, ump.provinsi, ump.tahun, ump.ump from pengeluaran_perkapita as pp 
inner join ump  on pp.provinsi = ump.provinsi and pp.tahun = ump.tahun;

-- data garis kemiskinan tiap provinsi dan rata-rata upah
select * from garis_kemiskinan as gk 
inner join avr_upah au on gk.provinsi = au.provinsi and gk.tahun = au.tahun order by gk.tahun;

-- provinsi dengan garis kemiskinan tertinggi pada tahun 2022
select * from garis_kemiskinan where tahun = 2022 order by gk desc;

-- perbandingan jumlah garis kemiskinan antara 2017-2019 dan 2020-2022
select sum(gk) from garis_kemiskinan where tahun between 2017 and 2019;
select sum(gk) from garis_kemiskinan where tahun between 2020 and 2022;

select * from garis_kemiskinan where provinsi not in ("ACEH", "SUMATERA UTARA");

-- LANJUTT VISUALISASI POWER BI