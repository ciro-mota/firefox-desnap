# Download e instalação do Firefox Release no Ubuntu 22.04 e Debian Stable ou Testing

![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) 
![Kubuntu](https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white)
![Lubuntu](https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/firefox-desnap?style=for-the-badge)

## Proposta

O Ubuntu em sua versão 22.04 trouxe a proposta do Firefox através do formado em Snap como o padrão para as suas instalações e de algumas de suas flavours. O propósito deste Git é a instalação do Firefox em versão mais atual nessas distros através do download direto da Mozilla, com atualizações no próprio navegador.

O script irá baixar o Firefox dependendo das configurações de `locale` de idioma do seu sistema. Você poderá verificar isso digitando `locale | head -1`.

Este script também pode fazer a instalação do Firefox versão mais recente no Debian Stable ou Testing, que normalmente conta com a versão ESR instalada.

**Este script está em desenvolvimento, erros são esperados. Em caso de erros por favor reporte-os na guia Issues para correção.**

## Notas

- O script irá verificar se você possui as versões em Snap ou ESR instaladas, caso contrário a versão versão mais recente poderá ser instalada e ambas poderão coexistir normalmente no mesmo sistema.

- Caso opte, o script irá desinstalar as versões em Snap ou ESR e irá solicitar confirmação para a instalação da versão versão mais recente.

- Em adição a isso o script também irá _pinar_ a versão em Snap do Firefox para que a mesma não seja instalada novamente.

- Se você usa o Debian na versão GNOME, o mesmo exige que um navegador (seja o Firefox ESR ou o Chromium) esteja instalado no sistema. Neste caso ao escolher remover o Firefox ESR o Chromium será automaticamente instalado.

## Execução

- `git clone` este repo.
- Dê permissões de execução para o arquivo **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` para executar.