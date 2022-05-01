# Download e instalação do Firefox Release no Ubuntu 22.04

![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) 
![Kubuntu](https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white)
![Lubuntu](https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/firefox-desnap?style=for-the-badge)

## Proposal

O Ubuntu em sua versão 22.04 trouxe a proposta do Firefox através do formado em Snap como o padrão para as suas instalações e de algumas de suas flavours. O propósito deste Git é a instalação do Firefox em versão mais atual nessas distros através do download direto da Mozilla, com atualizações no próprio navegador.

O script irá baixar o Firefox dependendo das configurações de `locale` de idioma do seu sistema. Você poderá verificar isso digitando `locale | head -1`.

Este script em breve também poderá ser utilizado no Debian Stable ou Testing.

**Este script está em desenvolvimento, erros são esperados.**

## Notas

Este script irá verificar se o Firefox Snap está instalado e irá removê-lo. Então irá baixar e instalar a versão tarball dos servidores da Mozilla.

Em adição o script também irá _pinar_ a versão em Snap do Firefox para que a mesma não seja instalada novamente.

## Execução

- `git clone` este repo.
- Dê permissões de execução para o arquivo **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` para executar.