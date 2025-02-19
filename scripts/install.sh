#!/bin/bash

echo "Criando diretório para cgpu-onboarding-package..."
sudo mkdir -p /opt/cgpu-onboarding-package

echo "Verificando se o pacote cgpu-onboarding-package existe..."
if [ ! -d "$HOME/cgpu-onboarding-package" ]; then
    echo "Erro: cgpu-onboarding-package não encontrado em $HOME"
    echo "Por favor, execute os passos de onboarding primeiro"
    exit 1
fi

echo "Copiando pacote para /opt/cgpu-onboarding-package..."
sudo cp -r $HOME/cgpu-onboarding-package/* /opt/cgpu-onboarding-package/

echo "Ajustando permissões..."
sudo chmod -R +x /opt/cgpu-onboarding-package/*.sh

echo "Instalação concluída!"
echo "O pacote foi instalado em /opt/cgpu-onboarding-package"