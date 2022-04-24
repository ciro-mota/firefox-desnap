# Download e instalação do Firefox Release no Ubuntu 22.04

![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) 
![Kubuntu](https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/padavan-collection?style=for-the-badge)

O Ubuntu em sua versão 22.04 trouxe a proposta do Firefox através do formado em Snap como o padrão para as suas instalações e de algumas de suas flavours. O propósito deste Git é a instalação do Firefox em versão mais atual no Ubuntu e Kubuntu através do download direto da própria Mozilla, com atualizações no próprio navegador.

Script irá baixar, dependendo de escolha do usuário, as versões em Inglês ou Português Brasil. Você poderá comentar estas entradas e adaptar o script para sua linguagem.

Outras flavours, se necessário serão adicionadas posteriormente.

Este script também pode ser utilizado no Debian Stable ou Testing com as DE GNOME ou Plasma.

**Este script está em desenvolvimento, erros são esperados.**

## Antes de executar

Você deverá desinstalar a versão em Snap do Firefox, apesar de ambas as versões poderem coexistir no mesmo sistema. Execute `snap remove firefox` para remover.

O Script também irá _pinar_ a versão em Snap do Firefox para que a mesma não seja instalada novamente.