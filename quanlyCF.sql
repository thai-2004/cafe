-- Tạo bảng LoaiSanPham
CREATE TABLE LoaiSanPham (
    MaLoaiSanPham INT PRIMARY KEY,
    TenLoaiSanPham NVARCHAR(50)
);

-- Tạo bảng SanPham
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY,
    TenSanPham NVARCHAR(100),
    GiaTien DECIMAL(18, 2),
    MaLoaiSanPham INT,
    FOREIGN KEY (MaLoaiSanPham) REFERENCES LoaiSanPham(MaLoaiSanPham)
);

-- Tạo bảng TaiKhoan
CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY,
    TenDangNhap NVARCHAR(50),
    MatKhau NVARCHAR(50),
    VaiTro NVARCHAR(20) -- Vai tro co the la 'Chu', 'QuanLy', 'NhanVien'
);

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    TenKhachHang NVARCHAR(100),
    DiaChi NVARCHAR(200),
    DienThoai NVARCHAR(20),
    MaTaiKhoan INT,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY,
    TenNhanVien NVARCHAR(100),
    DiaChi NVARCHAR(200),
    DienThoai NVARCHAR(20),
    MaTaiKhoan INT,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Tạo bảng Ban
CREATE TABLE Ban (
    MaBan INT PRIMARY KEY,
    TenBan NVARCHAR(50),
    SoCho INT
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY,
    NgayLap DATE,
    MaNhanVien INT,
    MaKhachHang INT,
    MaBan INT,
    MaTaiKhoanNhanVien INT,
    MaTaiKhoanKhachHang INT,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaBan) REFERENCES Ban(MaBan),
    FOREIGN KEY (MaTaiKhoanNhanVien) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaTaiKhoanKhachHang) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Tạo bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    MaChiTietHoaDon INT PRIMARY KEY,
    MaHoaDon INT,
    MaSanPham INT,
    SoLuong INT,
    GiaTien DECIMAL(18, 2),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Thêm cột MaTaiKhoan vào bảng NhanVien để liên kết với bảng TaiKhoan
ALTER TABLE NhanVien
ADD MaTaiKhoan INT,
FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan);

-- Thêm cột MaTaiKhoan vào bảng KhachHang để liên kết với bảng TaiKhoan
ALTER TABLE KhachHang
ADD MaTaiKhoan INT,
FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan);

-- Thêm cột MaTaiKhoan vào bảng HoaDon để liên kết với bảng TaiKhoan (NhanVien)
ALTER TABLE HoaDon
ADD MaTaiKhoanNhanVien INT,
FOREIGN KEY (MaTaiKhoanNhanVien) REFERENCES TaiKhoan(MaTaiKhoan);

-- Thêm cột MaTaiKhoan vào bảng HoaDon để liên kết với bảng TaiKhoan (KhachHang)
ALTER TABLE HoaDon
ADD MaTaiKhoanKhachHang INT,
FOREIGN KEY (MaTaiKhoanKhachHang) REFERENCES TaiKhoan(MaTaiKhoan);


