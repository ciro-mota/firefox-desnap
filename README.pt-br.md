</p>

<table align="right">
 <tr><td><a href="https://github.com/ciro-mota/firefox-desnap/blob/main/README.md">:us: English</a></td></tr>
 <tr><td><a href="https://github.com/ciro-mota/firefox-desnap/blob/main/README.pt-br.md">:brazil: Português</a></td></tr>
</table>

<h2>Download e instalação do Firefox Release no Ubuntu 22.04, 22.10, 23.04, 23.10 e Debian Stable ou Testing</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge">
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white">
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
    <img alt="Kubuntu" src="https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white">
    <img alt="Lubuntu" src="https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white">
    <img alt="MATE" src="https://img.shields.io/badge/Ubuntu%20MATE-84A454.svg?style=for-the-badge&logo=Ubuntu-MATE&logoColor=white">
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white">
    <img alt="Last Commit" src="https://img.shields.io/github/last-commit/ciro-mota/Personal-Startpage?style=for-the-badge">
</p>

## 📑 Proposta

O Ubuntu em sua versão 22.04 trouxe a proposta do Firefox através do formado em Snap como o padrão para as suas instalações e em suas flavours. O propósito deste Git é a instalação do Firefox em versão mais atual nessas distros através do download direto da Mozilla, com atualizações no próprio navegador.

O script irá baixar o Firefox dependendo das configurações de `locale` de idioma do seu sistema. Você poderá verificar isso digitando `locale | head -1`.

Este script também pode fazer a instalação do Firefox versão mais recente no Debian Stable ou Testing, que normalmente conta com a versão ESR instalada.

**Este script está em desenvolvimento, erros são esperados. Em caso de erros por favor reporte-os na guia Issues para correção.**

## 📌 Notas

- O script irá verificar se você possui as versões em Snap ou ESR instaladas, caso contrário a versão versão mais recente poderá ser instalada e ambas poderão coexistir normalmente no mesmo sistema.

- Se você escolher executar este script pelo modo automático, o script irá remover automaticamente o Firefox Snap ou o ESR e irá instalar a versão latest no formato tarball como substituição das versões nativa do sistema.

- Manualmente, o script irá desinstalar as versões em Snap ou ESR e irá solicitar confirmação para a instalação da versão versão mais recente em tarball.

- Em adição a isso o script também irá _pinar_ a versão em Snap do Firefox para que a mesma não seja instalada novamente.

- Se você usa o Debian na versão GNOME, o mesmo exige que um navegador (seja o Firefox ESR ou o Chromium) esteja instalado no sistema. Neste caso ao escolher remover o Firefox ESR o Chromium será automaticamente instalado.

## 🚀 Execução

- `git clone` este repo.
- Dê permissões de execução para o arquivo **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` para executar.