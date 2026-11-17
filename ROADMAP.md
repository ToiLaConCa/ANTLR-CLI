# ROADMAP: ANTLR CLI (Easier to use)

> **Dự án:** ANTLR CLI (#toolbyphichxivnuk)  
> **Hỗ trợ:** Fedora, CachyOS, Arch Linux, Ubuntu, Debian, openSUSE

Làm lần lượt từ trên xuống. Mỗi bước có lệnh kiểm tra, ra đúng kết quả rồi mới sang bước sau.

---

## Bước 1: Tải hoặc Clone repository

```bash
git clone https://github.com/ToiLaConCa/antlr-fedora-kit.git antlr-cli
cd antlr-cli
chmod +x install.sh test.sh bin/* examples/*/*.sh
```

---

## Bước 2: Chạy script cài đặt tự động

```bash
./install.sh
```

**Script sẽ tự động thực hiện tất cả:**
1. Tự động kiểm tra các gói hệ thống còn thiếu (JDK, g++, cmake, make, git, unzip) và cài đặt tự động theo distro của bạn (Arch/CachyOS dùng `pacman`, Fedora dùng `dnf`, Ubuntu/Debian dùng `apt`).
2. Copy `antlr-4.13.2-complete.jar` vào `~/antlr/`.
3. Tự động build và cài đặt runtime C++ vào `~/antlr/antlr4-dev/`.
4. Cài đặt các lệnh CLI tiện ích vào `~/.local/bin/`:
   - `antlr4` (biên dịch file .g4)
   - `grun` (TestRig kiểm thử cây cú pháp)
   - `helpantlr` / `antlr-cli` (hướng dẫn tương tác)
5. Thiết lập biến môi trường vào `~/.config/antlr/env.sh` và tự thêm vào `.bashrc` / `.zshrc`.

*Tùy chọn nâng cao:*
- Nếu đã có đủ gói phần mềm: `./install.sh --skip-deps`
- Nếu chỉ muốn dùng Java / TestRig (bỏ qua build C++): `./install.sh --no-cpp`

---

## Bước 3: Nạp biến môi trường

Đóng terminal mở lại, hoặc nạp ngay:
```bash
source ~/.config/antlr/env.sh
```

---

## Bước 4: Kiểm tra nhanh công cụ

```bash
helpantlr
# hoặc:
antlr4 -helpantlr
```

Dòng lệnh sẽ in ra hướng dẫn A-Z cực kỳ chi tiết kèm ví dụ grammar mẫu.

---

## Bước 5: Chạy bộ kiểm thử tự động (Test Suite)

```bash
bash test.sh
```
Kết quả hiển thị `Ket qua: 6 dat, 0 loi` là toàn bộ hệ thống đã hoạt động hoàn hảo!
