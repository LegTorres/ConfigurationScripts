#!/bin/bash
echo -e "---------------------------------------------------\n| CONFIGURACION POST INSTALACION DE MANJARO LINUX |\n---------------------------------------------------\n"

echo -e "BUSCANDO LOS REPOSITORIOS MAS RAPIDOS\n\n"
sudo pacman-mirrors -g

echo -e "\n\nACTUALIZANDO EL SISTEMA\n\n"
sudo pacman -Syyu --noconfirm

echo -e "\n\nINSTALANDO APLICACIONES DE USO GENERAL\n\n"
sudo pacman -S vim yt-dlp tilix handbrake audacity picard easytag gimp inkscape kdenlive krita calibre sigil strawberry brave-browser neofetch btop papirus-icon-theme klavaro --noconfirm

echo -e "\n\nINSTALANDO APLICACIONES DESDE EL REPOSITORIO AUR\n\n"
pamac install google-chrome sublime-text-4 microsoft-edge-stable-bin visual-studio-code-bin #--noconfirm

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

echo -e "\n\nINSTALANDO NVM\nDescargando el script de instalacion\n\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

echo -e "\n\nEditando los archivos '.zsh' y '.bashrc' para la instalacion de NodeJS\n\n"
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $HOME/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $HOME/.bashrc
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $HOME/.zshrc

source ~/.bashrc nvm install node
source ~/.bashrc nvm install --lts

echo -e "\n\nCONFIGURANDO ARCHIVO '.vimrc'\n\n"
echo -e "set number\nsyntax on\nset ts=4\nset background=dark\nset autoindent" >> .vimrc

echo -e "AGREGANDO neofetch A LOS ARCHIVOS '.zsh' y '.bashrc'"
echo "neofetch" >> $HOME/.bashrc
echo "neofetch" >> $HOME/.zshrc

echo -e "\n\nListo, configuracion terminada!!!\n"
