#!/bin/bash

echo "🚀 Soundness ortam kurulumu başlıyor..."

# Sistem güncellemesi
sudo apt update -y && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Gerekli paketler
sudo apt install -y curl git build-essential pkg-config libssl-dev libreadline-dev libffi-dev protobuf-compiler dos2unix

# Rust kurulumu
echo "🦀 Rust kuruluyor..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Rust ortam değişkeni
source "$HOME/.cargo/env"
echo 'source "$HOME/.cargo/env"' >> ~/.bashrc

# soundnessup kurulumu
echo "📥 soundnessup indiriliyor..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# PATH güncellemesi
echo 'export PATH="$HOME/.soundness/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# soundness-cli kurulumu
echo "⚙️ soundness-cli kuruluyor..."
soundnessup install
soundnessup update

# Kontrol
if command -v soundness-cli &> /dev/null; then
    echo "✅ soundness-cli başarıyla kuruldu!"
else
    echo "❌ soundness-cli bulunamadı. Lütfen shell'i yeniden başlatın."
fi

echo "🎉 Kurulum tamamlandı!"
