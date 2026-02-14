#!/bin/bash

# Vercel Deploy Hook
DEPLOY_HOOK="https://api.vercel.com/v1/integrations/deploy/prj_u4GiOEA1ZVMmAST3LzLBNaZDsdRB/FgikAU4wiP"

# Farben für die Ausgabe
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Banner ausgeben
echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}     🚀 Vercel Auto-Deployment     ${NC}"
echo -e "${GREEN}====================================${NC}"

# Git-Status prüfen
echo -e "\n${YELLOW}Aktueller Git-Status:${NC}"
git status --short

# Abfrage, ob fortgefahren werden soll
read -p "Änderungen pushen und deployen? (j/n) " choice
case "$choice" in 
  j|J|y|Y ) 
    # Alles committen und pushen
    echo -e "\n${YELLOW}Pushe Änderungen...${NC}"
    git push
    
    # Vercel neu deployen
    echo -e "\n${YELLOW}Starte Vercel-Deployment...${NC}"
    curl -s -X POST "$DEPLOY_HOOK"
    
    echo -e "\n${GREEN}✅ Deployment gestartet!${NC}"
    echo -e "${YELLOW}Prüfe Status: https://vercel.com/reglevs-projects/apps${NC}"
    ;;
  * ) 
    echo -e "\n${YELLOW}Abgebrochen. Keine Änderungen gepusht.${NC}"
    ;;
esac