# FastPlace 1.8.9 — مخصوص GitHub Codespaces

این پروژه برای Minecraft Java 1.8.9 + Forge ساخته شده است.

## ساخت با گوشی و GitHub Codespaces

1. این پوشه را در یک Repository جدید GitHub آپلود کن.
2. در GitHub روی `Code` → `Codespaces` → `Create codespace on main` بزن.
3. صبر کن محیط آماده شود. این پروژه از Java 8 استفاده می‌کند.
4. در Terminal پایین VS Code این دستور را بزن:

```bash
./build.sh
```

5. بعد از موفقیت، فایل مود در این مسیر است:

```text
build/libs/FastPlace-1.0.jar
```

## نکته

اگر Codespace با محیط قدیمی باز شد، از Command Palette گزینه `Codespaces: Rebuild Container` را اجرا کن.

## بدون Codespace

یک GitHub Actions هم داخل پروژه قرار داده شده است. از تب `Actions` می‌توانی workflow با نام `Build FastPlace 1.8.9` را اجرا کنی و JAR ساخته‌شده را به عنوان Artifact بگیری.
