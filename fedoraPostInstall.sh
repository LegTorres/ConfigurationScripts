#!/bin/bash

echo -e "--------------------------------------------------\n| CONFIGURACION POST INSTALACION DE FEDORA LINUX |\n--------------------------------------------------\n"

echo -e "\n\nACTUALIZANDO EL SISTEMA\n\n"
sudo dnf update --noconfirm

echo -e "\n\nINSTALANDO APLICACIONES DE USO GENERAL\n\n"
sudo dnf install zsh vim yt-dlp tilix handbrake audacity picard easytag gimp inkscape kdenlive krita calibre sigil strawberry brave-browser fastfetch btop papirus-icon-theme klavaro --noconfirm

echo -e "\n\nCONFIGURANDO GIT\nEstableciendo en nombre de la rama principal a main"
git config --global init.defaultBranch main
echo "Ingrese su nombre de USUARIO"
read gitUser
git config --global user.name $gitUser
echo "Ingrese su EMAIL"
read gitEmail
git config --global user.email $gitEmail

echo -e "\n\nGENERANDO CLAVE SSH\n\n"
ssh-keygen -t rsa -b 4096 -C $gitEmail
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_rsa

echo -e "CREANDO EL ALIAS 'remoto' PARA ACTIVAR EL AGENTE SSH\n\n"
echo alias remoto="'eval \$(ssh-agent -s) && ssh-add \$HOME/.ssh/id_rsa'" >> $HOME/.zshrc
echo alias remoto="'eval \$(ssh-agent -s) && ssh-add \$HOME/.ssh/id_rsa'" >> $HOME/.bashrc

# Personalizando SZH con oh-my-zsh
echo -e "INSTALANDO OH-MY-ZSH\n\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "INSTALANDO EL TEMA POWERLEVEL10K\n\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc >> .zshrc
p10k configure

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "AGREGANDO neofetch A LOS ARCHIVOS '.zsh' y '.bashrc'"
echo "fastfetch" >> $HOME/.bashrc
echo "fastfetch" >> $HOME/.zshrc

echo -e "\n\nListo, configuracion terminada!!!\n"
