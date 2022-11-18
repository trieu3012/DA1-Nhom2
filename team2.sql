create database team2
go
use team2
go

--DoanhThu
if object_id ('DoanhThu') is not null
	drop table DoanhThu
go
create table DoanhThu
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	doanhThu decimal(20,0) default 0,
	idCH uniqueidentifier foreign key (idCH) references CuaHang(id)
)

--CuaHang
if object_id ('CuaHang') is not null
	drop table CuaHang
go
create table CuaHang
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(20) default null,
	diaChi nvarchar(99) default null,
	thanhPho nvarchar(25) default null,
)

--ChucVu
if object_id ('ChucVu') is not null
	drop table ChucVu
go
create table ChucVu
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(20) default null
)

--NhanVien
if object_id ('NhanVien') is not null
	drop table NhanVien
go
create table NhanVien
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(40) default null,
	gioiTinh bit default null,
	diaChi nvarchar(99) default null,
	ngaySinh date default null,
	idCV uniqueidentifier foreign key (idCV) references ChucVu(id),
	idCH uniqueidentifier foreign key (idCH) references CuaHang(id),
	trangThai int default null
)

--CaLamNhanVien
if object_id ('CaLam') is not null
	drop table CaLam
go
create table CaLam
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	thoiGianBatDau datetime,
	thoiGianKetThuc datetime,
	idNV uniqueidentifier foreign key (idNV) references NhanVien(id),
	trangThai int default null
)

--KhachHang
if object_id ('KhachHang') is not null
	drop table KhachHang
go
create table KhachHang
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(40) default null,
	gioiTinh bit default null,
	diaChi nvarchar(99) default null,
	ngaySinh date default null,
	matKhau varchar(20) default null,
	trangThai nvarchar(20) default null
)

--SanPham
if object_id ('SanPham') is not null
	drop table SanPham
go
create table SanPham
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(30) default null
)

--MauSac
if object_id ('MauSac') is not null
	drop table MauSac
go
create table MauSac
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(30) default null
)

-- NhaSanXuat
if object_id ('NSX') is not null
	drop table NSX
go
create table NSX
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(30) default null
)

--KhuyenMai
if object_id ('KhuyenMai') is not null
	drop table KhuyenMai
go
create table KhuyenMai
(
	id uniqueidentifier primary key default newid(),
	ma varchar(10) unique,
	ten nvarchar(30) default null,
	ngayBatDau date default null,
	ngayKetThuc date default null,
	phanTramGiam float default 0,
)

--ChiTietSanPham
if object_id ('SPCT') is not null
	drop table SPCT
go
create table SPCT
(
	id uniqueidentifier primary key default newid(),
	idSP uniqueidentifier foreign key (idSP) references SanPham(id),
	idMS uniqueidentifier foreign key (idMS) references MauSac(id),
	idNSX uniqueidentifier foreign key (idNSX) references NSX(id),
	namBH int default null,
	soLuongCon int default 0,
	giaNhap decimal(20,0) default 0,
	giaBan decimal(20,0) default 0,
	moTa nvarchar(50) default null
)

--HoaDon
if object_id ('HoaDon') is not null
	drop table HoaDon
go
create table HoaDon
(
	id uniqueidentifier primary key default newid(),
	idKH uniqueidentifier foreign key (idKH) references KhachHang(id),
	idNV uniqueidentifier foreign key (idNV) references NhanVien(id),
	idKM uniqueidentifier foreign key (idKM) references KhuyenMai(id),
	ma varchar(10) unique,
	ngayTao date default null,
	ngayThanhToan date default null,
	ngayMongMuonNhan date default null,
	ngayGui date default null,
	ngayNhan date default null,
	tinhTrang int default null,
	tenNguoiNhan nvarchar(50) default null,
	diaChi nvarchar(99) default null,
	sdt varchar(11) default null
)

--HoaDonChiTiet
if object_id ('HDCT') is not null
	drop table HDCT
go
create table HDCT
(
	idHD uniqueidentifier,
	idSPCT uniqueidentifier,
	soLuong int,
	donGia decimal(20,0) default 0,
	constraint PK_HDCT primary key (idHD, idSPCT),
	constraint FK1_HD foreign key (idHD) references HoaDon(id),
	constraint FK2_SPCT foreign key (idSPCT) references SPCT(id), 
)

--BaoHanh
if object_id ('BaoHanh') is not null
	drop table BaoHanh
go
create table BaoHanh
(
	id uniqueidentifier primary key default newid(),
	idKH uniqueidentifier foreign key (idKH) references KhachHang(id),
	idHD uniqueidentifier foreign key (idHD) references HoaDon(id),
	ma varchar(10) unique,
	ngayBatDau date default null,
	ngayKetThuc date default null
)

--BaoHanhChiTiet
if object_id ('BHCT') is not null
	drop table BHCT
go
create table BHCT
(
	idBH uniqueidentifier,
	idSPCT uniqueidentifier,
	moTa nvarchar(99) default null,
	tinhTrang int default null,
	ngayMuaSP date,
	chiPhi decimal(20,0) default 0,
	constraint PK_BHCT primary key (idBH, idSPCT),
	constraint FK1_BH foreign key (idBH) references BaoHanh(id),
	constraint FK2_SPCT1 foreign key (idSPCT) references SPCT(id), 
)