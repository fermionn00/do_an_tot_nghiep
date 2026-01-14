SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE `leaves`;
TRUNCATE TABLE `attendances`;
TRUNCATE TABLE `users`;
TRUNCATE TABLE `departments`;
TRUNCATE TABLE `shifts`;
TRUNCATE TABLE `companies`;
TRUNCATE TABLE `settings`; 

-- =============================================
-- 2. BẢNG COMPANIES (CÔNG TY)
-- =============================================
INSERT INTO `companies` (`id`, `name`, `representative_name`, `company_code`, `address`, `category_code`, `status_code`, `type_check_login`, `type_work`, `max_distance`, `created_at`, `updated_at`) VALUES
(1, 'TechCorp Việt Nam', 'Nguyễn Nhật Minh', 'VN-TECH-01', 'Tầng 12, Keangnam Landmark 72, Hà Nội', 1, 1, 1, 1, 500, NOW(), NOW());

-- =============================================
-- 3. BẢNG SHIFTS (CA LÀM VIỆC)
-- =============================================
INSERT INTO `shifts` (`id`, `company_id`, `name`, `time_start`, `time_end`, `duration`, `status_code`, `type`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ca Hành Chính', '08:00:00', '17:30:00', '08:00:00', 1, 1, NOW(), NOW()),
(2, 1, 'Ca Chiều Tối', '13:30:00', '22:00:00', '08:00:00', 1, 1, NOW(), NOW());

-- =============================================
-- 4. BẢNG DEPARTMENTS (PHÒNG BAN)
-- =============================================
INSERT INTO `departments` (`id`, `company_id`, `manager_id`, `name`, `status_code`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Ban Giám Đốc', 1, NOW(), NOW()),
(2, 1, 2, 'Phòng Kỹ Thuật (IT)', 1, NOW(), NOW()),
(3, 1, 3, 'Phòng Nhân Sự (HR)', 1, NOW(), NOW()),
(4, 1, 4, 'Phòng Kinh Doanh (Sales)', 1, NOW(), NOW()),
(5, 1, 5, 'Phòng Marketing', 1, NOW(), NOW());

-- =============================================
-- 5. BẢNG SETTINGS (CẤU HÌNH)
-- =============================================
-- Lưu ý: Cột 'depcription' giữ nguyên theo migration file bạn gửi
INSERT INTO `settings` (`id`, `depcription`) VALUES 
(1, '{"wifi_check": true, "gps_check": true, "ip_check": false}'),
(2, '{"max_late_minutes": 15, "max_early_leave_minutes": 15}'),
(3, '{"timezone": "Asia/Ho_Chi_Minh", "currency": "VND"}'),
(4, '{"notification_enabled": true}');

-- =============================================
-- 6. BẢNG USERS (50 NHÂN VIÊN)
-- =============================================
INSERT INTO `users` (`id`, `email`, `company_id`, `employee_code`, `first_name`, `last_name`, `address`, `password`, `phone_number`, `status_code`, `type_login`, `role_code`, `time_zone`, `shift_id`, `department_id`, `status`, `created_at`, `updated_at`) VALUES
-- Ban Giám Đốc (Admin)
(1, 'nhatminh.nguyen@techcorp.com', 1, 'GD-001', 'Nhật Minh', 'Nguyễn', 'Ba Đình, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0901000001', 1, 1, 99, 7, 1, 1, 1, NOW(), NOW()),

-- Phòng IT (Manager: Tran Van Hung)
(2, 'hung.tran@techcorp.com', 1, 'IT-001', 'Văn Hùng', 'Trần', 'Cầu Giấy, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0902000002', 1, 1, 2, 7, 1, 2, 1, NOW(), NOW()),
(6, 'duc.le@techcorp.com', 1, 'IT-002', 'Minh Đức', 'Lê', 'Thanh Xuân, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0975123456', 1, 1, 1, 7, 1, 2, 1, NOW(), NOW()),
(7, 'thang.pham@techcorp.com', 1, 'IT-003', 'Chiến Thắng', 'Phạm', 'Hà Đông, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0986123456', 1, 1, 1, 7, 1, 2, 1, NOW(), NOW()),
(8, 'dat.nguyen@techcorp.com', 1, 'IT-004', 'Thành Đạt', 'Nguyễn', 'Long Biên, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0912345678', 1, 1, 1, 7, 2, 2, 1, NOW(), NOW()),
(9, 'hoang.vu@techcorp.com', 1, 'IT-005', 'Huy Hoàng', 'Vũ', 'Đống Đa, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0933456789', 1, 1, 1, 7, 2, 2, 1, NOW(), NOW()),
(10, 'tuan.do@techcorp.com', 1, 'IT-006', 'Anh Tuấn', 'Đỗ', 'Hoàng Mai, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0944567890', 1, 1, 1, 7, 1, 2, 1, NOW(), NOW()),
(11, 'bao.bui@techcorp.com', 1, 'IT-007', 'Quốc Bảo', 'Bùi', 'Nam Từ Liêm, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0955678901', 1, 1, 1, 7, 1, 2, 1, NOW(), NOW()),
(12, 'kien.dang@techcorp.com', 1, 'IT-008', 'Trung Kiên', 'Đặng', 'Bắc Từ Liêm, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0966789012', 1, 1, 1, 7, 2, 2, 1, NOW(), NOW()),
(13, 'long.hoang@techcorp.com', 1, 'IT-009', 'Thành Long', 'Hoàng', 'Tây Hồ, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0977890123', 1, 1, 1, 7, 2, 2, 1, NOW(), NOW()),
(14, 'phuc.duong@techcorp.com', 1, 'IT-010', 'Hồng Phúc', 'Dương', 'Hai Bà Trưng, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0988901234', 1, 1, 1, 7, 1, 2, 1, NOW(), NOW()),

-- Phòng HR (Manager: Le Thi Mai)
(3, 'mai.le@techcorp.com', 1, 'HR-001', 'Thị Mai', 'Lê', 'Hoàn Kiếm, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0903000003', 1, 1, 2, 7, 1, 3, 1, NOW(), NOW()),
(15, 'lan.nguyen@techcorp.com', 1, 'HR-002', 'Ngọc Lan', 'Nguyễn', 'Cầu Giấy, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0912001122', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(16, 'hang.pham@techcorp.com', 1, 'HR-003', 'Thu Hằng', 'Phạm', 'Thanh Xuân, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0923112233', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(17, 'trang.vu@techcorp.com', 1, 'HR-004', 'Thùy Trang', 'Vũ', 'Đống Đa, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0934223344', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(18, 'linh.hoang@techcorp.com', 1, 'HR-005', 'Khánh Linh', 'Hoàng', 'Hà Đông, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0945334455', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(19, 'huong.tran@techcorp.com', 1, 'HR-006', 'Thu Hương', 'Trần', 'Long Biên, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0956445566', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(20, 'thao.ngo@techcorp.com', 1, 'HR-007', 'Phương Thảo', 'Ngô', 'Hoàng Mai, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0967556677', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(21, 'hoa.bui@techcorp.com', 1, 'HR-008', 'Thanh Hoa', 'Bùi', 'Nam Từ Liêm, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0978667788', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(22, 'van.do@techcorp.com', 1, 'HR-009', 'Thúy Vân', 'Đỗ', 'Bắc Từ Liêm, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0989778899', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),
(23, 'ngoc.dao@techcorp.com', 1, 'HR-010', 'Bảo Ngọc', 'Đào', 'Tây Hồ, Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0990889900', 1, 1, 1, 7, 1, 3, 1, NOW(), NOW()),

-- Phòng Sales (Manager: Pham Duc Thang)
(4, 'thang.sales@techcorp.com', 1, 'SL-001', 'Đức Thắng', 'Phạm', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0904000004', 1, 1, 2, 7, 1, 4, 1, NOW(), NOW()),
(24, 'dung.nguyen@techcorp.com', 1, 'SL-002', 'Tiến Dũng', 'Nguyễn', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0901111001', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(25, 'hung.le@techcorp.com', 1, 'SL-003', 'Mạnh Hùng', 'Lê', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0902222002', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(26, 'cuong.tran@techcorp.com', 1, 'SL-004', 'Quốc Cường', 'Trần', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0903333003', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(27, 'nam.hoang@techcorp.com', 1, 'SL-005', 'Hải Nam', 'Hoàng', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0904444004', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(28, 'son.vu@techcorp.com', 1, 'SL-006', 'Thái Sơn', 'Vũ', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0905555005', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(29, 'lam.ngo@techcorp.com', 1, 'SL-007', 'Tùng Lâm', 'Ngô', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0906666006', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(30, 'hieu.dang@techcorp.com', 1, 'SL-008', 'Trung Hiếu', 'Đặng', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0907777007', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(31, 'duy.bui@techcorp.com', 1, 'SL-009', 'Khánh Duy', 'Bùi', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0908888008', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(32, 'khoa.pham@techcorp.com', 1, 'SL-010', 'Đăng Khoa', 'Phạm', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0909999009', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(33, 'huy.phan@techcorp.com', 1, 'SL-011', 'Quang Huy', 'Phan', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0910000010', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(34, 'minh.trinh@techcorp.com', 1, 'SL-012', 'Văn Minh', 'Trịnh', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0911111011', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),
(35, 'an.ly@techcorp.com', 1, 'SL-013', 'Bình An', 'Lý', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0912222012', 1, 1, 1, 7, 2, 4, 1, NOW(), NOW()),

-- Phòng Marketing (Manager: Hoang Thi Bich)
(5, 'bich.hoang@techcorp.com', 1, 'MKT-001', 'Thị Bích', 'Hoàng', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0905000005', 1, 1, 2, 7, 1, 5, 1, NOW(), NOW()),
(36, 'nhung.nguyen@techcorp.com', 1, 'MKT-002', 'Hồng Nhung', 'Nguyễn', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0920111222', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(37, 'chi.tran@techcorp.com', 1, 'MKT-003', 'Kim Chi', 'Trần', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0921222333', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(38, 'phuong.le@techcorp.com', 1, 'MKT-004', 'Minh Phương', 'Lê', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0922333444', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(39, 'dung.pham@techcorp.com', 1, 'MKT-005', 'Thùy Dung', 'Phạm', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0923444555', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(40, 'anh.vu@techcorp.com', 1, 'MKT-006', 'Vân Anh', 'Vũ', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0924555666', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(41, 'tam.hoang@techcorp.com', 1, 'MKT-007', 'Thanh Tâm', 'Hoàng', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0925666777', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(42, 'loan.ngo@techcorp.com', 1, 'MKT-008', 'Thanh Loan', 'Ngô', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0926777888', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(43, 'ha.dang@techcorp.com', 1, 'MKT-009', 'Thu Hà', 'Đặng', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0927888999', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(44, 'tram.bui@techcorp.com', 1, 'MKT-010', 'Bích Trâm', 'Bùi', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0928999000', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(45, 'quynh.do@techcorp.com', 1, 'MKT-011', 'Như Quỳnh', 'Đỗ', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0929000111', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(46, 'tien.duong@techcorp.com', 1, 'MKT-012', 'Thủy Tiên', 'Dương', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0930111222', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(47, 'vi.luong@techcorp.com', 1, 'MKT-013', 'Tường Vi', 'Lương', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0931222333', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(48, 'khanh.trinh@techcorp.com', 1, 'MKT-014', 'Mai Khanh', 'Trịnh', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0932333444', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(49, 'yen.ly@techcorp.com', 1, 'MKT-015', 'Hải Yến', 'Lý', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0933444555', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW()),
(50, 'ngan.vo@techcorp.com', 1, 'MKT-016', 'Kim Ngân', 'Võ', 'Hà Nội', '$2y$10$d4aw/slnSpX7/tVhDBB8OfO5Mh9BR7msC6uL4xiWjD6pzxEpBvYQbq', '0934555666', 1, 1, 1, 7, 1, 5, 1, NOW(), NOW());

-- 5. Cập nhật Admin cho Công Ty
UPDATE `companies` SET `admin_id` = 1 WHERE `id` = 1;

-- =============================================
-- 7. BẢNG ATTENDANCES (CHẤM CÔNG)
-- =============================================
-- Tạo dữ liệu cho hôm nay và hôm qua
INSERT INTO `attendances` (`user_id`, `company_id`, `shift_id`, `time_checkin`, `time_checkout`, `duration`, `month`, `type_checkin`, `type_work`, `status_code`, `reason`, `created_at`, `updated_at`) VALUES
-- 1. Chấm công hôm nay (Admin & IT Team)
(1, 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 9 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
(2, 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 9 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
(6, 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 9 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
(7, 1, 1, DATE_ADD(NOW(), INTERVAL 15 MINUTE), DATE_ADD(NOW(), INTERVAL 9 HOUR), '08:45:00', MONTH(NOW()), 1, 1, 2, 'Đi muộn 15p', NOW(), NOW()), -- Đi muộn
-- 2. Chấm công hôm nay (Sales Team - Ca chiều)
(24, 1, 2, DATE_ADD(NOW(), INTERVAL 5 HOUR), DATE_ADD(NOW(), INTERVAL 14 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
(25, 1, 2, DATE_ADD(NOW(), INTERVAL 5 HOUR), DATE_ADD(NOW(), INTERVAL 14 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
-- 3. Chấm công HÔM QUA (Để test report)
(1, 1, 1, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 15 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW()),
(2, 1, 1, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 15 HOUR), '09:00:00', MONTH(NOW()), 1, 1, 1, 'Đúng giờ', NOW(), NOW());

-- =============================================
-- 8. BẢNG LEAVES (ĐƠN NGHỈ PHÉP)
-- =============================================
-- Trạng thái (status_code): 1: Chờ duyệt, 2: Đã duyệt, 3: Từ chối
INSERT INTO `leaves` (`user_id`, `company_id`, `to_approve_id`, `approve_id`, `time_start`, `time_end`, `duration`, `month`, `status_code`, `type`, `reason`, `reason_reject`, `created_at`, `updated_at`) VALUES
-- 1. Đơn chờ duyệt: Nhân viên IT (6) gửi Manager IT (2)
(6, 1, 2, NULL, DATE_ADD(NOW(), INTERVAL 2 DAY), DATE_ADD(NOW(), INTERVAL 3 DAY), '16:00:00', MONTH(NOW()), 1, 1, 'Xin nghỉ phép đi du lịch gia đình', NULL, NOW(), NOW()),

-- 2. Đơn đã duyệt: Nhân viên HR (15) gửi Manager HR (3)
(15, 1, 3, 3, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), '08:00:00', MONTH(NOW()), 2, 1, 'Bị ốm sốt', NULL, DATE_SUB(NOW(), INTERVAL 6 DAY), NOW()),

-- 3. Đơn từ chối: Nhân viên Sales (24) gửi Manager Sales (4)
(24, 1, 4, 4, DATE_ADD(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 1 DAY), '08:00:00', MONTH(NOW()), 3, 1, 'Việc riêng đột xuất', 'Team đang chạy dự án gấp, không duyệt được em nhé', NOW(), NOW()),

-- 4. Đơn chờ duyệt: Manager IT (2) gửi Admin (1)
(2, 1, 1, NULL, DATE_ADD(NOW(), INTERVAL 10 DAY), DATE_ADD(NOW(), INTERVAL 12 DAY), '24:00:00', MONTH(NOW()), 1, 1, 'Nghỉ phép năm', NULL, NOW(), NOW());

SET FOREIGN_KEY_CHECKS=1;
