#!/bin/sh
EXEC=$(echo "exec ss_sp_manutencao_banco_de_dados_checagem" | isql -b -dx MSSQL-discador dss dss88340566)

if [ $EXEC -eq 0 ]; then
    echo  "1"
else
    echo "0"
fi
