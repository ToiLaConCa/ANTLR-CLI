# ROADMAP: cài ANTLR trên Fedora theo thứ tự

Làm lần lượt từ trên xuống. Mỗi bước có lệnh kiểm tra, ra đúng kết quả rồi mới sang bước sau.

## Bước 0: Giải nén kit

```bash
cd ~
unzip antlr-fedora-kit.zip
cd antlr-fedora-kit
chmod +x install.sh test.sh bin/* examples/*/*.sh
```

## Bước 1: Cập nhật hệ thống (khuyến nghị)

```bash
sudo dnf upgrade --refresh
```

## Bước 2: Chạy script cài đặt

```bash
./install.sh
```

Script tự làm (tương ứng bước 1-5 của guide Windows):
1. `dnf install` JDK, g++, cmake, make, git
2. Copy `antlr-4.13.2-complete.jar` vào `~/antlr/`
3. Build + cài runtime C++ vào `~/antlr/antlr4-dev/` (mất vài phút)
4. Cài lệnh `antlr4` và `grun` vào `~/.local/bin/`
5. Ghi biến môi trường vào `~/.config/antlr/env.sh` (bash/zsh) và `env.fish` (fish), tự thêm vào `.bashrc` / `config.fish`

Nếu đã tự cài gói bằng dnf rồi: `./install.sh --skip-deps`.

## Bước 3: Mở terminal mới

Đóng terminal, mở lại (hoặc `source ~/.config/antlr/env.sh`, với fish thì `source ~/.config/antlr/env.fish`).

## Bước 4: Kiểm tra công cụ

```bash
java -version
javac -version
g++ --version
cmake --version
antlr4
```

Dòng cuối phải in ra `ANTLR Parser Generator  Version 4.13.2` (tương đương `java -jar ...jar` ở guide).

## Bước 5: Chạy test tự động

```bash
./test.sh
```

Kết quả mong đợi: `Ket qua: 6 dat, 0 loi`.

## Bước 6: Ví dụ 1, Tokens + grun (slide)

```bash
cd examples/tokens
./run.sh
```

Kết quả giống slide:
```
line 1:4 token recognition error at: ';'
[@0,0:1='34',<NUMBER>,1:0]
[@1,2:3='rt',<ID>,1:2]
[@2,6:5='<EOF>',<EOF>,2:0]
```

Tự gõ input (thay cho `grun Tokens tokens -tokens` + `Ctrl+Z`):
```bash
grun Tokens tokens -tokens
# gõ: 34rt;   Enter   rồi Ctrl+D
```

## Bước 7: Ví dụ 2, Calculator (parser C++)

```bash
cd ../calculator
./build.sh
```

Kết quả giống guide:
```
Parse tree: (expr (expr 3) + (expr (expr 5) * (expr ( (expr (expr 2) - (expr 8)) ))))
```

## Bước 8: Ví dụ 3, Identifier (lexer C++)

```bash
cd ../identifier
./build.sh
echo 34rt    | ./iden     # Invalid identifier!
echo my_var1 | ./iden     # Valid C++ identifier: my_var1
```

## Bước 9: Làm project riêng

```bash
mkdir -p ~/antlr/projects/baitap && cd ~/antlr/projects/baitap
# 1. viết MyGrammar.g4
antlr4 -Dlanguage=Cpp -visitor MyGrammar.g4       # sinh code C++
# 2. viết main.cpp
g++ -std=c++17 main.cpp MyGrammarLexer.cpp MyGrammarParser.cpp -o app \
    -I"$ANTLR_HOME/antlr4-dev/include/antlr4-runtime" \
    -L"$ANTLR_HOME/antlr4-dev/lib" -lantlr4-runtime \
    -Wl,-rpath,"$ANTLR_HOME/antlr4-dev/lib"
./app
```

Với **lexer grammar** (như CIdentifier) thì file sinh ra là `CIdentifier.cpp`/`.h`, không có đuôi `Lexer`. Với **grammar thường** (như Calculator) mới có `CalculatorLexer` và `CalculatorParser`.

Thử nhanh bằng Java + grun (không cần C++):
```bash
antlr4 MyGrammar.g4 && javac MyGrammar*.java
grun MyGrammar expr -tree      # in cây dạng text, Ctrl+D để kết thúc
grun MyGrammar expr -gui       # cửa sổ vẽ cây (cần môi trường đồ hoạ)
```

## Xử lý lỗi thường gặp

| Lỗi                                              | Cách xử lý                                                                 |
|--------------------------------------------------|----------------------------------------------------------------------------|
| `antlr4: command not found`                      | Chưa mở terminal mới. Chạy `source ~/.config/antlr/env.sh` (fish: `env.fish`). |
| `javac: command not found`                       | Thiếu JDK: `sudo dnf install java-latest-openjdk-devel`.                   |
| `cannot find -lantlr4-runtime`                   | Runtime chưa cài. Chạy lại `./install.sh`, xem lỗi ở bước build cmake.     |
| `error while loading shared libraries: libantlr4-runtime.so` | Thiếu `-Wl,-rpath,...` khi biên dịch, hoặc chưa nạp `env.sh` (đặt `LD_LIBRARY_PATH`). |
| `antlr4-runtime.h: No such file`                 | Sai đường dẫn `-I`; phải là `.../antlr4-dev/include/antlr4-runtime`.        |
| `CalculatorBaseVisitor.h` không tồn tại          | Quên cờ `-visitor` khi chạy antlr4.                                        |
| Lỗi biên dịch về `std::` / `string_view`         | Quên `-std=c++17`.                                                         |
| `Could not find or load main class org.antlr.v4.gui.TestRig` | Chạy `grun` ngoài thư mục có file `.class` (cần `javac *.java` trước). |
| CMake đòi tải gtest                              | Build runtime thiếu `-DANTLR_BUILD_CPP_TESTS=OFF` (install.sh đã có).       |
| Lệnh `antlr4` trỏ nhầm bản khác của Fedora       | `which antlr4` phải ra `~/.local/bin/antlr4`; đưa `~/.local/bin` lên đầu PATH. |
