#!/bin/bash

echo "🚀 Soundness ortam kurulumu başlıyor..."

# 1. Windows satır sonları hatasını düzelt
echo "🔧 Windows satır sonları (CRLF) hatası düzeltiliyor..."
dos2unix "$0"  # Kendi script'ini dönüştürür

# 2. Sistem güncellemesi
echo "🔄 Sunucu güncelleniyor..."
sudo apt update -y && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# 3. Gerekli Paketleri İndirme
echo "📦 Gerekli paketler indiriliyor..."
sudo apt install -y curl git build-essential pkg-config libssl-dev libreadline-dev libffi-dev protobuf-compiler dos2unix htop ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables nvme-cli wget make jq libleveldb-dev ncdu tar clang bsdmainutils lsb-release libffi-dev jq gcc screen file unzip lz4

# 4. Protobuf Compiler İndirme
echo "📥 Protobuf compiler indiriliyor..."
sudo apt install -y protobuf-compiler

# 5. Rust Kurulumu
echo "🦀 Rust kuruluyor..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 6. Rust ortamını aktif et
echo "🌟 Rust ortamı aktifleştiriliyor..."
source $HOME/.cargo/env

# 7. Soundness Kurulumu
echo "📥 Soundness indiriliyor..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# 8. .bashrc güncelleme
echo "🔧 .bashrc güncelleniyor..."
source ~/.bashrc

# 9. Soundness kurulumunu yapma
echo "⚙️ Soundness kurulumu yapılıyor..."
soundnessup install

# 10. Soundness güncellemesi
echo "⚡ Soundness güncelleniyor..."
soundnessup update

# 11. Kontrol
if command -v soundness-cli &> /dev/null; then
    echo "✅ soundness-cli başarıyla kuruldu!"
else
    echo "❌ soundness-cli bulunamadı. Lütfen shell'i yeniden başlatın."
fi

echo "🎉 Kurulum tamamlandı!"
