# ANTLR CLI 🚀 (Easier to use)

> **Universal ANTLR 4 Toolkit & Automation CLI for Linux**  
> **Tag:** `#toolbyphichxivnuk` | **Version:** `2.0`  
> *Make ANTLR 4 easier to install, compile, debug and visualize on any Linux distribution!*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Arch%20%7C%20CachyOS%20%7C%20Fedora%20%7C%20Ubuntu%20%7C%20Debian-brightgreen.svg)]()
[![ANTLR Version](https://img.shields.io/badge/ANTLR-4.13.2-orange.svg)](https://www.antlr.org/)

---

## 🌟 Vì sao nên dùng ANTLR CLI? (Easier to use)

Việc cài đặt ANTLR 4 và runtime C++/Java trên Linux thường rất rắc rối với người mới: phải tự tải file JAR, chỉnh sửa `CLASSPATH`, cấu hình biến môi trường thủ công, tạo file wrapper `grun`, v.v.

**ANTLR CLI (`#toolbyphichxivnuk`)** sinh ra để biến toàn bộ quy trình đó thành **1 lệnh duy nhất**:
* ⚡ **Tự động kiểm tra & cài đặt phụ thuộc (Auto-Installer):** Nhận diện distro (Fedora, Arch/CachyOS, Ubuntu/Debian, openSUSE) và tự động cài JDK, CMake, g++, make.
* 📦 **Tích hợp trọn gói:** Đã bao gồm `antlr-4.13.2-complete.jar` và runtime C++ chính thức.
* 🛠️ **Bộ lệnh CLI tiện lợi:** Tự động tạo các lệnh `antlr4`, `grun`, `antlr-cli` và lệnh hướng dẫn tương tác `helpantlr` (hoặc cờ `-helpantlr`).
* 🎯 **Cầm tay chỉ việc cho người mới:** Tích hợp sẵn hướng dẫn soạn thảo ngữ pháp bằng `nano`, biên dịch và xem cây cú pháp đồ họa (`grun -gui`).

---

## 🚀 Cài đặt siêu nhanh (Quick Install)

Chỉ cần clone hoặc tải repository về và chạy:

```bash
cd antlr-kit
bash install.sh
```

> **Mẹo:** Sau khi cài đặt, chạy lệnh sau để nhận biến môi trường ngay trong terminal hiện tại (hoặc mở terminal mới):
> ```bash
> source ~/.config/antlr/env.sh
> ```

---

## 📖 Hướng dẫn sử dụng từ A - Z (Dành cho người mới)

Chỉ cần gõ lệnh sau để xem hướng dẫn trực quan bất cứ lúc nào:
```bash
helpantlr
# hoặc:
antlr4 -helpantlr
```

### Bước 1: Soạn file Ngữ pháp (`.g4`) bằng `nano`

Mở terminal và gõ:
```bash
nano Hello.g4
```

Dán nội dung sau vào file:
```antlr4
grammar Hello;

// Parser Rule (bắt đầu bằng chữ thường):
r : 'hello' ID ;

// Lexer Rules (bắt đầu bằng chữ IN HOA):
ID : [a-zA-Z]+ ;
WS : [ \t\r\n]+ -> skip ;
```
*(Nhấn `Ctrl + O` rồi `Enter` để Lưu; Nhấn `Ctrl + X` để Thoát nano)*

> 💡 **Mẹo tạo nhanh:** Gõ lệnh `helpantlr --example` để tự động sinh file mẫu `Hello.g4` mà không cần gõ tay!

---

### Bước 2: Biên dịch file `.g4` sang mã nguồn bằng `antlr4`

* **Dành cho Java (Mặc định):**
  ```bash
  antlr4 Hello.g4
  ```
  *(Hệ thống sẽ sinh ra các file: `HelloLexer.java`, `HelloParser.java`, `HelloListener.java`...)*

* **Dành cho C++:**
  ```bash
  antlr4 -Dlanguage=Cpp Hello.g4
  ```

---

### Bước 3: Biên dịch code Java bằng `javac`

```bash
javac Hello*.java
```

---

### Bước 4: Kiểm thử cây cú pháp bằng `grun` (TestRig)

Cú pháp chuẩn: `grun <Tên_Grammar> <Tên_Luật_Bắt_Đầu> [Tùy_Chọn]`

#### 1. Xem danh sách Token:
```bash
grun Hello r -tokens
```
Nhập chuỗi kiểm thử:
```text
hello world
```
Sau đó nhấn **Enter**, rồi nhấn tổ hợp phím **`Ctrl + D`** để báo kết thúc đầu vào.

#### 2. Xem cây cú pháp dạng chữ (Tree):
```bash
grun Hello r -tree
```

#### 3. Hiển thị cây cú pháp trực quan (Giao diện đồ họa GUI):
```bash
grun Hello r -gui
```
Một cửa sổ trực quan sinh động sẽ xuất hiện hiển thị cây phân tích cú pháp (Parse Tree)!

---

## 📂 Cấu trúc Repository

```text
ANTLR-CLI/
├── bin/
│   ├── antlr4            # Wrapper gọi antlr4 jar (hỗ trợ cờ -helpantlr)
│   ├── grun              # Wrapper gọi TestRig GUI/tokens
│   ├── helpantlr         # CLI hướng dẫn tương tác (#toolbyphichxivnuk)
│   └── antlr-cli -> helpantlr
├── examples/
│   ├── tokens/           # Ví dụ mẫu phân tích Token
│   ├── calculator/       # Ví dụ máy tính Calculator (C++ parser)
│   └── identifier/       # Ví dụ kiểm tra định danh CIdentifier (C++ lexer)
├── jar/
│   └── antlr-4.13.2-complete.jar
├── runtime-cpp/          # Mã nguồn ANTLR C++ Runtime 4.13.2
├── install.sh            # Trình cài đặt tự động đa nền tảng
├── test.sh               # Kịch bản kiểm thử tự động
└── README.md
```

---

## 🧪 Tự động kiểm thử (Test Suite)

Để kiểm tra toàn bộ hoạt động của ANTLR Java và C++ runtime trên máy bạn:

```bash
bash test.sh
```

Kết quả mong đợi: `Ket qua: 6 dat, 0 loi`.

---

## 🏷️ Tác giả & Bản quyền
* **Phát triển & Đóng gói:** phichxi (`#toolbyphichxivnuk`)
* **Khẩu hiệu:** *ANTLR CLI — Easier to use!*
* **Dựa trên:** ANTLR 4.13.2 chính thức của Terence Parr và cộng đồng ANTLR.
