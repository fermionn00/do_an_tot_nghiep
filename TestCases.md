
| ID | Test Case | Description | Pre-condition | Steps | Expected Result | Status |
|----|-----------|-------------|---------------|-------|-----------------|--------|
| TC01 | Đăng nhập thành công | Kiểm tra chức năng đăng nhập với tài khoản hợp lệ | Đã có tài khoản nhân viên | 1. Mở app<br>2. Nhập email/password đúng<br>3. Nhấn Login | Chuyển vào màn hình Home, hiển thị đúng thông tin user | Pass |
| TC02 | Đăng nhập thất bại | Kiểm tra đăng nhập với mật khẩu sai | Đã có tài khoản | 1. Mở app<br>2. Nhập email đúng, password sai<br>3. Nhấn Login | Hiện thông báo lỗi "Thông tin đăng nhập không chính xác" | Pass |
| TC03 | Check-in Wifi | Kiểm tra chức năng check-in khi dùng Wifi công ty | Đang ở công ty, kết nối Wifi công ty | 1. Ở màn hình Home<br>2. Nhấn nút Check-in<br>3. Chọn "Check-in tại văn phòng" | Hiển thị "Check-in thành công", cập nhật giờ Check-in | Pass |
| TC04 | Check-in GPS | Kiểm tra chức năng check-in bằng GPS | Đang ở vị trí công ty | 1. Ở màn hình Home<br>2. Bật GPS<br>3. Nhấn Check-in | Hiển thị "Check-in thành công" nếu trong bán kính cho phép | Pass |
| TC05 | Xem lịch sử chấm công | Kiểm tra hiển thị lịch sử | Đã có dữ liệu chấm công | 1. Vào tab Chấm công (Attendance)<br>2. Chọn tháng hiện tại | Hiển thị danh sách ngày công, giờ vào/ra đúng dữ liệu | Pass |
| TC06 | Xin nghỉ phép | Kiểm tra tạo đơn xin nghỉ | Đăng nhập thành công | 1. Vào tab Xin nghỉ<br>2. Tạo đơn mới<br>3. Chọn ngày, lý do<br>4. Submit | Đơn được gửi, trạng thái "Waiting" | Pass |
| TC07 | Thống kê trang Home | Kiểm tra các con số thống kê | Có dữ liệu công trong tháng | 1. Vào màn hình Home<br>2. Xem Box thống kê | Số ngày công, giờ làm hiển thị đúng tổng cộng | Pass |
| TC08 | Logout | Kiểm tra đăng xuất | Đang đăng nhập | 1. Vào Profile<br>2. Nhấn Logout | Chuyển về màn hình Login, xóa session | Pass |
