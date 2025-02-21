# Akash Provider GPU VM CONFIDENTIAL AZURE H100 Attestation
- Onboarding: https://github.com/Azure/az-cgpu-onboarding/tree/main
- Follow this steps:  https://github.com/Azure/az-cgpu-onboarding/blob/main/docs/Confidential-GPU-H100-Manual-Installation-(PMK-with-Powershell).md#Workload-Running and https://github.com/Azure/az-cgpu-onboarding/blob/main/docs/Confidential-GPU-H100-Onboarding-(PMK-with-Bash).md

## Infra req and setup
- https://learn.microsoft.com/en-us/azure/confidential-computing/confidential-vm-overview
- https://learn.microsoft.com/en-us/azure/confidential-computing/gpu-options
  
## Tech deep dive
- https://techcommunity.microsoft.com/blog/azure-ai-services-blog/azure-ai-confidential-inferencing-preview/4248181
- https://techcommunity.microsoft.com/blog/azureconfidentialcomputingblog/azure-ai-confidential-inferencing-technical-deep-dive/4253150
- https://learn.microsoft.com/en-us/azure/container-instances/confidential-containers-attestation-concepts
- https://learn.microsoft.com/en-us/azure/confidential-computing/guest-attestation-example?tabs=linux
- https://github.com/edgelesssys/ego/tree/master/samples/azure_attestation

## steps
- # Download e extração do pacote
- wget https://github.com/Azure/az-cgpu-onboarding/releases/download/V3.2.2/cgpu-onboarding-package.tar.gz
- tar -xvf cgpu-onboarding-package.tar.gz
cd cgpu-onboarding-package

# Step 0: Preparar kernel e reboot
sudo bash step-0-prepare-kernel.sh
# Aguarde o reboot e reconecte

# Step 1: Instalar driver GPU e reboot
sudo bash step-1-install-gpu-driver.sh
# Aguarde o reboot e reconecte

# Step 2: Rodar attestation
sudo bash step-2-attestation.sh
