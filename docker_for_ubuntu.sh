#!/bin/bash
# Останавливаем Docker службы
sudo systemctl stop docker
sudo systemctl stop containerd

# Удаляем Docker пакеты
sudo apt remove -y docker docker-engine docker.io containerd runc docker-ce docker-ce-cli containerd.io

# Удаляем ВСЕ файлы конфигурации Docker
sudo rm -rf /etc/apt/sources.list.d/docker*
sudo rm -rf /etc/apt/keyrings/docker*
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd


sudo apt autoremove -y
sudo apt clean
sudo apt update

sudo apt install -y ca-certificates curl gnupg lsb-release


# Создаем директорию для ключей
sudo install -m 0755 -d /etc/apt/keyrings

# Скачиваем и добавляем GPG-ключ
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Добавляем репозиторий
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем список пакетов
sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Добавьте пользователя в группу docker
sudo usermod -aG docker $USER

# Перезагрузите систему
# sudo reboot

# Запускаем Docker службу
sudo systemctl start docker
sudo systemctl enable docker

# Проверяем статус
sudo systemctl status docker

# Добавляем пользователя в группу docker (замените на ваше имя пользователя если нужно)
sudo usermod -aG docker $USER
