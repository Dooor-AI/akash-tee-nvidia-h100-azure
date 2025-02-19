# scripts/setup-attestation.sh

#!/bin/bash

# Criar diretório para onboarding
echo "Criando diretório de onboarding..."
sudo mkdir -p /home/cgpu-onboarding

# Copiar pacote para diretório padrão
echo "Copiando pacote..."
sudo cp -r ~/cgpu-onboarding-package/* /home/cgpu-onboarding/
cd /home/cgpu-onboarding/cgpu-onboarding-package

# Ajustar permissões
echo "Ajustando permissões..."
sudo chmod -R +x *.sh

# Verificar se attestation funciona
echo "Testando attestation..."
sudo bash step-2-attestation.sh

echo "Setup completo!"