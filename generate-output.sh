#!/bin/bash


docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Cours infrastructure-as-code" infrastructure-as-code.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Technologies de la détection d'intrusion:Linux" Techno_Supervision_Intrusion.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Technologies de la détection d'intrusion:Windows" Evenements-sous-windows.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf --author "Jean-Marc Pouchoulon" --description "Installation manuelle d'AD" installation_ad_en_images.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Joindre un DC manuelle en images" join_domain_en_images.md 
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Installation WEF policy en images" installation_wef_policy_en_images.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pdf  --author "Jean-Marc Pouchoulon" --description "Installation WEC en images" installation_wec.md



docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Cours infrastructure-as-code" infrastructure-as-code.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Technologies de la détection d'intrusion:Linux" Techno_Supervision_Intrusion.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Technologies de la détection d'intrusion:Windows" Evenements-sous-windows.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Installation manuelle d'AD" installation_ad_en_images.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Joindre un DC manuelle en images" join_domain_en_images.md 
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Installation WEF policy en images" installation_wef_policy_en_images.md
# docker run --rm --init -v $PWD:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" -e LANG=$LANG marpteam/marp-cli --allow-local-files --html --pptx  --author "Jean-Marc Pouchoulon" --description "Installation WEC en images" installation_wec.md

mv infrastructure-as-code.pdf ./pdfs/
# mv Techno_Supervision_Intrusion.pdf ./pdfs/
# mv Evenements-sous-windows.pdf ./pdfs/
# mv installation_ad_en_images.pdf ./pdfs/
# mv join_domain_en_images.pdf ./pdfs/
# mv installation_wef_policy_en_images.pdf ./pdfs/
# mv installation_wec.pdf ./pdfs/

# TP

if [ -f "TP-vagrant.pdf" ]; then
     mv TP-vagrant.pdf ./pdfs/
fi
if [ -f "TP-packer.pdf" ]; then
     mv TP-packer.pdf ./pdfs/
fi
if [ -f "TP-vagrant-windows.pdf" ]; then
     mv TP-vagrant-windows.pdf ./pdfs/
fi

if [ -f "TP-terraform.pdf" ] ; then
     mv TP-terraform.pdf ./pdfs/
fi

# if [ -f "TD-base-windowsAD.pdf" ] ; then
#     mv TD-base-windowsAD.pdf ./pdfs/
# fi

# if [ -f "TD-Linux-events.pdf" ] ; then
#     mv TD-Linux-events.pdf ./pdfs/
# fi

# if [ -f "TD-sigma-app.pdf" ]; then
#     mv TD-sigma-app.pdf ./pdfs/
# fi

# # TP
# if [ -f "TP-DOMAINBASE.pdf" ]; then
#     mv TP-DOMAINBASE.pdf ./pdfs/
# fi

# if [ -f "TP-WEC-WEF.pdf" ]; then
#     mv TP-WEC-WEF.pdf ./pdfs/
# fi

# if [ -f "TP-ELASTIC.pdf" ]; then
#     mv TP-ELASTIC.pdf ./pdfs/
# fi

# if [ -f "TP-detection-intrusion-reseaux.pdf" ]; then
#     mv TP-detection-intrusion-reseaux.pdf ./pdfs/
# fi

# if [ -f "TP-WAZUH-AUDITD-TPOT-SURICATA.pdf" ]; then
#     mv TP-WAZUH-AUDITD-TPOT-SURICATA.pdf ./pdfs/
# fi


gs -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -sOutputFile="pdfs/infrastructure-as-code-slim.pdf" -f "pdfs/infrastructure-as-code.pdf"
rm -f "pdfs/infrastructure-as-code.pdf"
mv "pdfs/infrastructure-as-code-slim.pdf" "pdfs/infrastructure-as-code.pdf"
mv infrastructure-as-code.pptx ./pptx/
# mv Techno_Supervision_Intrusion.pptx ./pptx/
# mv Evenements-sous-windows.pptx ./pptx/
# mv installation_ad_en_images.pptx ./pptx/
# mv join_domain_en_images.pptx ./pptx/
# mv installation_wef_policy_en_images.pptx ./pptx/
# mv installation_wec.pptx ./pptx/
