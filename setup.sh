#!/bin/bash

echo "🚀 Soundness ortam kurulumu başlatılıyor..."

# 1. Sunucu Güncelleme
echo "🔄 Sistem güncelleniyor..."
sudo apt update -y && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# 2. Gerekli Paketleri İndirme
echo "📦 Gerekli paketler kuruluyor..."
sudo apt install -y htop ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables curl nvme-cli git wget make jq libleveldb-dev build-essential pkg-config ncdu tar clang bsdmainutils lsb-release libssl-dev libreadline-dev libffi-dev jq gcc screen file unzip lz4

# Protobuf Compiler
echo "📦 Protobuf compiler kuruluyor..."
sudo apt install -y protobuf-compiler

# Rust Kurulumu
echo "🦀 Rust kuruluyor..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Rust ortam değişkeni
echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
source "$HOME/.cargo/env"

# Soundnessup İndirme
echo "📥 soundnessup indiriliyor..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# PATH güncellemesi
echo 'export PATH="$HOME/.soundness/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Soundness CLI Kurulumu
echo "⚙️ soundness-cli kuruluyor..."
soundnessup install

# Güncelleme
echo "🔁 soundness-cli güncelleniyor..."
soundnessup update

# Kontrol
if command -v soundness-cli &> /dev/null; then
    echo "✅ soundness-cli başarıyla kuruldu!"
else
    echo "❌ soundness-cli bulunamadı. Lütfen shell'i yeniden başlatın."
fi

echo "🎉 Kurulum tamamlandı!"
echo "✅ PATH eklendi. Lütfen terminalde şu komutları çalıştırın:"
echo "▶ source ~/.bashrc"
echo "▶ soundnessup install"
echo "▶ soundnessup update"
